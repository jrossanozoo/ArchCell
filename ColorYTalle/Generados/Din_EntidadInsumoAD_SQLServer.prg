
define class Din_EntidadINSUMOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_INSUMO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_INPPK'
	cTablaPrincipal = 'INS'
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
			local  lxInsFecimpo, lxInsFecexpo, lxInsFmodifw, lxInsFaltafw, lxInsFectrans, lxInsHoraexpo, lxInsHoraimpo, lxInsHaltafw, lxInsBdaltafw, lxInsEsttrans, lxInsBdmodifw, lxInsHmodifw, lxInsSaltafw, lxInsZadsfw, lxInsDescfw, lxInsVmodifw, lxInsValtafw, lxInsSmodifw, lxInsUaltafw, lxInsUmodifw, lxInsInscod, lxInsInsdes, lxInsTipo, lxInsCodart, lxInsInsdesadic, lxInsUnidadr, lxInsFamilia, lxInsUnimed, lxInsCantidadr, lxInsMaterial, lxInsLinea, lxInsArtfab, lxInsCodartliqp, lxInsGrupo, lxInsCodartliqd, lxInsCateg, lxInsClasif, lxInsCondiva, lxInsPoriva, lxInsIobs
				lxInsFecimpo =  .Fechaimpo			lxInsFecexpo =  .Fechaexpo			lxInsFmodifw =  .Fechamodificacionfw			lxInsFaltafw =  .Fechaaltafw			lxInsFectrans =  .Fechatransferencia			lxInsHoraexpo =  .Horaexpo			lxInsHoraimpo =  .Horaimpo			lxInsHaltafw =  .Horaaltafw			lxInsBdaltafw =  .Basededatosaltafw			lxInsEsttrans =  .Estadotransferencia			lxInsBdmodifw =  .Basededatosmodificacionfw			lxInsHmodifw =  .Horamodificacionfw			lxInsSaltafw =  .Seriealtafw			lxInsZadsfw =  .Zadsfw			lxInsDescfw =  .Descripcionfw			lxInsVmodifw =  .Versionmodificacionfw			lxInsValtafw =  .Versionaltafw			lxInsSmodifw =  .Seriemodificacionfw			lxInsUaltafw =  .Usuarioaltafw			lxInsUmodifw =  .Usuariomodificacionfw			lxInsInscod =  .Codigo			lxInsInsdes =  .Descripcion			lxInsTipo =  upper( .Tipodeinsumo_PK ) 			lxInsCodart =  upper( .Articulo_PK ) 			lxInsInsdesadic =  .Descripcionadicional			lxInsUnidadr =  upper( .RindeUnidad_PK ) 			lxInsFamilia =  upper( .Familia_PK ) 			lxInsUnimed =  upper( .UnidadDeMedida_PK ) 			lxInsCantidadr =  .Rindecantidad			lxInsMaterial =  upper( .Material_PK ) 			lxInsLinea =  upper( .Linea_PK ) 			lxInsArtfab =  upper( .Proveedor_PK ) 			lxInsCodartliqp =  upper( .ArticuloLiquidacionProduccion_PK ) 			lxInsGrupo =  upper( .Grupo_PK ) 			lxInsCodartliqd =  upper( .ArticuloLiquidacionDescarte_PK ) 			lxInsCateg =  upper( .CategoriaDeInsumo_PK ) 			lxInsClasif =  upper( .Clasificacion_PK ) 			lxInsCondiva =  .Condicioniva			lxInsPoriva =  .Porcentajeiva			lxInsIobs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxInsInscod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.INS ( "Fecimpo","Fecexpo","Fmodifw","Faltafw","Fectrans","Horaexpo","Horaimpo","Haltafw","Bdaltafw","Esttrans","Bdmodifw","Hmodifw","Saltafw","Zadsfw","Descfw","Vmodifw","Valtafw","Smodifw","Ualtafw","Umodifw","Inscod","Insdes","Tipo","Codart","Insdesadic","Unidadr","Familia","Unimed","Cantidadr","Material","Linea","Artfab","Codartliqp","Grupo","Codartliqd","Categ","Clasif","Condiva","Poriva","Iobs" ) values ( <<"'" + this.ConvertirDateSql( lxInsFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInsFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInsFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInsFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInsFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsInscod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsInsdes ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsTipo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsCodart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsInsdesadic ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsUnidadr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsFamilia ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsUnimed ) + "'" >>, <<lxInsCantidadr >>, <<"'" + this.FormatearTextoSql( lxInsMaterial ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsLinea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsArtfab ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsCodartliqp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsGrupo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsCodartliqd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsCateg ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsClasif ) + "'" >>, <<lxInsCondiva >>, <<lxInsPoriva >>, <<"'" + this.FormatearTextoSql( lxInsIobs ) + "'" >> )
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
			local  lxInsFecimpo, lxInsFecexpo, lxInsFmodifw, lxInsFaltafw, lxInsFectrans, lxInsHoraexpo, lxInsHoraimpo, lxInsHaltafw, lxInsBdaltafw, lxInsEsttrans, lxInsBdmodifw, lxInsHmodifw, lxInsSaltafw, lxInsZadsfw, lxInsDescfw, lxInsVmodifw, lxInsValtafw, lxInsSmodifw, lxInsUaltafw, lxInsUmodifw, lxInsInscod, lxInsInsdes, lxInsTipo, lxInsCodart, lxInsInsdesadic, lxInsUnidadr, lxInsFamilia, lxInsUnimed, lxInsCantidadr, lxInsMaterial, lxInsLinea, lxInsArtfab, lxInsCodartliqp, lxInsGrupo, lxInsCodartliqd, lxInsCateg, lxInsClasif, lxInsCondiva, lxInsPoriva, lxInsIobs
				lxInsFecimpo =  .Fechaimpo			lxInsFecexpo =  .Fechaexpo			lxInsFmodifw =  .Fechamodificacionfw			lxInsFaltafw =  .Fechaaltafw			lxInsFectrans =  .Fechatransferencia			lxInsHoraexpo =  .Horaexpo			lxInsHoraimpo =  .Horaimpo			lxInsHaltafw =  .Horaaltafw			lxInsBdaltafw =  .Basededatosaltafw			lxInsEsttrans =  .Estadotransferencia			lxInsBdmodifw =  .Basededatosmodificacionfw			lxInsHmodifw =  .Horamodificacionfw			lxInsSaltafw =  .Seriealtafw			lxInsZadsfw =  .Zadsfw			lxInsDescfw =  .Descripcionfw			lxInsVmodifw =  .Versionmodificacionfw			lxInsValtafw =  .Versionaltafw			lxInsSmodifw =  .Seriemodificacionfw			lxInsUaltafw =  .Usuarioaltafw			lxInsUmodifw =  .Usuariomodificacionfw			lxInsInscod =  .Codigo			lxInsInsdes =  .Descripcion			lxInsTipo =  upper( .Tipodeinsumo_PK ) 			lxInsCodart =  upper( .Articulo_PK ) 			lxInsInsdesadic =  .Descripcionadicional			lxInsUnidadr =  upper( .RindeUnidad_PK ) 			lxInsFamilia =  upper( .Familia_PK ) 			lxInsUnimed =  upper( .UnidadDeMedida_PK ) 			lxInsCantidadr =  .Rindecantidad			lxInsMaterial =  upper( .Material_PK ) 			lxInsLinea =  upper( .Linea_PK ) 			lxInsArtfab =  upper( .Proveedor_PK ) 			lxInsCodartliqp =  upper( .ArticuloLiquidacionProduccion_PK ) 			lxInsGrupo =  upper( .Grupo_PK ) 			lxInsCodartliqd =  upper( .ArticuloLiquidacionDescarte_PK ) 			lxInsCateg =  upper( .CategoriaDeInsumo_PK ) 			lxInsClasif =  upper( .Clasificacion_PK ) 			lxInsCondiva =  .Condicioniva			lxInsPoriva =  .Porcentajeiva			lxInsIobs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.INS set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxInsFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxInsFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxInsFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxInsFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxInsFectrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxInsHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxInsHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxInsHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxInsBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxInsEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxInsBdmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxInsHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxInsSaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxInsZadsfw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxInsDescfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxInsVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxInsValtafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxInsSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxInsUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxInsUmodifw ) + "'">>,"Inscod" = <<"'" + this.FormatearTextoSql( lxInsInscod ) + "'">>,"Insdes" = <<"'" + this.FormatearTextoSql( lxInsInsdes ) + "'">>,"Tipo" = <<"'" + this.FormatearTextoSql( lxInsTipo ) + "'">>,"Codart" = <<"'" + this.FormatearTextoSql( lxInsCodart ) + "'">>,"Insdesadic" = <<"'" + this.FormatearTextoSql( lxInsInsdesadic ) + "'">>,"Unidadr" = <<"'" + this.FormatearTextoSql( lxInsUnidadr ) + "'">>,"Familia" = <<"'" + this.FormatearTextoSql( lxInsFamilia ) + "'">>,"Unimed" = <<"'" + this.FormatearTextoSql( lxInsUnimed ) + "'">>,"Cantidadr" = <<lxInsCantidadr>>,"Material" = <<"'" + this.FormatearTextoSql( lxInsMaterial ) + "'">>,"Linea" = <<"'" + this.FormatearTextoSql( lxInsLinea ) + "'">>,"Artfab" = <<"'" + this.FormatearTextoSql( lxInsArtfab ) + "'">>,"Codartliqp" = <<"'" + this.FormatearTextoSql( lxInsCodartliqp ) + "'">>,"Grupo" = <<"'" + this.FormatearTextoSql( lxInsGrupo ) + "'">>,"Codartliqd" = <<"'" + this.FormatearTextoSql( lxInsCodartliqd ) + "'">>,"Categ" = <<"'" + this.FormatearTextoSql( lxInsCateg ) + "'">>,"Clasif" = <<"'" + this.FormatearTextoSql( lxInsClasif ) + "'">>,"Condiva" = <<lxInsCondiva>>,"Poriva" = <<lxInsPoriva>>,"Iobs" = <<"'" + this.FormatearTextoSql( lxInsIobs ) + "'">> where "Inscod" = <<"'" + this.FormatearTextoSql( lxInsInscod ) + "'">> and  INS.INSCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 INSCOD from ZooLogic.INS where " + this.ConvertirFuncionesSql( " INS.INSCOD != ''" ) )
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
			Local lxInsInscod
			lxInsInscod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Inscod" as "Codigo", "Insdes" as "Descripcion", "Tipo" as "Tipodeinsumo", "Codart" as "Articulo", "Insdesadic" as "Descripcionadicional", "Unidadr" as "Rindeunidad", "Familia" as "Familia", "Unimed" as "Unidaddemedida", "Cantidadr" as "Rindecantidad", "Material" as "Material", "Linea" as "Linea", "Artfab" as "Proveedor", "Codartliqp" as "Articuloliquidacionproduccion", "Grupo" as "Grupo", "Codartliqd" as "Articuloliquidaciondescarte", "Categ" as "Categoriadeinsumo", "Clasif" as "Clasificacion", "Condiva" as "Condicioniva", "Poriva" as "Porcentajeiva", "Iobs" as "Observacion" from ZooLogic.INS where "Inscod" = <<"'" + this.FormatearTextoSql( lxInsInscod ) + "'">> and  INS.INSCOD != ''
			endtext
			use in select('c_INSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INSUMO', set( 'Datasession' ) )

			if reccount( 'c_INSUMO' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxInsInscod as Variant
		llRetorno = .t.
		lxInsInscod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.INS where "Inscod" = <<"'" + this.FormatearTextoSql( lxInsInscod ) + "'">> and  INS.INSCOD != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Inscod" as "Codigo", "Insdes" as "Descripcion", "Tipo" as "Tipodeinsumo", "Codart" as "Articulo", "Insdesadic" as "Descripcionadicional", "Unidadr" as "Rindeunidad", "Familia" as "Familia", "Unimed" as "Unidaddemedida", "Cantidadr" as "Rindecantidad", "Material" as "Material", "Linea" as "Linea", "Artfab" as "Proveedor", "Codartliqp" as "Articuloliquidacionproduccion", "Grupo" as "Grupo", "Codartliqd" as "Articuloliquidaciondescarte", "Categ" as "Categoriadeinsumo", "Clasif" as "Clasificacion", "Condiva" as "Condicioniva", "Poriva" as "Porcentajeiva", "Iobs" as "Observacion" from ZooLogic.INS where  INS.INSCOD != '' order by INSCOD
			endtext
			use in select('c_INSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INSUMO', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Inscod" as "Codigo", "Insdes" as "Descripcion", "Tipo" as "Tipodeinsumo", "Codart" as "Articulo", "Insdesadic" as "Descripcionadicional", "Unidadr" as "Rindeunidad", "Familia" as "Familia", "Unimed" as "Unidaddemedida", "Cantidadr" as "Rindecantidad", "Material" as "Material", "Linea" as "Linea", "Artfab" as "Proveedor", "Codartliqp" as "Articuloliquidacionproduccion", "Grupo" as "Grupo", "Codartliqd" as "Articuloliquidaciondescarte", "Categ" as "Categoriadeinsumo", "Clasif" as "Clasificacion", "Condiva" as "Condicioniva", "Poriva" as "Porcentajeiva", "Iobs" as "Observacion" from ZooLogic.INS where  funciones.padr( INSCOD, 25, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  INS.INSCOD != '' order by INSCOD
			endtext
			use in select('c_INSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INSUMO', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Inscod" as "Codigo", "Insdes" as "Descripcion", "Tipo" as "Tipodeinsumo", "Codart" as "Articulo", "Insdesadic" as "Descripcionadicional", "Unidadr" as "Rindeunidad", "Familia" as "Familia", "Unimed" as "Unidaddemedida", "Cantidadr" as "Rindecantidad", "Material" as "Material", "Linea" as "Linea", "Artfab" as "Proveedor", "Codartliqp" as "Articuloliquidacionproduccion", "Grupo" as "Grupo", "Codartliqd" as "Articuloliquidaciondescarte", "Categ" as "Categoriadeinsumo", "Clasif" as "Clasificacion", "Condiva" as "Condicioniva", "Poriva" as "Porcentajeiva", "Iobs" as "Observacion" from ZooLogic.INS where  funciones.padr( INSCOD, 25, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  INS.INSCOD != '' order by INSCOD desc
			endtext
			use in select('c_INSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INSUMO', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Inscod" as "Codigo", "Insdes" as "Descripcion", "Tipo" as "Tipodeinsumo", "Codart" as "Articulo", "Insdesadic" as "Descripcionadicional", "Unidadr" as "Rindeunidad", "Familia" as "Familia", "Unimed" as "Unidaddemedida", "Cantidadr" as "Rindecantidad", "Material" as "Material", "Linea" as "Linea", "Artfab" as "Proveedor", "Codartliqp" as "Articuloliquidacionproduccion", "Grupo" as "Grupo", "Codartliqd" as "Articuloliquidaciondescarte", "Categ" as "Categoriadeinsumo", "Clasif" as "Clasificacion", "Condiva" as "Condicioniva", "Poriva" as "Porcentajeiva", "Iobs" as "Observacion" from ZooLogic.INS where  INS.INSCOD != '' order by INSCOD desc
			endtext
			use in select('c_INSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INSUMO', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fecexpo,Fmodifw,Faltafw,Fectrans,Horaexpo,Horaimpo,Haltafw,Bdaltafw,Esttrans,Bdmodif" + ;
"w,Hmodifw,Saltafw,Zadsfw,Descfw,Vmodifw,Valtafw,Smodifw,Ualtafw,Umodifw,Inscod,Insdes,Tipo,Codart,In" + ;
"sdesadic,Unidadr,Familia,Unimed,Cantidadr,Material,Linea,Artfab,Codartliqp,Grupo,Codartliqd,Categ,Cl" + ;
"asif,Condiva,Poriva,Iobs" + ;
" from ZooLogic.INS where  INS.INSCOD != '' and " + lcFiltro )
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
			local  lxInsFecimpo, lxInsFecexpo, lxInsFmodifw, lxInsFaltafw, lxInsFectrans, lxInsHoraexpo, lxInsHoraimpo, lxInsHaltafw, lxInsBdaltafw, lxInsEsttrans, lxInsBdmodifw, lxInsHmodifw, lxInsSaltafw, lxInsZadsfw, lxInsDescfw, lxInsVmodifw, lxInsValtafw, lxInsSmodifw, lxInsUaltafw, lxInsUmodifw, lxInsInscod, lxInsInsdes, lxInsTipo, lxInsCodart, lxInsInsdesadic, lxInsUnidadr, lxInsFamilia, lxInsUnimed, lxInsCantidadr, lxInsMaterial, lxInsLinea, lxInsArtfab, lxInsCodartliqp, lxInsGrupo, lxInsCodartliqd, lxInsCateg, lxInsClasif, lxInsCondiva, lxInsPoriva, lxInsIobs
				lxInsFecimpo = ctod( '  /  /    ' )			lxInsFecexpo = ctod( '  /  /    ' )			lxInsFmodifw = ctod( '  /  /    ' )			lxInsFaltafw = ctod( '  /  /    ' )			lxInsFectrans = ctod( '  /  /    ' )			lxInsHoraexpo = []			lxInsHoraimpo = []			lxInsHaltafw = []			lxInsBdaltafw = []			lxInsEsttrans = []			lxInsBdmodifw = []			lxInsHmodifw = []			lxInsSaltafw = []			lxInsZadsfw = []			lxInsDescfw = []			lxInsVmodifw = []			lxInsValtafw = []			lxInsSmodifw = []			lxInsUaltafw = []			lxInsUmodifw = []			lxInsInscod = []			lxInsInsdes = []			lxInsTipo = []			lxInsCodart = []			lxInsInsdesadic = []			lxInsUnidadr = []			lxInsFamilia = []			lxInsUnimed = []			lxInsCantidadr = 0			lxInsMaterial = []			lxInsLinea = []			lxInsArtfab = []			lxInsCodartliqp = []			lxInsGrupo = []			lxInsCodartliqd = []			lxInsCateg = []			lxInsClasif = []			lxInsCondiva = 0			lxInsPoriva = 0			lxInsIobs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.INS where "INSCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'INS' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where INSCOD = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(INSCOD, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  INS.INSCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Inscod" as "Codigo", "Insdes" as "Descripcion", "Tipo" as "Tipodeinsumo", "Codart" as "Articulo", "Insdesadic" as "Descripcionadicional", "Unidadr" as "Rindeunidad", "Familia" as "Familia", "Unimed" as "Unidaddemedida", "Cantidadr" as "Rindecantidad", "Material" as "Material", "Linea" as "Linea", "Artfab" as "Proveedor", "Codartliqp" as "Articuloliquidacionproduccion", "Grupo" as "Grupo", "Codartliqd" as "Articuloliquidaciondescarte", "Categ" as "Categoriadeinsumo", "Clasif" as "Clasificacion", "Condiva" as "Condicioniva", "Poriva" as "Porcentajeiva", "Iobs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'INS', '', tnTope )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INSCOD AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INSDES AS DESCRIPCION'
				Case lcAtributo == 'TIPODEINSUMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPODEINSUMO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODART AS ARTICULO'
				Case lcAtributo == 'DESCRIPCIONADICIONAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INSDESADIC AS DESCRIPCIONADICIONAL'
				Case lcAtributo == 'RINDEUNIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIDADR AS RINDEUNIDAD'
				Case lcAtributo == 'FAMILIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMILIA AS FAMILIA'
				Case lcAtributo == 'UNIDADDEMEDIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIMED AS UNIDADDEMEDIDA'
				Case lcAtributo == 'RINDECANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDADR AS RINDECANTIDAD'
				Case lcAtributo == 'MATERIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MATERIAL AS MATERIAL'
				Case lcAtributo == 'LINEA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LINEA AS LINEA'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTFAB AS PROVEEDOR'
				Case lcAtributo == 'ARTICULOLIQUIDACIONPRODUCCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODARTLIQP AS ARTICULOLIQUIDACIONPRODUCCION'
				Case lcAtributo == 'GRUPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GRUPO AS GRUPO'
				Case lcAtributo == 'ARTICULOLIQUIDACIONDESCARTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODARTLIQD AS ARTICULOLIQUIDACIONDESCARTE'
				Case lcAtributo == 'CATEGORIADEINSUMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATEG AS CATEGORIADEINSUMO'
				Case lcAtributo == 'CLASIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLASIF AS CLASIFICACION'
				Case lcAtributo == 'CONDICIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDIVA AS CONDICIONIVA'
				Case lcAtributo == 'PORCENTAJEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORIVA AS PORCENTAJEIVA'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IOBS AS OBSERVACION'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'INSCOD'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'INSDES'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODEINSUMO'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'CODART'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONADICIONAL'
				lcCampo = 'INSDESADIC'
			Case upper( alltrim( tcAtributo ) ) == 'RINDEUNIDAD'
				lcCampo = 'UNIDADR'
			Case upper( alltrim( tcAtributo ) ) == 'FAMILIA'
				lcCampo = 'FAMILIA'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDADDEMEDIDA'
				lcCampo = 'UNIMED'
			Case upper( alltrim( tcAtributo ) ) == 'RINDECANTIDAD'
				lcCampo = 'CANTIDADR'
			Case upper( alltrim( tcAtributo ) ) == 'MATERIAL'
				lcCampo = 'MATERIAL'
			Case upper( alltrim( tcAtributo ) ) == 'LINEA'
				lcCampo = 'LINEA'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'ARTFAB'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULOLIQUIDACIONPRODUCCION'
				lcCampo = 'CODARTLIQP'
			Case upper( alltrim( tcAtributo ) ) == 'GRUPO'
				lcCampo = 'GRUPO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULOLIQUIDACIONDESCARTE'
				lcCampo = 'CODARTLIQD'
			Case upper( alltrim( tcAtributo ) ) == 'CATEGORIADEINSUMO'
				lcCampo = 'CATEG'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACION'
				lcCampo = 'CLASIF'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVA'
				lcCampo = 'CONDIVA'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIVA'
				lcCampo = 'PORIVA'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'IOBS'
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
			local  lxInsFecimpo, lxInsFecexpo, lxInsFmodifw, lxInsFaltafw, lxInsFectrans, lxInsHoraexpo, lxInsHoraimpo, lxInsHaltafw, lxInsBdaltafw, lxInsEsttrans, lxInsBdmodifw, lxInsHmodifw, lxInsSaltafw, lxInsZadsfw, lxInsDescfw, lxInsVmodifw, lxInsValtafw, lxInsSmodifw, lxInsUaltafw, lxInsUmodifw, lxInsInscod, lxInsInsdes, lxInsTipo, lxInsCodart, lxInsInsdesadic, lxInsUnidadr, lxInsFamilia, lxInsUnimed, lxInsCantidadr, lxInsMaterial, lxInsLinea, lxInsArtfab, lxInsCodartliqp, lxInsGrupo, lxInsCodartliqd, lxInsCateg, lxInsClasif, lxInsCondiva, lxInsPoriva, lxInsIobs
				lxInsFecimpo =  .Fechaimpo			lxInsFecexpo =  .Fechaexpo			lxInsFmodifw =  .Fechamodificacionfw			lxInsFaltafw =  .Fechaaltafw			lxInsFectrans =  .Fechatransferencia			lxInsHoraexpo =  .Horaexpo			lxInsHoraimpo =  .Horaimpo			lxInsHaltafw =  .Horaaltafw			lxInsBdaltafw =  .Basededatosaltafw			lxInsEsttrans =  .Estadotransferencia			lxInsBdmodifw =  .Basededatosmodificacionfw			lxInsHmodifw =  .Horamodificacionfw			lxInsSaltafw =  .Seriealtafw			lxInsZadsfw =  .Zadsfw			lxInsDescfw =  .Descripcionfw			lxInsVmodifw =  .Versionmodificacionfw			lxInsValtafw =  .Versionaltafw			lxInsSmodifw =  .Seriemodificacionfw			lxInsUaltafw =  .Usuarioaltafw			lxInsUmodifw =  .Usuariomodificacionfw			lxInsInscod =  .Codigo			lxInsInsdes =  .Descripcion			lxInsTipo =  upper( .Tipodeinsumo_PK ) 			lxInsCodart =  upper( .Articulo_PK ) 			lxInsInsdesadic =  .Descripcionadicional			lxInsUnidadr =  upper( .RindeUnidad_PK ) 			lxInsFamilia =  upper( .Familia_PK ) 			lxInsUnimed =  upper( .UnidadDeMedida_PK ) 			lxInsCantidadr =  .Rindecantidad			lxInsMaterial =  upper( .Material_PK ) 			lxInsLinea =  upper( .Linea_PK ) 			lxInsArtfab =  upper( .Proveedor_PK ) 			lxInsCodartliqp =  upper( .ArticuloLiquidacionProduccion_PK ) 			lxInsGrupo =  upper( .Grupo_PK ) 			lxInsCodartliqd =  upper( .ArticuloLiquidacionDescarte_PK ) 			lxInsCateg =  upper( .CategoriaDeInsumo_PK ) 			lxInsClasif =  upper( .Clasificacion_PK ) 			lxInsCondiva =  .Condicioniva			lxInsPoriva =  .Porcentajeiva			lxInsIobs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.INS ( "Fecimpo","Fecexpo","Fmodifw","Faltafw","Fectrans","Horaexpo","Horaimpo","Haltafw","Bdaltafw","Esttrans","Bdmodifw","Hmodifw","Saltafw","Zadsfw","Descfw","Vmodifw","Valtafw","Smodifw","Ualtafw","Umodifw","Inscod","Insdes","Tipo","Codart","Insdesadic","Unidadr","Familia","Unimed","Cantidadr","Material","Linea","Artfab","Codartliqp","Grupo","Codartliqd","Categ","Clasif","Condiva","Poriva","Iobs" ) values ( <<"'" + this.ConvertirDateSql( lxInsFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInsFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInsFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInsFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInsFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsInscod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsInsdes ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsTipo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsCodart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsInsdesadic ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsUnidadr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsFamilia ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsUnimed ) + "'" >>, <<lxInsCantidadr >>, <<"'" + this.FormatearTextoSql( lxInsMaterial ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsLinea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsArtfab ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsCodartliqp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsGrupo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsCodartliqd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsCateg ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInsClasif ) + "'" >>, <<lxInsCondiva >>, <<lxInsPoriva >>, <<"'" + this.FormatearTextoSql( lxInsIobs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'INS' 
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
			local  lxInsFecimpo, lxInsFecexpo, lxInsFmodifw, lxInsFaltafw, lxInsFectrans, lxInsHoraexpo, lxInsHoraimpo, lxInsHaltafw, lxInsBdaltafw, lxInsEsttrans, lxInsBdmodifw, lxInsHmodifw, lxInsSaltafw, lxInsZadsfw, lxInsDescfw, lxInsVmodifw, lxInsValtafw, lxInsSmodifw, lxInsUaltafw, lxInsUmodifw, lxInsInscod, lxInsInsdes, lxInsTipo, lxInsCodart, lxInsInsdesadic, lxInsUnidadr, lxInsFamilia, lxInsUnimed, lxInsCantidadr, lxInsMaterial, lxInsLinea, lxInsArtfab, lxInsCodartliqp, lxInsGrupo, lxInsCodartliqd, lxInsCateg, lxInsClasif, lxInsCondiva, lxInsPoriva, lxInsIobs
				lxInsFecimpo =  .Fechaimpo			lxInsFecexpo =  .Fechaexpo			lxInsFmodifw =  .Fechamodificacionfw			lxInsFaltafw =  .Fechaaltafw			lxInsFectrans =  .Fechatransferencia			lxInsHoraexpo =  .Horaexpo			lxInsHoraimpo =  .Horaimpo			lxInsHaltafw =  .Horaaltafw			lxInsBdaltafw =  .Basededatosaltafw			lxInsEsttrans =  .Estadotransferencia			lxInsBdmodifw =  .Basededatosmodificacionfw			lxInsHmodifw =  .Horamodificacionfw			lxInsSaltafw =  .Seriealtafw			lxInsZadsfw =  .Zadsfw			lxInsDescfw =  .Descripcionfw			lxInsVmodifw =  .Versionmodificacionfw			lxInsValtafw =  .Versionaltafw			lxInsSmodifw =  .Seriemodificacionfw			lxInsUaltafw =  .Usuarioaltafw			lxInsUmodifw =  .Usuariomodificacionfw			lxInsInscod =  .Codigo			lxInsInsdes =  .Descripcion			lxInsTipo =  upper( .Tipodeinsumo_PK ) 			lxInsCodart =  upper( .Articulo_PK ) 			lxInsInsdesadic =  .Descripcionadicional			lxInsUnidadr =  upper( .RindeUnidad_PK ) 			lxInsFamilia =  upper( .Familia_PK ) 			lxInsUnimed =  upper( .UnidadDeMedida_PK ) 			lxInsCantidadr =  .Rindecantidad			lxInsMaterial =  upper( .Material_PK ) 			lxInsLinea =  upper( .Linea_PK ) 			lxInsArtfab =  upper( .Proveedor_PK ) 			lxInsCodartliqp =  upper( .ArticuloLiquidacionProduccion_PK ) 			lxInsGrupo =  upper( .Grupo_PK ) 			lxInsCodartliqd =  upper( .ArticuloLiquidacionDescarte_PK ) 			lxInsCateg =  upper( .CategoriaDeInsumo_PK ) 			lxInsClasif =  upper( .Clasificacion_PK ) 			lxInsCondiva =  .Condicioniva			lxInsPoriva =  .Porcentajeiva			lxInsIobs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Inscod" = ] + lcValorClavePrimariaString  + [ and  INS.INSCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.INS set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxInsFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxInsFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxInsFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxInsFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxInsFectrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxInsHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxInsHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxInsHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxInsBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxInsEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxInsBdmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxInsHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxInsSaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxInsZadsfw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxInsDescfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxInsVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxInsValtafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxInsSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxInsUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxInsUmodifw ) + "'">>, "Inscod" = <<"'" + this.FormatearTextoSql( lxInsInscod ) + "'">>, "Insdes" = <<"'" + this.FormatearTextoSql( lxInsInsdes ) + "'">>, "Tipo" = <<"'" + this.FormatearTextoSql( lxInsTipo ) + "'">>, "Codart" = <<"'" + this.FormatearTextoSql( lxInsCodart ) + "'">>, "Insdesadic" = <<"'" + this.FormatearTextoSql( lxInsInsdesadic ) + "'">>, "Unidadr" = <<"'" + this.FormatearTextoSql( lxInsUnidadr ) + "'">>, "Familia" = <<"'" + this.FormatearTextoSql( lxInsFamilia ) + "'">>, "Unimed" = <<"'" + this.FormatearTextoSql( lxInsUnimed ) + "'">>, "Cantidadr" = <<lxInsCantidadr>>, "Material" = <<"'" + this.FormatearTextoSql( lxInsMaterial ) + "'">>, "Linea" = <<"'" + this.FormatearTextoSql( lxInsLinea ) + "'">>, "Artfab" = <<"'" + this.FormatearTextoSql( lxInsArtfab ) + "'">>, "Codartliqp" = <<"'" + this.FormatearTextoSql( lxInsCodartliqp ) + "'">>, "Grupo" = <<"'" + this.FormatearTextoSql( lxInsGrupo ) + "'">>, "Codartliqd" = <<"'" + this.FormatearTextoSql( lxInsCodartliqd ) + "'">>, "Categ" = <<"'" + this.FormatearTextoSql( lxInsCateg ) + "'">>, "Clasif" = <<"'" + this.FormatearTextoSql( lxInsClasif ) + "'">>, "Condiva" = <<lxInsCondiva>>, "Poriva" = <<lxInsPoriva>>, "Iobs" = <<"'" + this.FormatearTextoSql( lxInsIobs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'INS' 
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

			lcFiltro = ["Inscod" = ] + lcValorClavePrimariaString  + [ and  INS.INSCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.INS where ' + lcFiltro )
			loColeccion.cTabla = 'INS' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.INS where  INS.INSCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.INS where INSCOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  INS.INSCOD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'INSUMO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.INS Where INSCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..INSCOD ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.INS set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, INSCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..INSCOD ) + "'"+ [, INSDES = ] + "'" + this.FormatearTextoSql( &lcCursor..INSDES ) + "'"+ [, Tipo = ] + "'" + this.FormatearTextoSql( &lcCursor..Tipo ) + "'"+ [, CodArt = ] + "'" + this.FormatearTextoSql( &lcCursor..CodArt ) + "'"+ [, INSDESADIC = ] + "'" + this.FormatearTextoSql( &lcCursor..INSDESADIC ) + "'"+ [, UnidadR = ] + "'" + this.FormatearTextoSql( &lcCursor..UnidadR ) + "'"+ [, Familia = ] + "'" + this.FormatearTextoSql( &lcCursor..Familia ) + "'"+ [, UniMed = ] + "'" + this.FormatearTextoSql( &lcCursor..UniMed ) + "'"+ [, CantidadR = ] + transform( &lcCursor..CantidadR )+ [, Material = ] + "'" + this.FormatearTextoSql( &lcCursor..Material ) + "'"+ [, Linea = ] + "'" + this.FormatearTextoSql( &lcCursor..Linea ) + "'"+ [, ARTFAB = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTFAB ) + "'"+ [, CodArtLiqP = ] + "'" + this.FormatearTextoSql( &lcCursor..CodArtLiqP ) + "'"+ [, Grupo = ] + "'" + this.FormatearTextoSql( &lcCursor..Grupo ) + "'"+ [, CodArtLiqD = ] + "'" + this.FormatearTextoSql( &lcCursor..CodArtLiqD ) + "'"+ [, Categ = ] + "'" + this.FormatearTextoSql( &lcCursor..Categ ) + "'"+ [, Clasif = ] + "'" + this.FormatearTextoSql( &lcCursor..Clasif ) + "'"+ [, condiva = ] + transform( &lcCursor..condiva )+ [, poriva = ] + transform( &lcCursor..poriva )+ [, IObs = ] + "'" + this.FormatearTextoSql( &lcCursor..IObs ) + "'" + [ Where INSCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..INSCOD ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECEXPO, FMODIFW, FALTAFW, FECTRANS, HORAEXPO, HORAIMPO, HALTAFW, BDALTAFW, ESTTRANS, BDMODIFW, HMODIFW, SALTAFW, ZADSFW, DescFW, VMODIFW, VALTAFW, SMODIFW, UALTAFW, UMODIFW, INSCOD, INSDES, Tipo, CodArt, INSDESADIC, UnidadR, Familia, UniMed, CantidadR, Material, Linea, ARTFAB, CodArtLiqP, Grupo, CodArtLiqD, Categ, Clasif, condiva, poriva, IObs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..INSCOD ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..INSDES ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Tipo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodArt ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..INSDESADIC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UnidadR ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Familia ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UniMed ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..CantidadR ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Material ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Linea ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ARTFAB ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodArtLiqP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Grupo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodArtLiqD ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Categ ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Clasif ) + "'" + ',' + transform( &lcCursor..condiva ) + ',' + transform( &lcCursor..poriva ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..IObs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.INS ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'INSUMO'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( INSCOD C (25) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..INSCOD     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'INSUMO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'INSUMO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'INSUMO_IOBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_INS')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'INSUMO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..INSCOD
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad INSUMO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'INSUMO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,INSCOD as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( INSCOD, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'INSUMO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_INS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_INS
Create Table ZooLogic.TablaTrabajo_INS ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"descfw" char( 200 )  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"inscod" char( 25 )  null, 
"insdes" char( 100 )  null, 
"tipo" char( 10 )  null, 
"codart" char( 15 )  null, 
"insdesadic" char( 254 )  null, 
"unidadr" char( 3 )  null, 
"familia" char( 10 )  null, 
"unimed" char( 3 )  null, 
"cantidadr" numeric( 9, 2 )  null, 
"material" char( 10 )  null, 
"linea" char( 10 )  null, 
"artfab" char( 10 )  null, 
"codartliqp" char( 15 )  null, 
"grupo" char( 10 )  null, 
"codartliqd" char( 15 )  null, 
"categ" char( 10 )  null, 
"clasif" char( 10 )  null, 
"condiva" numeric( 1, 0 )  null, 
"poriva" numeric( 5, 2 )  null, 
"iobs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_INS' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_INS' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'INSUMO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('inscod','inscod')
			.AgregarMapeo('insdes','insdes')
			.AgregarMapeo('tipo','tipo')
			.AgregarMapeo('codart','codart')
			.AgregarMapeo('insdesadic','insdesadic')
			.AgregarMapeo('unidadr','unidadr')
			.AgregarMapeo('familia','familia')
			.AgregarMapeo('unimed','unimed')
			.AgregarMapeo('cantidadr','cantidadr')
			.AgregarMapeo('material','material')
			.AgregarMapeo('linea','linea')
			.AgregarMapeo('artfab','artfab')
			.AgregarMapeo('codartliqp','codartliqp')
			.AgregarMapeo('grupo','grupo')
			.AgregarMapeo('codartliqd','codartliqd')
			.AgregarMapeo('categ','categ')
			.AgregarMapeo('clasif','clasif')
			.AgregarMapeo('condiva','condiva')
			.AgregarMapeo('poriva','poriva')
			.AgregarMapeo('iobs','iobs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_INS'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.INSCOD = isnull( d.INSCOD, t.INSCOD ),t.INSDES = isnull( d.INSDES, t.INSDES ),t.TIPO = isnull( d.TIPO, t.TIPO ),t.CODART = isnull( d.CODART, t.CODART ),t.INSDESADIC = isnull( d.INSDESADIC, t.INSDESADIC ),t.UNIDADR = isnull( d.UNIDADR, t.UNIDADR ),t.FAMILIA = isnull( d.FAMILIA, t.FAMILIA ),t.UNIMED = isnull( d.UNIMED, t.UNIMED ),t.CANTIDADR = isnull( d.CANTIDADR, t.CANTIDADR ),t.MATERIAL = isnull( d.MATERIAL, t.MATERIAL ),t.LINEA = isnull( d.LINEA, t.LINEA ),t.ARTFAB = isnull( d.ARTFAB, t.ARTFAB ),t.CODARTLIQP = isnull( d.CODARTLIQP, t.CODARTLIQP ),t.GRUPO = isnull( d.GRUPO, t.GRUPO ),t.CODARTLIQD = isnull( d.CODARTLIQD, t.CODARTLIQD ),t.CATEG = isnull( d.CATEG, t.CATEG ),t.CLASIF = isnull( d.CLASIF, t.CLASIF ),t.CONDIVA = isnull( d.CONDIVA, t.CONDIVA ),t.PORIVA = isnull( d.PORIVA, t.PORIVA ),t.IOBS = isnull( d.IOBS, t.IOBS )
					from ZooLogic.INS t inner join deleted d 
							 on t.INSCOD = d.INSCOD
				-- Fin Updates
				insert into ZooLogic.INS(Fecimpo,Fecexpo,Fmodifw,Faltafw,Fectrans,Horaexpo,Horaimpo,Haltafw,Bdaltafw,Esttrans,Bdmodifw,Hmodifw,Saltafw,Zadsfw,Descfw,Vmodifw,Valtafw,Smodifw,Ualtafw,Umodifw,Inscod,Insdes,Tipo,Codart,Insdesadic,Unidadr,Familia,Unimed,Cantidadr,Material,Linea,Artfab,Codartliqp,Grupo,Codartliqd,Categ,Clasif,Condiva,Poriva,Iobs)
					Select isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.ZADSFW,''),isnull( d.DESCFW,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.INSCOD,''),isnull( d.INSDES,''),isnull( d.TIPO,''),isnull( d.CODART,''),isnull( d.INSDESADIC,''),isnull( d.UNIDADR,''),isnull( d.FAMILIA,''),isnull( d.UNIMED,''),isnull( d.CANTIDADR,0),isnull( d.MATERIAL,''),isnull( d.LINEA,''),isnull( d.ARTFAB,''),isnull( d.CODARTLIQP,''),isnull( d.GRUPO,''),isnull( d.CODARTLIQD,''),isnull( d.CATEG,''),isnull( d.CLASIF,''),isnull( d.CONDIVA,0),isnull( d.PORIVA,0),isnull( d.IOBS,'')
						From deleted d left join ZooLogic.INS pk 
							 on d.INSCOD = pk.INSCOD
						Where pk.INSCOD Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_INS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_INS
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_INSUMO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_INSUMO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_INSUMO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_INSUMO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_INSUMO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_INSUMO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_INSUMO.Horaexpo, [] )
					.Horaimpo = nvl( c_INSUMO.Horaimpo, [] )
					.Horaaltafw = nvl( c_INSUMO.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_INSUMO.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_INSUMO.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_INSUMO.Basededatosmodificacionfw, [] )
					.Horamodificacionfw = nvl( c_INSUMO.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_INSUMO.Seriealtafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Descripcionfw = nvl( c_INSUMO.Descripcionfw, [] )
					.Versionmodificacionfw = nvl( c_INSUMO.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_INSUMO.Versionaltafw, [] )
					.Seriemodificacionfw = nvl( c_INSUMO.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_INSUMO.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_INSUMO.Usuariomodificacionfw, [] )
					.Codigo = nvl( c_INSUMO.Codigo, [] )
					.Descripcion = nvl( c_INSUMO.Descripcion, [] )
					.Tipodeinsumo_PK =  nvl( c_INSUMO.Tipodeinsumo, [] )
					.Articulo_PK =  nvl( c_INSUMO.Articulo, [] )
					.Descripcionadicional = nvl( c_INSUMO.Descripcionadicional, [] )
					.Rindeunidad_PK =  nvl( c_INSUMO.Rindeunidad, [] )
					.Familia_PK =  nvl( c_INSUMO.Familia, [] )
					.Unidaddemedida_PK =  nvl( c_INSUMO.Unidaddemedida, [] )
					.Rindecantidad = nvl( c_INSUMO.Rindecantidad, 0 )
					.Material_PK =  nvl( c_INSUMO.Material, [] )
					.Linea_PK =  nvl( c_INSUMO.Linea, [] )
					.Proveedor_PK =  nvl( c_INSUMO.Proveedor, [] )
					.Articuloliquidacionproduccion_PK =  nvl( c_INSUMO.Articuloliquidacionproduccion, [] )
					.Grupo_PK =  nvl( c_INSUMO.Grupo, [] )
					.Articuloliquidaciondescarte_PK =  nvl( c_INSUMO.Articuloliquidaciondescarte, [] )
					.Categoriadeinsumo_PK =  nvl( c_INSUMO.Categoriadeinsumo, [] )
					.Clasificacion_PK =  nvl( c_INSUMO.Clasificacion, [] )
					.Condicioniva = nvl( c_INSUMO.Condicioniva, 0 )
					.Porcentajeiva = nvl( c_INSUMO.Porcentajeiva, 0 )
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
		return c_INSUMO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.INS' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "INSCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,INSCOD as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    INSCOD from (
							select * 
								from ZooLogic.INS 
								Where   INS.INSCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "INS", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "INSCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Inscod" as "Codigo", "Insdes" as "Descripcion", "Tipo" as "Tipodeinsumo", "Codart" as "Articulo", "Insdesadic" as "Descripcionadicional", "Unidadr" as "Rindeunidad", "Familia" as "Familia", "Unimed" as "Unidaddemedida", "Cantidadr" as "Rindecantidad", "Material" as "Material", "Linea" as "Linea", "Artfab" as "Proveedor", "Codartliqp" as "Articuloliquidacionproduccion", "Grupo" as "Grupo", "Codartliqd" as "Articuloliquidaciondescarte", "Categ" as "Categoriadeinsumo", "Clasif" as "Clasificacion", "Condiva" as "Condicioniva", "Poriva" as "Porcentajeiva", "Iobs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.INS 
								Where   INS.INSCOD != ''
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
	Tabla = 'INS'
	Filtro = " INS.INSCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " INS.INSCOD != ''"
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
	<row entidad="INSUMO                                  " atributo="FECHAIMPO                               " tabla="INS            " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="FECHAEXPO                               " tabla="INS            " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="FECHAMODIFICACIONFW                     " tabla="INS            " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="FECHAALTAFW                             " tabla="INS            " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="FECHATRANSFERENCIA                      " tabla="INS            " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="HORAEXPO                                " tabla="INS            " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="HORAIMPO                                " tabla="INS            " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="HORAALTAFW                              " tabla="INS            " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="BASEDEDATOSALTAFW                       " tabla="INS            " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="ESTADOTRANSFERENCIA                     " tabla="INS            " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="INS            " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="HORAMODIFICACIONFW                      " tabla="INS            " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="SERIEALTAFW                             " tabla="INS            " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="ZADSFW                                  " tabla="INS            " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="DESCRIPCIONFW                           " tabla="INS            " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="VERSIONMODIFICACIONFW                   " tabla="INS            " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="VERSIONALTAFW                           " tabla="INS            " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="SERIEMODIFICACIONFW                     " tabla="INS            " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="USUARIOALTAFW                           " tabla="INS            " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="USUARIOMODIFICACIONFW                   " tabla="INS            " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="CODIGO                                  " tabla="INS            " campo="INSCOD    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="DESCRIPCION                             " tabla="INS            " campo="INSDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="TIPODEINSUMO                            " tabla="INS            " campo="TIPO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPODEARTICULO                          " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="32" etiqueta="Tipo                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="ARTICULO                                " tabla="INS            " campo="CODART    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Artículo                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="DESCRIPCIONADICIONAL                    " tabla="INS            " campo="INSDESADIC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción adicional                                                                                                                                           " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="RINDEUNIDAD                             " tabla="INS            " campo="UNIDADR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="UNIDADDEMEDIDA                          " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Unidad de producción                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="FAMILIA                                 " tabla="INS            " campo="FAMILIA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="FAMILIA                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Familia                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="UNIDADDEMEDIDA                          " tabla="INS            " campo="UNIMED    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="UNIDADDEMEDIDA                          " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Unidad de medida                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="RINDECANTIDAD                           " tabla="INS            " campo="CANTIDADR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Rinde de producción                                                                                                                                             " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="MATERIAL                                " tabla="INS            " campo="MATERIAL  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MATERIAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="22" etiqueta="Material                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="LINEA                                   " tabla="INS            " campo="LINEA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LINEA                                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="24" etiqueta="Línea                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="PROVEEDOR                               " tabla="INS            " campo="ARTFAB    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="ARTICULOLIQUIDACIONPRODUCCION           " tabla="INS            " campo="CODARTLIQP" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Artículo liquidación producción                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="GRUPO                                   " tabla="INS            " campo="GRUPO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="GRUPO                                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="26" etiqueta="Grupo                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="ARTICULOLIQUIDACIONDESCARTE             " tabla="INS            " campo="CODARTLIQD" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Artículo liquidación descarte                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="CATEGORIADEINSUMO                       " tabla="INS            " campo="CATEG     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CATEGORIADEARTICULO                     " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="28" etiqueta="Categoría                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="CLASIFICACION                           " tabla="INS            " campo="CLASIF    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONARTICULO                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="30" etiqueta="Clasificación                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="CONDICIONIVA                            " tabla="INS            " campo="CONDIVA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Condición de impuestos                                                                                                                                          " dominio="COMBOCONDICIONIVA             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="22" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="PORCENTAJEIVA                           " tabla="INS            " campo="PORIVA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Porcentaje                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="23" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="OBSERVACION                             " tabla="INS            " campo="IOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODEARTICULO                          " atributo="DESCRIPCION                             " tabla="TIPOART        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="33" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOART On INS.TIPO = TIPOART.Cod And  TIPOART.COD != ''                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="13" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On INS.CODART = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="UNIDADDEMEDIDA                          " atributo="DESCRIPCION                             " tabla="UNMED          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="17" etiqueta="Detalle Uni.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join UNMED On INS.UNIDADR = UNMED.Cod And  UNMED.COD != ''                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FAMILIA                                 " atributo="DESCRIPCION                             " tabla="FAMILIA        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="21" etiqueta="Detalle Fam.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FAMILIA On INS.FAMILIA = FAMILIA.Cod And  FAMILIA.COD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="UNIDADDEMEDIDA                          " atributo="DESCRIPCION                             " tabla="UNMED          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="15" etiqueta="Detalle Uni.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join UNMED On INS.UNIMED = UNMED.Cod And  UNMED.COD != ''                                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MATERIAL                                " atributo="DESCRIPCION                             " tabla="MAT            " campo="MATDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="23" etiqueta="Detalle Mat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MAT On INS.MATERIAL = MAT.MATCOD And  MAT.MATCOD != ''                                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINEA                                   " atributo="DESCRIPCION                             " tabla="LINEA          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="25" etiqueta="Detalle Lín.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LINEA On INS.LINEA = LINEA.Cod And  LINEA.COD != ''                                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="13" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On INS.ARTFAB = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="13" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On INS.CODARTLIQP = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPO                                   " atributo="DESCRIPCION                             " tabla="GRUPO          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="27" etiqueta="Detalle Gru.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join GRUPO On INS.GRUPO = GRUPO.Cod And  GRUPO.COD != ''                                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="13" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On INS.CODARTLIQD = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIADEARTICULO                     " atributo="DESCRIPCION                             " tabla="CATEGART       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="29" etiqueta="Detalle Cat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CATEGART On INS.CATEG = CATEGART.Cod And  CATEGART.COD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONARTICULO                   " atributo="DESCRIPCION                             " tabla="CLASIFART      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="31" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIFART On INS.CLASIF = CLASIFART.CODIGO And  CLASIFART.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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