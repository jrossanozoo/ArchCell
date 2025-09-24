
define class Din_EntidadCOSTODEINSUMOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_COSTODEINSUMO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [ListaDecosto + Insumo + Color + Taller + Proceso]
	cExpresionCCPorCampos = [#tabla#.ListaCost + #tabla#.Insumo + #tabla#.COLORES + #tabla#.Taller + #tabla#.Proceso]
	cTagClaveCandidata = '_026CC'
	cTagClavePk = '_026PK'
	cTablaPrincipal = 'COSTOINS'
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
			local  lxCostoinsFecexpo, lxCostoinsFectrans, lxCostoinsFecimpo, lxCostoinsFaltafw, lxCostoinsFmodifw, lxCostoinsTimestamp, lxCostoinsUaltafw, lxCostoinsSaltafw, lxCostoinsSmodifw, lxCostoinsUmodifw, lxCostoinsVmodifw, lxCostoinsDescfw, lxCostoinsHmodifw, lxCostoinsZadsfw, lxCostoinsValtafw, lxCostoinsHoraexpo, lxCostoinsHoraimpo, lxCostoinsBdmodifw, lxCostoinsEsttrans, lxCostoinsBdaltafw, lxCostoinsHaltafw, lxCostoinsListacost, lxCostoinsInsumo, lxCostoinsCodigo, lxCostoinsColores, lxCostoinsProceso, lxCostoinsTaller, lxCostoinsCantidad
				lxCostoinsFecexpo =  .Fechaexpo			lxCostoinsFectrans =  .Fechatransferencia			lxCostoinsFecimpo =  .Fechaimpo			lxCostoinsFaltafw =  .Fechaaltafw			lxCostoinsFmodifw =  .Fechamodificacionfw			lxCostoinsTimestamp = goLibrerias.ObtenerTimestamp()			lxCostoinsUaltafw =  .Usuarioaltafw			lxCostoinsSaltafw =  .Seriealtafw			lxCostoinsSmodifw =  .Seriemodificacionfw			lxCostoinsUmodifw =  .Usuariomodificacionfw			lxCostoinsVmodifw =  .Versionmodificacionfw			lxCostoinsDescfw =  .Descripcionfw			lxCostoinsHmodifw =  .Horamodificacionfw			lxCostoinsZadsfw =  .Zadsfw			lxCostoinsValtafw =  .Versionaltafw			lxCostoinsHoraexpo =  .Horaexpo			lxCostoinsHoraimpo =  .Horaimpo			lxCostoinsBdmodifw =  .Basededatosmodificacionfw			lxCostoinsEsttrans =  .Estadotransferencia			lxCostoinsBdaltafw =  .Basededatosaltafw			lxCostoinsHaltafw =  .Horaaltafw			lxCostoinsListacost =  upper( .ListaDecosto_PK ) 			lxCostoinsInsumo =  upper( .Insumo_PK ) 			lxCostoinsCodigo =  .Codigo			lxCostoinsColores =  upper( .Color_PK ) 			lxCostoinsProceso =  upper( .Proceso_PK ) 			lxCostoinsTaller =  upper( .Taller_PK ) 			lxCostoinsCantidad =  .Desdecantidad
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCostoinsCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.COSTOINS ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Timestamp","Ualtafw","Saltafw","Smodifw","Umodifw","Vmodifw","Descfw","Hmodifw","Zadsfw","Valtafw","Horaexpo","Horaimpo","Bdmodifw","Esttrans","Bdaltafw","Haltafw","Listacost","Insumo","Codigo","Colores","Proceso","Taller","Cantidad" ) values ( <<"'" + this.ConvertirDateSql( lxCostoinsFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCostoinsFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCostoinsFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCostoinsFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCostoinsFmodifw ) + "'" >>, <<lxCostoinsTimestamp >>, <<"'" + this.FormatearTextoSql( lxCostoinsUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsListacost ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsInsumo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsColores ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsProceso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsTaller ) + "'" >>, <<lxCostoinsCantidad >> )
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
		this.oEntidad.Timestamp = lxCostoinsTimestamp
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
			local  lxCostoinsFecexpo, lxCostoinsFectrans, lxCostoinsFecimpo, lxCostoinsFaltafw, lxCostoinsFmodifw, lxCostoinsTimestamp, lxCostoinsUaltafw, lxCostoinsSaltafw, lxCostoinsSmodifw, lxCostoinsUmodifw, lxCostoinsVmodifw, lxCostoinsDescfw, lxCostoinsHmodifw, lxCostoinsZadsfw, lxCostoinsValtafw, lxCostoinsHoraexpo, lxCostoinsHoraimpo, lxCostoinsBdmodifw, lxCostoinsEsttrans, lxCostoinsBdaltafw, lxCostoinsHaltafw, lxCostoinsListacost, lxCostoinsInsumo, lxCostoinsCodigo, lxCostoinsColores, lxCostoinsProceso, lxCostoinsTaller, lxCostoinsCantidad
				lxCostoinsFecexpo =  .Fechaexpo			lxCostoinsFectrans =  .Fechatransferencia			lxCostoinsFecimpo =  .Fechaimpo			lxCostoinsFaltafw =  .Fechaaltafw			lxCostoinsFmodifw =  .Fechamodificacionfw			lxCostoinsTimestamp = goLibrerias.ObtenerTimestamp()			lxCostoinsUaltafw =  .Usuarioaltafw			lxCostoinsSaltafw =  .Seriealtafw			lxCostoinsSmodifw =  .Seriemodificacionfw			lxCostoinsUmodifw =  .Usuariomodificacionfw			lxCostoinsVmodifw =  .Versionmodificacionfw			lxCostoinsDescfw =  .Descripcionfw			lxCostoinsHmodifw =  .Horamodificacionfw			lxCostoinsZadsfw =  .Zadsfw			lxCostoinsValtafw =  .Versionaltafw			lxCostoinsHoraexpo =  .Horaexpo			lxCostoinsHoraimpo =  .Horaimpo			lxCostoinsBdmodifw =  .Basededatosmodificacionfw			lxCostoinsEsttrans =  .Estadotransferencia			lxCostoinsBdaltafw =  .Basededatosaltafw			lxCostoinsHaltafw =  .Horaaltafw			lxCostoinsListacost =  upper( .ListaDecosto_PK ) 			lxCostoinsInsumo =  upper( .Insumo_PK ) 			lxCostoinsCodigo =  .Codigo			lxCostoinsColores =  upper( .Color_PK ) 			lxCostoinsProceso =  upper( .Proceso_PK ) 			lxCostoinsTaller =  upper( .Taller_PK ) 			lxCostoinsCantidad =  .Desdecantidad
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
				update ZooLogic.COSTOINS set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCostoinsFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCostoinsFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCostoinsFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCostoinsFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCostoinsFmodifw ) + "'">>,"Timestamp" = <<lxCostoinsTimestamp>>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCostoinsUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCostoinsSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCostoinsSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCostoinsUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCostoinsVmodifw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxCostoinsDescfw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCostoinsHmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCostoinsZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCostoinsValtafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCostoinsHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCostoinsHoraimpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCostoinsBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCostoinsEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCostoinsBdaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCostoinsHaltafw ) + "'">>,"Listacost" = <<"'" + this.FormatearTextoSql( lxCostoinsListacost ) + "'">>,"Insumo" = <<"'" + this.FormatearTextoSql( lxCostoinsInsumo ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCostoinsCodigo ) + "'">>,"Colores" = <<"'" + this.FormatearTextoSql( lxCostoinsColores ) + "'">>,"Proceso" = <<"'" + this.FormatearTextoSql( lxCostoinsProceso ) + "'">>,"Taller" = <<"'" + this.FormatearTextoSql( lxCostoinsTaller ) + "'">>,"Cantidad" = <<lxCostoinsCantidad>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCostoinsCodigo ) + "'">> and  COSTOINS.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxCostoinsTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.COSTOINS where " + this.ConvertirFuncionesSql( " COSTOINS.CODIGO != ''" ) )
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
			Local lxCostoinsCodigo
			lxCostoinsCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Listacost" as "Listadecosto", "Insumo" as "Insumo", "Codigo" as "Codigo", "Colores" as "Color", "Proceso" as "Proceso", "Taller" as "Taller", "Cantidad" as "Desdecantidad" from ZooLogic.COSTOINS where "Codigo" = <<"'" + this.FormatearTextoSql( lxCostoinsCodigo ) + "'">> and  COSTOINS.CODIGO != ''
			endtext
			use in select('c_COSTODEINSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COSTODEINSUMO', set( 'Datasession' ) )

			if reccount( 'c_COSTODEINSUMO' ) = 0
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
			Local lxCOSTOINSListaCost As Variant, lxCOSTOINSInsumo As Variant, lxCOSTOINSCOLORES As Variant, lxCOSTOINSTaller As Variant, lxCOSTOINSProceso As Variant
			lxCOSTOINSListaCost = .ListaDecosto_Pk
			lxCOSTOINSInsumo = .Insumo_Pk
			lxCOSTOINSCOLORES = .Color_Pk
			lxCOSTOINSTaller = .Taller_Pk
			lxCOSTOINSProceso = .Proceso_Pk
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Listacost" as "Listadecosto", "Insumo" as "Insumo", "Codigo" as "Codigo", "Colores" as "Color", "Proceso" as "Proceso", "Taller" as "Taller", "Cantidad" as "Desdecantidad" from ZooLogic.COSTOINS where  COSTOINS.CODIGO != '' And ListaCost = <<"'" + this.FormatearTextoSql( lxCOSTOINSListaCost ) + "'">> and Insumo = <<"'" + this.FormatearTextoSql( lxCOSTOINSInsumo ) + "'">> and COLORES = <<"'" + this.FormatearTextoSql( lxCOSTOINSCOLORES ) + "'">> and Taller = <<"'" + this.FormatearTextoSql( lxCOSTOINSTaller ) + "'">> and Proceso = <<"'" + this.FormatearTextoSql( lxCOSTOINSProceso ) + "'">>
			endtext
			use in select('c_COSTODEINSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COSTODEINSUMO', set( 'Datasession' ) )
			if reccount( 'c_COSTODEINSUMO' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCostoinsCodigo as Variant
		llRetorno = .t.
		lxCostoinsCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.COSTOINS where "Codigo" = <<"'" + this.FormatearTextoSql( lxCostoinsCodigo ) + "'">> and  COSTOINS.CODIGO != ''
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
				lcOrden =  .ListaDecosto_PK + .Insumo_PK + .Color_PK + .Taller_PK + .Proceso_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Listacost" as "Listadecosto", "Insumo" as "Insumo", "Codigo" as "Codigo", "Colores" as "Color", "Proceso" as "Proceso", "Taller" as "Taller", "Cantidad" as "Desdecantidad" from ZooLogic.COSTOINS where  COSTOINS.CODIGO != '' order by ListaCost,Insumo,COLORES,Taller,Proceso
			endtext
			use in select('c_COSTODEINSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COSTODEINSUMO', set( 'Datasession' ) )
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
				lcOrden =  .ListaDecosto_PK + .Insumo_PK + .Color_PK + .Taller_PK + .Proceso_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Listacost" as "Listadecosto", "Insumo" as "Insumo", "Codigo" as "Codigo", "Colores" as "Color", "Proceso" as "Proceso", "Taller" as "Taller", "Cantidad" as "Desdecantidad" from ZooLogic.COSTOINS where  funciones.padr( ListaCost, 6, ' ' ) + funciones.padr( Insumo, 23, ' ' ) + funciones.padr( COLORES, 2, ' ' ) + funciones.padr( Taller, 10, ' ' ) + funciones.padr( Proceso, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COSTOINS.CODIGO != '' order by ListaCost,Insumo,COLORES,Taller,Proceso
			endtext
			use in select('c_COSTODEINSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COSTODEINSUMO', set( 'Datasession' ) )
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
				lcOrden =  .ListaDecosto_PK + .Insumo_PK + .Color_PK + .Taller_PK + .Proceso_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Listacost" as "Listadecosto", "Insumo" as "Insumo", "Codigo" as "Codigo", "Colores" as "Color", "Proceso" as "Proceso", "Taller" as "Taller", "Cantidad" as "Desdecantidad" from ZooLogic.COSTOINS where  funciones.padr( ListaCost, 6, ' ' ) + funciones.padr( Insumo, 23, ' ' ) + funciones.padr( COLORES, 2, ' ' ) + funciones.padr( Taller, 10, ' ' ) + funciones.padr( Proceso, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COSTOINS.CODIGO != '' order by ListaCost desc,Insumo desc,COLORES desc,Taller desc,Proceso desc
			endtext
			use in select('c_COSTODEINSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COSTODEINSUMO', set( 'Datasession' ) )
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
				lcOrden =  .ListaDecosto_PK + .Insumo_PK + .Color_PK + .Taller_PK + .Proceso_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Listacost" as "Listadecosto", "Insumo" as "Insumo", "Codigo" as "Codigo", "Colores" as "Color", "Proceso" as "Proceso", "Taller" as "Taller", "Cantidad" as "Desdecantidad" from ZooLogic.COSTOINS where  COSTOINS.CODIGO != '' order by ListaCost desc,Insumo desc,COLORES desc,Taller desc,Proceso desc
			endtext
			use in select('c_COSTODEINSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COSTODEINSUMO', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Timestamp,Ualtafw,Saltafw,Smodifw,Umodifw,Vmodifw,D" + ;
"escfw,Hmodifw,Zadsfw,Valtafw,Horaexpo,Horaimpo,Bdmodifw,Esttrans,Bdaltafw,Haltafw,Listacost,Insumo,C" + ;
"odigo,Colores,Proceso,Taller,Cantidad" + ;
" from ZooLogic.COSTOINS where  COSTOINS.CODIGO != '' and " + lcFiltro )
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
			local  lxCostoinsFecexpo, lxCostoinsFectrans, lxCostoinsFecimpo, lxCostoinsFaltafw, lxCostoinsFmodifw, lxCostoinsTimestamp, lxCostoinsUaltafw, lxCostoinsSaltafw, lxCostoinsSmodifw, lxCostoinsUmodifw, lxCostoinsVmodifw, lxCostoinsDescfw, lxCostoinsHmodifw, lxCostoinsZadsfw, lxCostoinsValtafw, lxCostoinsHoraexpo, lxCostoinsHoraimpo, lxCostoinsBdmodifw, lxCostoinsEsttrans, lxCostoinsBdaltafw, lxCostoinsHaltafw, lxCostoinsListacost, lxCostoinsInsumo, lxCostoinsCodigo, lxCostoinsColores, lxCostoinsProceso, lxCostoinsTaller, lxCostoinsCantidad
				lxCostoinsFecexpo = ctod( '  /  /    ' )			lxCostoinsFectrans = ctod( '  /  /    ' )			lxCostoinsFecimpo = ctod( '  /  /    ' )			lxCostoinsFaltafw = ctod( '  /  /    ' )			lxCostoinsFmodifw = ctod( '  /  /    ' )			lxCostoinsTimestamp = goLibrerias.ObtenerTimestamp()			lxCostoinsUaltafw = []			lxCostoinsSaltafw = []			lxCostoinsSmodifw = []			lxCostoinsUmodifw = []			lxCostoinsVmodifw = []			lxCostoinsDescfw = []			lxCostoinsHmodifw = []			lxCostoinsZadsfw = []			lxCostoinsValtafw = []			lxCostoinsHoraexpo = []			lxCostoinsHoraimpo = []			lxCostoinsBdmodifw = []			lxCostoinsEsttrans = []			lxCostoinsBdaltafw = []			lxCostoinsHaltafw = []			lxCostoinsListacost = []			lxCostoinsInsumo = []			lxCostoinsCodigo = []			lxCostoinsColores = []			lxCostoinsProceso = []			lxCostoinsTaller = []			lxCostoinsCantidad = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.COSTOINS where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'COSTOINS' + '_' + tcCampo
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
		lcWhere = " Where  COSTOINS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Listacost" as "Listadecosto", "Insumo" as "Insumo", "Codigo" as "Codigo", "Colores" as "Color", "Proceso" as "Proceso", "Taller" as "Taller", "Cantidad" as "Desdecantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COSTOINS', '', tnTope )
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
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'LISTADECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LISTACOST AS LISTADECOSTO'
				Case lcAtributo == 'INSUMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INSUMO AS INSUMO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLORES AS COLOR'
				Case lcAtributo == 'PROCESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCESO AS PROCESO'
				Case lcAtributo == 'TALLER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLER AS TALLER'
				Case lcAtributo == 'DESDECANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS DESDECANTIDAD'
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
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADECOSTO'
				lcCampo = 'LISTACOST'
			Case upper( alltrim( tcAtributo ) ) == 'INSUMO'
				lcCampo = 'INSUMO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'COLORES'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESO'
				lcCampo = 'PROCESO'
			Case upper( alltrim( tcAtributo ) ) == 'TALLER'
				lcCampo = 'TALLER'
			Case upper( alltrim( tcAtributo ) ) == 'DESDECANTIDAD'
				lcCampo = 'CANTIDAD'
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
			local  lxCostoinsFecexpo, lxCostoinsFectrans, lxCostoinsFecimpo, lxCostoinsFaltafw, lxCostoinsFmodifw, lxCostoinsTimestamp, lxCostoinsUaltafw, lxCostoinsSaltafw, lxCostoinsSmodifw, lxCostoinsUmodifw, lxCostoinsVmodifw, lxCostoinsDescfw, lxCostoinsHmodifw, lxCostoinsZadsfw, lxCostoinsValtafw, lxCostoinsHoraexpo, lxCostoinsHoraimpo, lxCostoinsBdmodifw, lxCostoinsEsttrans, lxCostoinsBdaltafw, lxCostoinsHaltafw, lxCostoinsListacost, lxCostoinsInsumo, lxCostoinsCodigo, lxCostoinsColores, lxCostoinsProceso, lxCostoinsTaller, lxCostoinsCantidad
				lxCostoinsFecexpo =  .Fechaexpo			lxCostoinsFectrans =  .Fechatransferencia			lxCostoinsFecimpo =  .Fechaimpo			lxCostoinsFaltafw =  .Fechaaltafw			lxCostoinsFmodifw =  .Fechamodificacionfw			lxCostoinsTimestamp = goLibrerias.ObtenerTimestamp()			lxCostoinsUaltafw =  .Usuarioaltafw			lxCostoinsSaltafw =  .Seriealtafw			lxCostoinsSmodifw =  .Seriemodificacionfw			lxCostoinsUmodifw =  .Usuariomodificacionfw			lxCostoinsVmodifw =  .Versionmodificacionfw			lxCostoinsDescfw =  .Descripcionfw			lxCostoinsHmodifw =  .Horamodificacionfw			lxCostoinsZadsfw =  .Zadsfw			lxCostoinsValtafw =  .Versionaltafw			lxCostoinsHoraexpo =  .Horaexpo			lxCostoinsHoraimpo =  .Horaimpo			lxCostoinsBdmodifw =  .Basededatosmodificacionfw			lxCostoinsEsttrans =  .Estadotransferencia			lxCostoinsBdaltafw =  .Basededatosaltafw			lxCostoinsHaltafw =  .Horaaltafw			lxCostoinsListacost =  upper( .ListaDecosto_PK ) 			lxCostoinsInsumo =  upper( .Insumo_PK ) 			lxCostoinsCodigo =  .Codigo			lxCostoinsColores =  upper( .Color_PK ) 			lxCostoinsProceso =  upper( .Proceso_PK ) 			lxCostoinsTaller =  upper( .Taller_PK ) 			lxCostoinsCantidad =  .Desdecantidad
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.COSTOINS ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Timestamp","Ualtafw","Saltafw","Smodifw","Umodifw","Vmodifw","Descfw","Hmodifw","Zadsfw","Valtafw","Horaexpo","Horaimpo","Bdmodifw","Esttrans","Bdaltafw","Haltafw","Listacost","Insumo","Codigo","Colores","Proceso","Taller","Cantidad" ) values ( <<"'" + this.ConvertirDateSql( lxCostoinsFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCostoinsFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCostoinsFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCostoinsFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCostoinsFmodifw ) + "'" >>, <<lxCostoinsTimestamp >>, <<"'" + this.FormatearTextoSql( lxCostoinsUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsListacost ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsInsumo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsColores ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsProceso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCostoinsTaller ) + "'" >>, <<lxCostoinsCantidad >> )
		endtext
		loColeccion.cTabla = 'COSTOINS' 
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
			local  lxCostoinsFecexpo, lxCostoinsFectrans, lxCostoinsFecimpo, lxCostoinsFaltafw, lxCostoinsFmodifw, lxCostoinsTimestamp, lxCostoinsUaltafw, lxCostoinsSaltafw, lxCostoinsSmodifw, lxCostoinsUmodifw, lxCostoinsVmodifw, lxCostoinsDescfw, lxCostoinsHmodifw, lxCostoinsZadsfw, lxCostoinsValtafw, lxCostoinsHoraexpo, lxCostoinsHoraimpo, lxCostoinsBdmodifw, lxCostoinsEsttrans, lxCostoinsBdaltafw, lxCostoinsHaltafw, lxCostoinsListacost, lxCostoinsInsumo, lxCostoinsCodigo, lxCostoinsColores, lxCostoinsProceso, lxCostoinsTaller, lxCostoinsCantidad
				lxCostoinsFecexpo =  .Fechaexpo			lxCostoinsFectrans =  .Fechatransferencia			lxCostoinsFecimpo =  .Fechaimpo			lxCostoinsFaltafw =  .Fechaaltafw			lxCostoinsFmodifw =  .Fechamodificacionfw			lxCostoinsTimestamp = goLibrerias.ObtenerTimestamp()			lxCostoinsUaltafw =  .Usuarioaltafw			lxCostoinsSaltafw =  .Seriealtafw			lxCostoinsSmodifw =  .Seriemodificacionfw			lxCostoinsUmodifw =  .Usuariomodificacionfw			lxCostoinsVmodifw =  .Versionmodificacionfw			lxCostoinsDescfw =  .Descripcionfw			lxCostoinsHmodifw =  .Horamodificacionfw			lxCostoinsZadsfw =  .Zadsfw			lxCostoinsValtafw =  .Versionaltafw			lxCostoinsHoraexpo =  .Horaexpo			lxCostoinsHoraimpo =  .Horaimpo			lxCostoinsBdmodifw =  .Basededatosmodificacionfw			lxCostoinsEsttrans =  .Estadotransferencia			lxCostoinsBdaltafw =  .Basededatosaltafw			lxCostoinsHaltafw =  .Horaaltafw			lxCostoinsListacost =  upper( .ListaDecosto_PK ) 			lxCostoinsInsumo =  upper( .Insumo_PK ) 			lxCostoinsCodigo =  .Codigo			lxCostoinsColores =  upper( .Color_PK ) 			lxCostoinsProceso =  upper( .Proceso_PK ) 			lxCostoinsTaller =  upper( .Taller_PK ) 			lxCostoinsCantidad =  .Desdecantidad
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COSTOINS.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.COSTOINS set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCostoinsFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCostoinsFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCostoinsFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCostoinsFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCostoinsFmodifw ) + "'">>, "Timestamp" = <<lxCostoinsTimestamp>>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCostoinsUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCostoinsSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCostoinsSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCostoinsUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCostoinsVmodifw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxCostoinsDescfw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCostoinsHmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCostoinsZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCostoinsValtafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCostoinsHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCostoinsHoraimpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCostoinsBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCostoinsEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCostoinsBdaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCostoinsHaltafw ) + "'">>, "Listacost" = <<"'" + this.FormatearTextoSql( lxCostoinsListacost ) + "'">>, "Insumo" = <<"'" + this.FormatearTextoSql( lxCostoinsInsumo ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCostoinsCodigo ) + "'">>, "Colores" = <<"'" + this.FormatearTextoSql( lxCostoinsColores ) + "'">>, "Proceso" = <<"'" + this.FormatearTextoSql( lxCostoinsProceso ) + "'">>, "Taller" = <<"'" + this.FormatearTextoSql( lxCostoinsTaller ) + "'">>, "Cantidad" = <<lxCostoinsCantidad>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COSTOINS' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COSTOINS.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.COSTOINS where ' + lcFiltro )
			loColeccion.cTabla = 'COSTOINS' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.COSTOINS where  COSTOINS.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.COSTOINS where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  COSTOINS.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCOSTOINSListaCost as variant, lxCOSTOINSInsumo as variant, lxCOSTOINSCOLORES as variant, lxCOSTOINSProceso as variant, lxCOSTOINSTaller as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'COSTODEINSUMO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.COSTOINS Where  ListaCost = ] + "'" + this.FormatearTextoSql( &lcCursor..ListaCost  ) + "'" + [ and Insumo = ] + "'" + this.FormatearTextoSql( &lcCursor..Insumo     ) + "'" + [ and COLORES = ] + "'" + this.FormatearTextoSql( &lcCursor..COLORES    ) + "'" + [ and Taller = ] + "'" + this.FormatearTextoSql( &lcCursor..Taller     ) + "'" + [ and Proceso = ] + "'" + this.FormatearTextoSql( &lcCursor..Proceso    ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..CODIGO
				if lxValorClavePK == curSeek.CODIGO or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.CODIGO and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.CODIGO
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.COSTOINS set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, ListaCost = ] + "'" + this.FormatearTextoSql( &lcCursor..ListaCost ) + "'"+ [, Insumo = ] + "'" + this.FormatearTextoSql( &lcCursor..Insumo ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, COLORES = ] + "'" + this.FormatearTextoSql( &lcCursor..COLORES ) + "'"+ [, Proceso = ] + "'" + this.FormatearTextoSql( &lcCursor..Proceso ) + "'"+ [, Taller = ] + "'" + this.FormatearTextoSql( &lcCursor..Taller ) + "'"+ [, Cantidad = ] + transform( &lcCursor..Cantidad ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.COSTOINS Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FECTRANS, FECIMPO, FALTAFW, FMODIFW, TIMESTAMP, UALTAFW, SALTAFW, SMODIFW, UMODIFW, VMODIFW, DescFW, HMODIFW, ZADSFW, VALTAFW, HORAEXPO, HORAIMPO, BDMODIFW, ESTTRANS, BDALTAFW, HALTAFW, ListaCost, Insumo, CODIGO, COLORES, Proceso, Taller, Cantidad
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ListaCost ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Insumo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COLORES ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Proceso ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Taller ) + "'" + ',' + transform( &lcCursor..Cantidad )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.COSTOINS ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'COSTODEINSUMO'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO C (58) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Taller: ' + transform( &tcCursor..Taller     )
		lcRetorno = lcRetorno + ' - Proceso: ' + transform( &tcCursor..Proceso    )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'COSTODEINSUMO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'COSTODEINSUMO_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_COSTOINS')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'COSTODEINSUMO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..ListaCost ) or isnull( &lcCursor..Insumo ) or isnull( &lcCursor..COLORES ) or isnull( &lcCursor..Taller ) or isnull( &lcCursor..Proceso )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad COSTODEINSUMO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COSTODEINSUMO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,ListaCost + Insumo + COLORES + Taller + Proceso as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( ListaCost + Insumo + COLORES + Taller + Proceso, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COSTODEINSUMO'
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COSTOINS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COSTOINS
Create Table ZooLogic.TablaTrabajo_COSTOINS ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"descfw" char( 200 )  null, 
"hmodifw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"listacost" char( 6 )  null, 
"insumo" char( 23 )  null, 
"codigo" char( 58 )  null, 
"colores" char( 2 )  null, 
"proceso" char( 10 )  null, 
"taller" char( 10 )  null, 
"cantidad" numeric( 7, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_COSTOINS' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_COSTOINS' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COSTODEINSUMO'
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
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('listacost','listacost')
			.AgregarMapeo('insumo','insumo')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('colores','colores')
			.AgregarMapeo('proceso','proceso')
			.AgregarMapeo('taller','taller')
			.AgregarMapeo('cantidad','cantidad')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_COSTOINS'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.LISTACOST = isnull( d.LISTACOST, t.LISTACOST ),t.INSUMO = isnull( d.INSUMO, t.INSUMO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.COLORES = isnull( d.COLORES, t.COLORES ),t.PROCESO = isnull( d.PROCESO, t.PROCESO ),t.TALLER = isnull( d.TALLER, t.TALLER ),t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD )
					from ZooLogic.COSTOINS t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.ListaCost = d.ListaCost
							 and  t.Insumo = d.Insumo
							 and  t.COLORES = d.COLORES
							 and  t.Taller = d.Taller
							 and  t.Proceso = d.Proceso
				-- Fin Updates
				insert into ZooLogic.COSTOINS(Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Timestamp,Ualtafw,Saltafw,Smodifw,Umodifw,Vmodifw,Descfw,Hmodifw,Zadsfw,Valtafw,Horaexpo,Horaimpo,Bdmodifw,Esttrans,Bdaltafw,Haltafw,Listacost,Insumo,Codigo,Colores,Proceso,Taller,Cantidad)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.TIMESTAMP,0),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.DESCFW,''),isnull( d.HMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.LISTACOST,''),isnull( d.INSUMO,''),isnull( d.CODIGO,''),isnull( d.COLORES,''),isnull( d.PROCESO,''),isnull( d.TALLER,''),isnull( d.CANTIDAD,0)
						From deleted d left join ZooLogic.COSTOINS pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.COSTOINS cc 
							 on  d.ListaCost = cc.ListaCost
							 and  d.Insumo = cc.Insumo
							 and  d.COLORES = cc.COLORES
							 and  d.Taller = cc.Taller
							 and  d.Proceso = cc.Proceso
						Where pk.CODIGO Is Null 
							 and cc.ListaCost Is Null 
							 and cc.Insumo Is Null 
							 and cc.COLORES Is Null 
							 and cc.Taller Is Null 
							 and cc.Proceso Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: LISTA DE COSTO ' + cast( d.ListaCost as Varchar(6) ) + ', ARTICULO ' + cast( d.Insumo as Varchar(23) ) + ', COLOR ' + cast( d.COLORES as Varchar(2) ) + ', TALLER ' + cast( d.Taller as Varchar(10) ) + ', PROCESO ' + cast( d.Proceso as Varchar(10) ) + '','La clave principal no es la esperada'
					from ZooLogic.COSTOINS t inner join deleted d 
							on   t.ListaCost = d.ListaCost
							 and  t.Insumo = d.Insumo
							 and  t.COLORES = d.COLORES
							 and  t.Taller = d.Taller
							 and  t.Proceso = d.Proceso
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: LISTA DE COSTO ' + cast( d.ListaCost as Varchar(6) ) + ', ARTICULO ' + cast( d.Insumo as Varchar(23) ) + ', COLOR ' + cast( d.COLORES as Varchar(2) ) + ', TALLER ' + cast( d.Taller as Varchar(10) ) + ', PROCESO ' + cast( d.Proceso as Varchar(10) ) + '','La clave principal a importar ya existe'
					from ZooLogic.COSTOINS t inner join deleted d 
							 on t.CODIGO = d.CODIGO
						left join deleted h 
							on   t.ListaCost = h.ListaCost
							 and   t.Insumo = h.Insumo
							 and   t.COLORES = h.COLORES
							 and   t.Taller = h.Taller
							 and   t.Proceso = h.Proceso
							where   h.ListaCost is null 
							 and   h.Insumo is null 
							 and   h.COLORES is null 
							 and   h.Taller is null 
							 and   h.Proceso is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COSTOINS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COSTOINS
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_COSTODEINSUMO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COSTODEINSUMO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_COSTODEINSUMO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COSTODEINSUMO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COSTODEINSUMO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COSTODEINSUMO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_COSTODEINSUMO.Timestamp, 0 )
					.Usuarioaltafw = nvl( c_COSTODEINSUMO.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_COSTODEINSUMO.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_COSTODEINSUMO.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_COSTODEINSUMO.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_COSTODEINSUMO.Versionmodificacionfw, [] )
					.Descripcionfw = nvl( c_COSTODEINSUMO.Descripcionfw, [] )
					.Horamodificacionfw = nvl( c_COSTODEINSUMO.Horamodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_COSTODEINSUMO.Versionaltafw, [] )
					.Horaexpo = nvl( c_COSTODEINSUMO.Horaexpo, [] )
					.Horaimpo = nvl( c_COSTODEINSUMO.Horaimpo, [] )
					.Basededatosmodificacionfw = nvl( c_COSTODEINSUMO.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_COSTODEINSUMO.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_COSTODEINSUMO.Basededatosaltafw, [] )
					.Horaaltafw = nvl( c_COSTODEINSUMO.Horaaltafw, [] )
					.Listadecosto_PK =  nvl( c_COSTODEINSUMO.Listadecosto, [] )
					.Insumo_PK =  nvl( c_COSTODEINSUMO.Insumo, [] )
					.Codigo = nvl( c_COSTODEINSUMO.Codigo, [] )
					.Color_PK =  nvl( c_COSTODEINSUMO.Color, [] )
					.Proceso_PK =  nvl( c_COSTODEINSUMO.Proceso, [] )
					.Taller_PK =  nvl( c_COSTODEINSUMO.Taller, [] )
					.Desdecantidad = nvl( c_COSTODEINSUMO.Desdecantidad, 0 )
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
			lxRetorno = c_COSTODEINSUMO.CODIGO
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
		return c_COSTODEINSUMO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.COSTOINS' )
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
								from ZooLogic.COSTOINS 
								Where   COSTOINS.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "COSTOINS", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Listacost" as "Listadecosto", "Insumo" as "Insumo", "Codigo" as "Codigo", "Colores" as "Color", "Proceso" as "Proceso", "Taller" as "Taller", "Cantidad" as "Desdecantidad"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.COSTOINS 
								Where   COSTOINS.CODIGO != ''
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
	Tabla = 'COSTOINS'
	Filtro = " COSTOINS.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " COSTOINS.CODIGO != ''"
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
	<row entidad="COSTODEINSUMO                           " atributo="FECHAEXPO                               " tabla="COSTOINS       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="FECHATRANSFERENCIA                      " tabla="COSTOINS       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="FECHAIMPO                               " tabla="COSTOINS       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="FECHAALTAFW                             " tabla="COSTOINS       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="FECHAMODIFICACIONFW                     " tabla="COSTOINS       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="TIMESTAMP                               " tabla="COSTOINS       " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="USUARIOALTAFW                           " tabla="COSTOINS       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="SERIEALTAFW                             " tabla="COSTOINS       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="SERIEMODIFICACIONFW                     " tabla="COSTOINS       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="USUARIOMODIFICACIONFW                   " tabla="COSTOINS       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="VERSIONMODIFICACIONFW                   " tabla="COSTOINS       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="DESCRIPCIONFW                           " tabla="COSTOINS       " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="HORAMODIFICACIONFW                      " tabla="COSTOINS       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="ZADSFW                                  " tabla="COSTOINS       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="VERSIONALTAFW                           " tabla="COSTOINS       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="HORAEXPO                                " tabla="COSTOINS       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="HORAIMPO                                " tabla="COSTOINS       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COSTOINS       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="ESTADOTRANSFERENCIA                     " tabla="COSTOINS       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="BASEDEDATOSALTAFW                       " tabla="COSTOINS       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="HORAALTAFW                              " tabla="COSTOINS       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="LISTADECOSTO                            " tabla="COSTOINS       " campo="LISTACOST " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADECOSTOSDEPRODUCCION               " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="Lista de costo                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="INSUMO                                  " tabla="COSTOINS       " campo="INSUMO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="Insumo                                  " tipodato="C         " longitud="23" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="Articulo                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="CODIGO                                  " tabla="COSTOINS       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="58" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Codigo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="COLOR                                   " tabla="COSTOINS       " campo="COLORES   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="Color                                   " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Color                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="PROCESO                                 " tabla="COSTOINS       " campo="PROCESO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROCESOPRODUCCION                       " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="400" etiqueta="Proceso                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="6" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="TALLER                                  " tabla="COSTOINS       " campo="TALLER    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLER                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Taller                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="5" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COSTODEINSUMO                           " atributo="DESDECANTIDAD                           " tabla="COSTOINS       " campo="CANTIDAD  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Desde cantidad                                                                                                                                                  " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="DESCRIPCION                             " tabla="PROCPRODUC     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="401" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROCPRODUC On COSTOINS.PROCESO = PROCPRODUC.Codigo And  PROCPRODUC.CODIGO != ''                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="DESCRIPCION                             " tabla="TALLER         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="403" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLER On COSTOINS.TALLER = TALLER.Codigo And  TALLER.CODIGO != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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