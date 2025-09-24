
define class Din_EntidadCATEGORIASECOMMERCEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CATEGORIASECOMMERCE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_CTGPK'
	cTablaPrincipal = 'CATEGECOM'
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
			local  lxCategecomFecimpo, lxCategecomFectrans, lxCategecomFmodifw, lxCategecomFecexpo, lxCategecomFaltafw, lxCategecomHoraexpo, lxCategecomHaltafw, lxCategecomHoraimpo, lxCategecomSaltafw, lxCategecomUaltafw, lxCategecomValtafw, lxCategecomSmodifw, lxCategecomHmodifw, lxCategecomVmodifw, lxCategecomZadsfw, lxCategecomCodrama, lxCategecomBdaltafw, lxCategecomUmodifw, lxCategecomBdmodifw, lxCategecomEsttrans, lxCategecomCodigo, lxCategecomCateg, lxCategecomSubcatde, lxCategecomOrden, lxCategecomRama, lxCategecomCatgs, lxCategecomTituloseo, lxCategecomDescseo, lxCategecomUrl, lxCategecomObs
				lxCategecomFecimpo =  .Fechaimpo			lxCategecomFectrans =  .Fechatransferencia			lxCategecomFmodifw =  .Fechamodificacionfw			lxCategecomFecexpo =  .Fechaexpo			lxCategecomFaltafw =  .Fechaaltafw			lxCategecomHoraexpo =  .Horaexpo			lxCategecomHaltafw =  .Horaaltafw			lxCategecomHoraimpo =  .Horaimpo			lxCategecomSaltafw =  .Seriealtafw			lxCategecomUaltafw =  .Usuarioaltafw			lxCategecomValtafw =  .Versionaltafw			lxCategecomSmodifw =  .Seriemodificacionfw			lxCategecomHmodifw =  .Horamodificacionfw			lxCategecomVmodifw =  .Versionmodificacionfw			lxCategecomZadsfw =  .Zadsfw			lxCategecomCodrama =  .Codigosrama			lxCategecomBdaltafw =  .Basededatosaltafw			lxCategecomUmodifw =  .Usuariomodificacionfw			lxCategecomBdmodifw =  .Basededatosmodificacionfw			lxCategecomEsttrans =  .Estadotransferencia			lxCategecomCodigo =  .Codigo			lxCategecomCateg =  .Categoria			lxCategecomSubcatde =  upper( .EsSubcategoriaDe_PK ) 			lxCategecomOrden =  .Orden			lxCategecomRama =  .Rama			lxCategecomCatgs =  upper( .CategoriaGS_PK ) 			lxCategecomTituloseo =  .Tituloseo			lxCategecomDescseo =  .Descripcionseo			lxCategecomUrl =  .Url			lxCategecomObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCategecomCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CATEGECOM ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Horaexpo","Haltafw","Horaimpo","Saltafw","Ualtafw","Valtafw","Smodifw","Hmodifw","Vmodifw","Zadsfw","Codrama","Bdaltafw","Umodifw","Bdmodifw","Esttrans","Codigo","Categ","Subcatde","Orden","Rama","Catgs","Tituloseo","Descseo","Url","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCategecomFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCategecomFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCategecomFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCategecomFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCategecomFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomCodrama ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomCateg ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomSubcatde ) + "'" >>, <<lxCategecomOrden >>, <<"'" + this.FormatearTextoSql( lxCategecomRama ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomCatgs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomTituloseo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomDescseo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomUrl ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomObs ) + "'" >> )
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
			local  lxCategecomFecimpo, lxCategecomFectrans, lxCategecomFmodifw, lxCategecomFecexpo, lxCategecomFaltafw, lxCategecomHoraexpo, lxCategecomHaltafw, lxCategecomHoraimpo, lxCategecomSaltafw, lxCategecomUaltafw, lxCategecomValtafw, lxCategecomSmodifw, lxCategecomHmodifw, lxCategecomVmodifw, lxCategecomZadsfw, lxCategecomCodrama, lxCategecomBdaltafw, lxCategecomUmodifw, lxCategecomBdmodifw, lxCategecomEsttrans, lxCategecomCodigo, lxCategecomCateg, lxCategecomSubcatde, lxCategecomOrden, lxCategecomRama, lxCategecomCatgs, lxCategecomTituloseo, lxCategecomDescseo, lxCategecomUrl, lxCategecomObs
				lxCategecomFecimpo =  .Fechaimpo			lxCategecomFectrans =  .Fechatransferencia			lxCategecomFmodifw =  .Fechamodificacionfw			lxCategecomFecexpo =  .Fechaexpo			lxCategecomFaltafw =  .Fechaaltafw			lxCategecomHoraexpo =  .Horaexpo			lxCategecomHaltafw =  .Horaaltafw			lxCategecomHoraimpo =  .Horaimpo			lxCategecomSaltafw =  .Seriealtafw			lxCategecomUaltafw =  .Usuarioaltafw			lxCategecomValtafw =  .Versionaltafw			lxCategecomSmodifw =  .Seriemodificacionfw			lxCategecomHmodifw =  .Horamodificacionfw			lxCategecomVmodifw =  .Versionmodificacionfw			lxCategecomZadsfw =  .Zadsfw			lxCategecomCodrama =  .Codigosrama			lxCategecomBdaltafw =  .Basededatosaltafw			lxCategecomUmodifw =  .Usuariomodificacionfw			lxCategecomBdmodifw =  .Basededatosmodificacionfw			lxCategecomEsttrans =  .Estadotransferencia			lxCategecomCodigo =  .Codigo			lxCategecomCateg =  .Categoria			lxCategecomSubcatde =  upper( .EsSubcategoriaDe_PK ) 			lxCategecomOrden =  .Orden			lxCategecomRama =  .Rama			lxCategecomCatgs =  upper( .CategoriaGS_PK ) 			lxCategecomTituloseo =  .Tituloseo			lxCategecomDescseo =  .Descripcionseo			lxCategecomUrl =  .Url			lxCategecomObs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CATEGECOM set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCategecomFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCategecomFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCategecomFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCategecomFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCategecomFaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCategecomHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCategecomHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCategecomHoraimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCategecomSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCategecomUaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCategecomValtafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCategecomSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCategecomHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCategecomVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCategecomZadsfw ) + "'">>,"Codrama" = <<"'" + this.FormatearTextoSql( lxCategecomCodrama ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCategecomBdaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCategecomUmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCategecomBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCategecomEsttrans ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCategecomCodigo ) + "'">>,"Categ" = <<"'" + this.FormatearTextoSql( lxCategecomCateg ) + "'">>,"Subcatde" = <<"'" + this.FormatearTextoSql( lxCategecomSubcatde ) + "'">>,"Orden" = <<lxCategecomOrden>>,"Rama" = <<"'" + this.FormatearTextoSql( lxCategecomRama ) + "'">>,"Catgs" = <<"'" + this.FormatearTextoSql( lxCategecomCatgs ) + "'">>,"Tituloseo" = <<"'" + this.FormatearTextoSql( lxCategecomTituloseo ) + "'">>,"Descseo" = <<"'" + this.FormatearTextoSql( lxCategecomDescseo ) + "'">>,"Url" = <<"'" + this.FormatearTextoSql( lxCategecomUrl ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxCategecomObs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCategecomCodigo ) + "'">> and  CATEGECOM.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.CATEGECOM where " + this.ConvertirFuncionesSql( " CATEGECOM.CODIGO != ''" ) )
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
			Local lxCategecomCodigo
			lxCategecomCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Codrama" as "Codigosrama", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Categ" as "Categoria", "Subcatde" as "Essubcategoriade", "Orden" as "Orden", "Rama" as "Rama", "Catgs" as "Categoriags", "Tituloseo" as "Tituloseo", "Descseo" as "Descripcionseo", "Url" as "Url", "Obs" as "Observacion" from ZooLogic.CATEGECOM where "Codigo" = <<"'" + this.FormatearTextoSql( lxCategecomCodigo ) + "'">> and  CATEGECOM.CODIGO != ''
			endtext
			use in select('c_CATEGORIASECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CATEGORIASECOMMERCE', set( 'Datasession' ) )

			if reccount( 'c_CATEGORIASECOMMERCE' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCategecomCodigo as Variant
		llRetorno = .t.
		lxCategecomCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CATEGECOM where "Codigo" = <<"'" + this.FormatearTextoSql( lxCategecomCodigo ) + "'">> and  CATEGECOM.CODIGO != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Codrama" as "Codigosrama", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Categ" as "Categoria", "Subcatde" as "Essubcategoriade", "Orden" as "Orden", "Rama" as "Rama", "Catgs" as "Categoriags", "Tituloseo" as "Tituloseo", "Descseo" as "Descripcionseo", "Url" as "Url", "Obs" as "Observacion" from ZooLogic.CATEGECOM where  CATEGECOM.CODIGO != '' order by Codigo
			endtext
			use in select('c_CATEGORIASECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CATEGORIASECOMMERCE', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Codrama" as "Codigosrama", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Categ" as "Categoria", "Subcatde" as "Essubcategoriade", "Orden" as "Orden", "Rama" as "Rama", "Catgs" as "Categoriags", "Tituloseo" as "Tituloseo", "Descseo" as "Descripcionseo", "Url" as "Url", "Obs" as "Observacion" from ZooLogic.CATEGECOM where  funciones.padr( Codigo, 15, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CATEGECOM.CODIGO != '' order by Codigo
			endtext
			use in select('c_CATEGORIASECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CATEGORIASECOMMERCE', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Codrama" as "Codigosrama", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Categ" as "Categoria", "Subcatde" as "Essubcategoriade", "Orden" as "Orden", "Rama" as "Rama", "Catgs" as "Categoriags", "Tituloseo" as "Tituloseo", "Descseo" as "Descripcionseo", "Url" as "Url", "Obs" as "Observacion" from ZooLogic.CATEGECOM where  funciones.padr( Codigo, 15, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CATEGECOM.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_CATEGORIASECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CATEGORIASECOMMERCE', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Codrama" as "Codigosrama", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Categ" as "Categoria", "Subcatde" as "Essubcategoriade", "Orden" as "Orden", "Rama" as "Rama", "Catgs" as "Categoriags", "Tituloseo" as "Tituloseo", "Descseo" as "Descripcionseo", "Url" as "Url", "Obs" as "Observacion" from ZooLogic.CATEGECOM where  CATEGECOM.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_CATEGORIASECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CATEGORIASECOMMERCE', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Horaexpo,Haltafw,Horaimpo,Saltafw,Ualtafw,Valtafw,S" + ;
"modifw,Hmodifw,Vmodifw,Zadsfw,Codrama,Bdaltafw,Umodifw,Bdmodifw,Esttrans,Codigo,Categ,Subcatde,Orden" + ;
",Rama,Catgs,Tituloseo,Descseo,Url,Obs" + ;
" from ZooLogic.CATEGECOM where  CATEGECOM.CODIGO != '' and " + lcFiltro )
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
			local  lxCategecomFecimpo, lxCategecomFectrans, lxCategecomFmodifw, lxCategecomFecexpo, lxCategecomFaltafw, lxCategecomHoraexpo, lxCategecomHaltafw, lxCategecomHoraimpo, lxCategecomSaltafw, lxCategecomUaltafw, lxCategecomValtafw, lxCategecomSmodifw, lxCategecomHmodifw, lxCategecomVmodifw, lxCategecomZadsfw, lxCategecomCodrama, lxCategecomBdaltafw, lxCategecomUmodifw, lxCategecomBdmodifw, lxCategecomEsttrans, lxCategecomCodigo, lxCategecomCateg, lxCategecomSubcatde, lxCategecomOrden, lxCategecomRama, lxCategecomCatgs, lxCategecomTituloseo, lxCategecomDescseo, lxCategecomUrl, lxCategecomObs
				lxCategecomFecimpo = ctod( '  /  /    ' )			lxCategecomFectrans = ctod( '  /  /    ' )			lxCategecomFmodifw = ctod( '  /  /    ' )			lxCategecomFecexpo = ctod( '  /  /    ' )			lxCategecomFaltafw = ctod( '  /  /    ' )			lxCategecomHoraexpo = []			lxCategecomHaltafw = []			lxCategecomHoraimpo = []			lxCategecomSaltafw = []			lxCategecomUaltafw = []			lxCategecomValtafw = []			lxCategecomSmodifw = []			lxCategecomHmodifw = []			lxCategecomVmodifw = []			lxCategecomZadsfw = []			lxCategecomCodrama = []			lxCategecomBdaltafw = []			lxCategecomUmodifw = []			lxCategecomBdmodifw = []			lxCategecomEsttrans = []			lxCategecomCodigo = []			lxCategecomCateg = []			lxCategecomSubcatde = []			lxCategecomOrden = 0			lxCategecomRama = []			lxCategecomCatgs = []			lxCategecomTituloseo = []			lxCategecomDescseo = []			lxCategecomUrl = []			lxCategecomObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CATEGECOM where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CATEGECOM' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where Codigo = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(Codigo, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CATEGECOM.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Codrama" as "Codigosrama", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Categ" as "Categoria", "Subcatde" as "Essubcategoriade", "Orden" as "Orden", "Rama" as "Rama", "Catgs" as "Categoriags", "Tituloseo" as "Tituloseo", "Descseo" as "Descripcionseo", "Url" as "Url", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CATEGECOM', '', tnTope )
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
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'CODIGOSRAMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODRAMA AS CODIGOSRAMA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CATEGORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATEG AS CATEGORIA'
				Case lcAtributo == 'ESSUBCATEGORIADE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBCATDE AS ESSUBCATEGORIADE'
				Case lcAtributo == 'ORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORDEN AS ORDEN'
				Case lcAtributo == 'RAMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RAMA AS RAMA'
				Case lcAtributo == 'CATEGORIAGS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATGS AS CATEGORIAGS'
				Case lcAtributo == 'TITULOSEO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TITULOSEO AS TITULOSEO'
				Case lcAtributo == 'DESCRIPCIONSEO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCSEO AS DESCRIPCIONSEO'
				Case lcAtributo == 'URL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'URL AS URL'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
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
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOSRAMA'
				lcCampo = 'CODRAMA'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CATEGORIA'
				lcCampo = 'CATEG'
			Case upper( alltrim( tcAtributo ) ) == 'ESSUBCATEGORIADE'
				lcCampo = 'SUBCATDE'
			Case upper( alltrim( tcAtributo ) ) == 'ORDEN'
				lcCampo = 'ORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'RAMA'
				lcCampo = 'RAMA'
			Case upper( alltrim( tcAtributo ) ) == 'CATEGORIAGS'
				lcCampo = 'CATGS'
			Case upper( alltrim( tcAtributo ) ) == 'TITULOSEO'
				lcCampo = 'TITULOSEO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONSEO'
				lcCampo = 'DESCSEO'
			Case upper( alltrim( tcAtributo ) ) == 'URL'
				lcCampo = 'URL'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
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
			local  lxCategecomFecimpo, lxCategecomFectrans, lxCategecomFmodifw, lxCategecomFecexpo, lxCategecomFaltafw, lxCategecomHoraexpo, lxCategecomHaltafw, lxCategecomHoraimpo, lxCategecomSaltafw, lxCategecomUaltafw, lxCategecomValtafw, lxCategecomSmodifw, lxCategecomHmodifw, lxCategecomVmodifw, lxCategecomZadsfw, lxCategecomCodrama, lxCategecomBdaltafw, lxCategecomUmodifw, lxCategecomBdmodifw, lxCategecomEsttrans, lxCategecomCodigo, lxCategecomCateg, lxCategecomSubcatde, lxCategecomOrden, lxCategecomRama, lxCategecomCatgs, lxCategecomTituloseo, lxCategecomDescseo, lxCategecomUrl, lxCategecomObs
				lxCategecomFecimpo =  .Fechaimpo			lxCategecomFectrans =  .Fechatransferencia			lxCategecomFmodifw =  .Fechamodificacionfw			lxCategecomFecexpo =  .Fechaexpo			lxCategecomFaltafw =  .Fechaaltafw			lxCategecomHoraexpo =  .Horaexpo			lxCategecomHaltafw =  .Horaaltafw			lxCategecomHoraimpo =  .Horaimpo			lxCategecomSaltafw =  .Seriealtafw			lxCategecomUaltafw =  .Usuarioaltafw			lxCategecomValtafw =  .Versionaltafw			lxCategecomSmodifw =  .Seriemodificacionfw			lxCategecomHmodifw =  .Horamodificacionfw			lxCategecomVmodifw =  .Versionmodificacionfw			lxCategecomZadsfw =  .Zadsfw			lxCategecomCodrama =  .Codigosrama			lxCategecomBdaltafw =  .Basededatosaltafw			lxCategecomUmodifw =  .Usuariomodificacionfw			lxCategecomBdmodifw =  .Basededatosmodificacionfw			lxCategecomEsttrans =  .Estadotransferencia			lxCategecomCodigo =  .Codigo			lxCategecomCateg =  .Categoria			lxCategecomSubcatde =  upper( .EsSubcategoriaDe_PK ) 			lxCategecomOrden =  .Orden			lxCategecomRama =  .Rama			lxCategecomCatgs =  upper( .CategoriaGS_PK ) 			lxCategecomTituloseo =  .Tituloseo			lxCategecomDescseo =  .Descripcionseo			lxCategecomUrl =  .Url			lxCategecomObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CATEGECOM ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Horaexpo","Haltafw","Horaimpo","Saltafw","Ualtafw","Valtafw","Smodifw","Hmodifw","Vmodifw","Zadsfw","Codrama","Bdaltafw","Umodifw","Bdmodifw","Esttrans","Codigo","Categ","Subcatde","Orden","Rama","Catgs","Tituloseo","Descseo","Url","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCategecomFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCategecomFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCategecomFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCategecomFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCategecomFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomCodrama ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomCateg ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomSubcatde ) + "'" >>, <<lxCategecomOrden >>, <<"'" + this.FormatearTextoSql( lxCategecomRama ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomCatgs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomTituloseo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomDescseo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomUrl ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCategecomObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CATEGECOM' 
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
			local  lxCategecomFecimpo, lxCategecomFectrans, lxCategecomFmodifw, lxCategecomFecexpo, lxCategecomFaltafw, lxCategecomHoraexpo, lxCategecomHaltafw, lxCategecomHoraimpo, lxCategecomSaltafw, lxCategecomUaltafw, lxCategecomValtafw, lxCategecomSmodifw, lxCategecomHmodifw, lxCategecomVmodifw, lxCategecomZadsfw, lxCategecomCodrama, lxCategecomBdaltafw, lxCategecomUmodifw, lxCategecomBdmodifw, lxCategecomEsttrans, lxCategecomCodigo, lxCategecomCateg, lxCategecomSubcatde, lxCategecomOrden, lxCategecomRama, lxCategecomCatgs, lxCategecomTituloseo, lxCategecomDescseo, lxCategecomUrl, lxCategecomObs
				lxCategecomFecimpo =  .Fechaimpo			lxCategecomFectrans =  .Fechatransferencia			lxCategecomFmodifw =  .Fechamodificacionfw			lxCategecomFecexpo =  .Fechaexpo			lxCategecomFaltafw =  .Fechaaltafw			lxCategecomHoraexpo =  .Horaexpo			lxCategecomHaltafw =  .Horaaltafw			lxCategecomHoraimpo =  .Horaimpo			lxCategecomSaltafw =  .Seriealtafw			lxCategecomUaltafw =  .Usuarioaltafw			lxCategecomValtafw =  .Versionaltafw			lxCategecomSmodifw =  .Seriemodificacionfw			lxCategecomHmodifw =  .Horamodificacionfw			lxCategecomVmodifw =  .Versionmodificacionfw			lxCategecomZadsfw =  .Zadsfw			lxCategecomCodrama =  .Codigosrama			lxCategecomBdaltafw =  .Basededatosaltafw			lxCategecomUmodifw =  .Usuariomodificacionfw			lxCategecomBdmodifw =  .Basededatosmodificacionfw			lxCategecomEsttrans =  .Estadotransferencia			lxCategecomCodigo =  .Codigo			lxCategecomCateg =  .Categoria			lxCategecomSubcatde =  upper( .EsSubcategoriaDe_PK ) 			lxCategecomOrden =  .Orden			lxCategecomRama =  .Rama			lxCategecomCatgs =  upper( .CategoriaGS_PK ) 			lxCategecomTituloseo =  .Tituloseo			lxCategecomDescseo =  .Descripcionseo			lxCategecomUrl =  .Url			lxCategecomObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CATEGECOM.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CATEGECOM set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCategecomFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCategecomFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCategecomFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCategecomFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCategecomFaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCategecomHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCategecomHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCategecomHoraimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCategecomSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCategecomUaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCategecomValtafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCategecomSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCategecomHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCategecomVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCategecomZadsfw ) + "'">>, "Codrama" = <<"'" + this.FormatearTextoSql( lxCategecomCodrama ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCategecomBdaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCategecomUmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCategecomBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCategecomEsttrans ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCategecomCodigo ) + "'">>, "Categ" = <<"'" + this.FormatearTextoSql( lxCategecomCateg ) + "'">>, "Subcatde" = <<"'" + this.FormatearTextoSql( lxCategecomSubcatde ) + "'">>, "Orden" = <<lxCategecomOrden>>, "Rama" = <<"'" + this.FormatearTextoSql( lxCategecomRama ) + "'">>, "Catgs" = <<"'" + this.FormatearTextoSql( lxCategecomCatgs ) + "'">>, "Tituloseo" = <<"'" + this.FormatearTextoSql( lxCategecomTituloseo ) + "'">>, "Descseo" = <<"'" + this.FormatearTextoSql( lxCategecomDescseo ) + "'">>, "Url" = <<"'" + this.FormatearTextoSql( lxCategecomUrl ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxCategecomObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CATEGECOM' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CATEGECOM.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.CATEGECOM where ' + lcFiltro )
			loColeccion.cTabla = 'CATEGECOM' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CATEGECOM where  CATEGECOM.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CATEGECOM where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CATEGECOM.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CATEGORIASECOMMERCE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CATEGECOM Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CATEGECOM set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, CodRama = ] + "'" + this.FormatearTextoSql( &lcCursor..CodRama ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Categ = ] + "'" + this.FormatearTextoSql( &lcCursor..Categ ) + "'"+ [, SubcatDe = ] + "'" + this.FormatearTextoSql( &lcCursor..SubcatDe ) + "'"+ [, Orden = ] + transform( &lcCursor..Orden )+ [, Rama = ] + "'" + this.FormatearTextoSql( &lcCursor..Rama ) + "'"+ [, CatGS = ] + "'" + this.FormatearTextoSql( &lcCursor..CatGS ) + "'"+ [, TituloSEO = ] + "'" + this.FormatearTextoSql( &lcCursor..TituloSEO ) + "'"+ [, DescSEO = ] + "'" + this.FormatearTextoSql( &lcCursor..DescSEO ) + "'"+ [, URL = ] + "'" + this.FormatearTextoSql( &lcCursor..URL ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, HORAEXPO, HALTAFW, HORAIMPO, SALTAFW, UALTAFW, VALTAFW, SMODIFW, HMODIFW, VMODIFW, ZADSFW, CodRama, BDALTAFW, UMODIFW, BDMODIFW, ESTTRANS, Codigo, Categ, SubcatDe, Orden, Rama, CatGS, TituloSEO, DescSEO, URL, Obs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodRama ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Categ ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SubcatDe ) + "'" + ',' + transform( &lcCursor..Orden ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Rama ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CatGS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TituloSEO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescSEO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..URL ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CATEGECOM ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CATEGORIASECOMMERCE'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (15) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CATEGORIASECOMMERCE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CATEGORIASECOMMERCE_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CATEGORIASECOMMERCE_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CategEcom')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CATEGORIASECOMMERCE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CATEGORIASECOMMERCE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CATEGORIASECOMMERCE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CATEGORIASECOMMERCE'
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CategEcom') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CategEcom
Create Table ZooLogic.TablaTrabajo_CategEcom ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"codrama" char( 254 )  null, 
"bdaltafw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"codigo" char( 15 )  null, 
"categ" char( 100 )  null, 
"subcatde" char( 15 )  null, 
"orden" numeric( 3, 0 )  null, 
"rama" char( 254 )  null, 
"catgs" char( 15 )  null, 
"tituloseo" char( 100 )  null, 
"descseo" char( 100 )  null, 
"url" char( 250 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CategEcom' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CategEcom' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CATEGORIASECOMMERCE'
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
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('codrama','codrama')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('categ','categ')
			.AgregarMapeo('subcatde','subcatde')
			.AgregarMapeo('orden','orden')
			.AgregarMapeo('rama','rama')
			.AgregarMapeo('catgs','catgs')
			.AgregarMapeo('tituloseo','tituloseo')
			.AgregarMapeo('descseo','descseo')
			.AgregarMapeo('url','url')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CategEcom'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.CODRAMA = isnull( d.CODRAMA, t.CODRAMA ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.CATEG = isnull( d.CATEG, t.CATEG ),t.SUBCATDE = isnull( d.SUBCATDE, t.SUBCATDE ),t.ORDEN = isnull( d.ORDEN, t.ORDEN ),t.RAMA = isnull( d.RAMA, t.RAMA ),t.CATGS = isnull( d.CATGS, t.CATGS ),t.TITULOSEO = isnull( d.TITULOSEO, t.TITULOSEO ),t.DESCSEO = isnull( d.DESCSEO, t.DESCSEO ),t.URL = isnull( d.URL, t.URL ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.CATEGECOM t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.CATEGECOM(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Horaexpo,Haltafw,Horaimpo,Saltafw,Ualtafw,Valtafw,Smodifw,Hmodifw,Vmodifw,Zadsfw,Codrama,Bdaltafw,Umodifw,Bdmodifw,Esttrans,Codigo,Categ,Subcatde,Orden,Rama,Catgs,Tituloseo,Descseo,Url,Obs)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.VALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.CODRAMA,''),isnull( d.BDALTAFW,''),isnull( d.UMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.CODIGO,''),isnull( d.CATEG,''),isnull( d.SUBCATDE,''),isnull( d.ORDEN,0),isnull( d.RAMA,''),isnull( d.CATGS,''),isnull( d.TITULOSEO,''),isnull( d.DESCSEO,''),isnull( d.URL,''),isnull( d.OBS,'')
						From deleted d left join ZooLogic.CATEGECOM pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CategEcom') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CategEcom
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CATEGORIASECOMMERCE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CATEGORIASECOMMERCE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CATEGORIASECOMMERCE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CATEGORIASECOMMERCE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CATEGORIASECOMMERCE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CATEGORIASECOMMERCE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_CATEGORIASECOMMERCE.Horaexpo, [] )
					.Horaaltafw = nvl( c_CATEGORIASECOMMERCE.Horaaltafw, [] )
					.Horaimpo = nvl( c_CATEGORIASECOMMERCE.Horaimpo, [] )
					.Seriealtafw = nvl( c_CATEGORIASECOMMERCE.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_CATEGORIASECOMMERCE.Usuarioaltafw, [] )
					.Versionaltafw = nvl( c_CATEGORIASECOMMERCE.Versionaltafw, [] )
					.Seriemodificacionfw = nvl( c_CATEGORIASECOMMERCE.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_CATEGORIASECOMMERCE.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_CATEGORIASECOMMERCE.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Codigosrama = nvl( c_CATEGORIASECOMMERCE.Codigosrama, [] )
					.Basededatosaltafw = nvl( c_CATEGORIASECOMMERCE.Basededatosaltafw, [] )
					.Usuariomodificacionfw = nvl( c_CATEGORIASECOMMERCE.Usuariomodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_CATEGORIASECOMMERCE.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_CATEGORIASECOMMERCE.Estadotransferencia, [] )
					.Codigo = nvl( c_CATEGORIASECOMMERCE.Codigo, [] )
					.Categoria = nvl( c_CATEGORIASECOMMERCE.Categoria, [] )
					.Essubcategoriade_PK =  nvl( c_CATEGORIASECOMMERCE.Essubcategoriade, [] )
					.Orden = nvl( c_CATEGORIASECOMMERCE.Orden, 0 )
					.Rama = nvl( c_CATEGORIASECOMMERCE.Rama, [] )
					.Categoriags_PK =  nvl( c_CATEGORIASECOMMERCE.Categoriags, [] )
					.Tituloseo = nvl( c_CATEGORIASECOMMERCE.Tituloseo, [] )
					.Descripcionseo = nvl( c_CATEGORIASECOMMERCE.Descripcionseo, [] )
					.Url = nvl( c_CATEGORIASECOMMERCE.Url, [] )
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
		return c_CATEGORIASECOMMERCE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CATEGECOM' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,Codigo as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    Codigo from (
							select * 
								from ZooLogic.CATEGECOM 
								Where   CATEGECOM.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CATEGECOM", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Codrama" as "Codigosrama", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Categ" as "Categoria", "Subcatde" as "Essubcategoriade", "Orden" as "Orden", "Rama" as "Rama", "Catgs" as "Categoriags", "Tituloseo" as "Tituloseo", "Descseo" as "Descripcionseo", "Url" as "Url", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CATEGECOM 
								Where   CATEGECOM.CODIGO != ''
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
	Tabla = 'CATEGECOM'
	Filtro = " CATEGECOM.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CATEGECOM.CODIGO != ''"
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
	<row entidad="CATEGORIASECOMMERCE                     " atributo="FECHAIMPO                               " tabla="CATEGECOM      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="FECHATRANSFERENCIA                      " tabla="CATEGECOM      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="FECHAMODIFICACIONFW                     " tabla="CATEGECOM      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="FECHAEXPO                               " tabla="CATEGECOM      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="FECHAALTAFW                             " tabla="CATEGECOM      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="HORAEXPO                                " tabla="CATEGECOM      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="HORAALTAFW                              " tabla="CATEGECOM      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="HORAIMPO                                " tabla="CATEGECOM      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="SERIEALTAFW                             " tabla="CATEGECOM      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="USUARIOALTAFW                           " tabla="CATEGECOM      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="VERSIONALTAFW                           " tabla="CATEGECOM      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="SERIEMODIFICACIONFW                     " tabla="CATEGECOM      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="HORAMODIFICACIONFW                      " tabla="CATEGECOM      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="VERSIONMODIFICACIONFW                   " tabla="CATEGECOM      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="ZADSFW                                  " tabla="CATEGECOM      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="CODIGOSRAMA                             " tabla="CATEGECOM      " campo="CODRAMA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="BASEDEDATOSALTAFW                       " tabla="CATEGECOM      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="USUARIOMODIFICACIONFW                   " tabla="CATEGECOM      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CATEGECOM      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="ESTADOTRANSFERENCIA                     " tabla="CATEGECOM      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="CODIGO                                  " tabla="CATEGECOM      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="CATEGORIA                               " tabla="CATEGECOM      " campo="CATEG     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Categoría                                                                                                                                                       " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="ESSUBCATEGORIADE                        " tabla="CATEGECOM      " campo="SUBCATDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CATEGORIASECOMMERCE                     " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Es subcategoría de                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="ORDEN                                   " tabla="CATEGECOM      " campo="ORDEN     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Orden                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="RAMA                                    " tabla="CATEGECOM      " campo="RAMA      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Rama                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="CATEGORIAGS                             " tabla="CATEGECOM      " campo="CATGS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CATEGORIASGOOGLESHOPPING                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Categoría de Google Shopping                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="TITULOSEO                               " tabla="CATEGECOM      " campo="TITULOSEO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Título para SEO                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="DESCRIPCIONSEO                          " tabla="CATEGECOM      " campo="DESCSEO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Descripción para SEO                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="URL                                     " tabla="CATEGECOM      " campo="URL       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="URL de la categoría                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="ARBOLCATEGORIAS                         " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Árbol de categorías                                                                                                                                             " dominio="COMBO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASECOMMERCE                     " atributo="OBSERVACION                             " tabla="CATEGECOM      " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIASGOOGLESHOPPING                " atributo="DESCRIPCION                             " tabla="CATEGGS        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="11" etiqueta="Detalle Cat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CATEGGS On CATEGECOM.CATGS = CATEGGS.Codigo And  CATEGGS.CODIGO != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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