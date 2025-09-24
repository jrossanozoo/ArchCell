
define class Din_EntidadAGRUPALISTADOSPERSONALIZADOSAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_AGRUPALISTADOSPERSONALIZADOS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [Codigo]
	cExpresionCCPorCampos = [#tabla#.Codigo]
	cTagClaveCandidata = '_ALPCC'
	cTagClavePk = '_ALPPK'
	cTablaPrincipal = 'AGRPLTDS'
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
			local  lxAgrpltdsFecexpo, lxAgrpltdsFectrans, lxAgrpltdsFmodifw, lxAgrpltdsFaltafw, lxAgrpltdsFecimpo, lxAgrpltdsUaltafw, lxAgrpltdsHmodifw, lxAgrpltdsSmodifw, lxAgrpltdsSaltafw, lxAgrpltdsUmodifw, lxAgrpltdsZadsfw, lxAgrpltdsValtafw, lxAgrpltdsVmodifw, lxAgrpltdsHoraimpo, lxAgrpltdsHoraexpo, lxAgrpltdsHaltafw, lxAgrpltdsEsttrans, lxAgrpltdsBdaltafw, lxAgrpltdsBdmodifw, lxAgrpltdsNombre, lxAgrpltdsDescrip, lxAgrpltdsFiltrafec, lxAgrpltdsObs, lxAgrpltdsCategoria, lxAgrpltdsFavorito, lxAgrpltdsCodigo
				lxAgrpltdsFecexpo =  .Fechaexpo			lxAgrpltdsFectrans =  .Fechatransferencia			lxAgrpltdsFmodifw =  .Fechamodificacionfw			lxAgrpltdsFaltafw =  .Fechaaltafw			lxAgrpltdsFecimpo =  .Fechaimpo			lxAgrpltdsUaltafw =  .Usuarioaltafw			lxAgrpltdsHmodifw =  .Horamodificacionfw			lxAgrpltdsSmodifw =  .Seriemodificacionfw			lxAgrpltdsSaltafw =  .Seriealtafw			lxAgrpltdsUmodifw =  .Usuariomodificacionfw			lxAgrpltdsZadsfw =  .Zadsfw			lxAgrpltdsValtafw =  .Versionaltafw			lxAgrpltdsVmodifw =  .Versionmodificacionfw			lxAgrpltdsHoraimpo =  .Horaimpo			lxAgrpltdsHoraexpo =  .Horaexpo			lxAgrpltdsHaltafw =  .Horaaltafw			lxAgrpltdsEsttrans =  .Estadotransferencia			lxAgrpltdsBdaltafw =  .Basededatosaltafw			lxAgrpltdsBdmodifw =  .Basededatosmodificacionfw			lxAgrpltdsNombre =  .Nombre			lxAgrpltdsDescrip =  .Descripcion			lxAgrpltdsFiltrafec =  .Filtrafecha			lxAgrpltdsObs =  .Observacion			lxAgrpltdsCategoria =  .Categoria			lxAgrpltdsFavorito =  .Favorito			lxAgrpltdsCodigo =  .Codigo
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxAgrpltdsNombre = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ORGANIZACION.AGRPLTDS ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Ualtafw","Hmodifw","Smodifw","Saltafw","Umodifw","Zadsfw","Valtafw","Vmodifw","Horaimpo","Horaexpo","Haltafw","Esttrans","Bdaltafw","Bdmodifw","Nombre","Descrip","Filtrafec","Obs","Categoria","Favorito","Codigo" ) values ( <<"'" + this.ConvertirDateSql( lxAgrpltdsFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAgrpltdsFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAgrpltdsFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAgrpltdsFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAgrpltdsFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsNombre ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsDescrip ) + "'" >>, <<iif( lxAgrpltdsFiltrafec, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsObs ) + "'" >>, <<lxAgrpltdsCategoria >>, <<iif( lxAgrpltdsFavorito, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsCodigo ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NOMBRE
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Referencias
				if this.oEntidad.Referencias.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxEsdefault = loItem.Esdefault
					lxIdlistado = loItem.Idlistado
					lxNombredelaccesodirecto = loItem.Nombredelaccesodirecto
					lxPersonalizacion_PK = loItem.Personalizacion_PK
					lxOrdenvisual = loItem.Ordenvisual
					lxAccesodirecto = loItem.Accesodirecto
					lxNombrelistado = loItem.Nombrelistado
					lxNombrepersonalizacion = loItem.Nombrepersonalizacion
					lxAtributofecha = loItem.Atributofecha
					lxActivado = loItem.Activado
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.AgrpLtdsDet("NROITEM","EsDefault","IDListado","NomADirect","IDPerso","Nombre","Orden","AccDirecto","NomListado","NomPerso","AtrFecha","Activado" ) values ( <<lxNroitem>>, <<iif( lxEsdefault, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIdlistado ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombredelaccesodirecto ) + "'">>, <<"'" + this.FormatearTextoSql( lxPersonalizacion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxOrdenvisual>>, <<"'" + this.FormatearTextoSql( lxAccesodirecto ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombrelistado ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombrepersonalizacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributofecha ) + "'">>, <<iif( lxActivado, 1, 0 )>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
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
		return this.oEntidad.NOMBRE
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxAgrpltdsFecexpo, lxAgrpltdsFectrans, lxAgrpltdsFmodifw, lxAgrpltdsFaltafw, lxAgrpltdsFecimpo, lxAgrpltdsUaltafw, lxAgrpltdsHmodifw, lxAgrpltdsSmodifw, lxAgrpltdsSaltafw, lxAgrpltdsUmodifw, lxAgrpltdsZadsfw, lxAgrpltdsValtafw, lxAgrpltdsVmodifw, lxAgrpltdsHoraimpo, lxAgrpltdsHoraexpo, lxAgrpltdsHaltafw, lxAgrpltdsEsttrans, lxAgrpltdsBdaltafw, lxAgrpltdsBdmodifw, lxAgrpltdsNombre, lxAgrpltdsDescrip, lxAgrpltdsFiltrafec, lxAgrpltdsObs, lxAgrpltdsCategoria, lxAgrpltdsFavorito, lxAgrpltdsCodigo
				lxAgrpltdsFecexpo =  .Fechaexpo			lxAgrpltdsFectrans =  .Fechatransferencia			lxAgrpltdsFmodifw =  .Fechamodificacionfw			lxAgrpltdsFaltafw =  .Fechaaltafw			lxAgrpltdsFecimpo =  .Fechaimpo			lxAgrpltdsUaltafw =  .Usuarioaltafw			lxAgrpltdsHmodifw =  .Horamodificacionfw			lxAgrpltdsSmodifw =  .Seriemodificacionfw			lxAgrpltdsSaltafw =  .Seriealtafw			lxAgrpltdsUmodifw =  .Usuariomodificacionfw			lxAgrpltdsZadsfw =  .Zadsfw			lxAgrpltdsValtafw =  .Versionaltafw			lxAgrpltdsVmodifw =  .Versionmodificacionfw			lxAgrpltdsHoraimpo =  .Horaimpo			lxAgrpltdsHoraexpo =  .Horaexpo			lxAgrpltdsHaltafw =  .Horaaltafw			lxAgrpltdsEsttrans =  .Estadotransferencia			lxAgrpltdsBdaltafw =  .Basededatosaltafw			lxAgrpltdsBdmodifw =  .Basededatosmodificacionfw			lxAgrpltdsNombre =  .Nombre			lxAgrpltdsDescrip =  .Descripcion			lxAgrpltdsFiltrafec =  .Filtrafecha			lxAgrpltdsObs =  .Observacion			lxAgrpltdsCategoria =  .Categoria			lxAgrpltdsFavorito =  .Favorito			lxAgrpltdsCodigo =  .Codigo
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.NOMBRE
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ORGANIZACION.AGRPLTDS set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAgrpltdsFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxAgrpltdsFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxAgrpltdsFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxAgrpltdsFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxAgrpltdsFecimpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsSaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsUmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsVmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxAgrpltdsHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxAgrpltdsHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsHaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxAgrpltdsEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsBdmodifw ) + "'">>,"Nombre" = <<"'" + this.FormatearTextoSql( lxAgrpltdsNombre ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxAgrpltdsDescrip ) + "'">>,"Filtrafec" = <<iif( lxAgrpltdsFiltrafec, 1, 0 )>>,"Obs" = <<"'" + this.FormatearTextoSql( lxAgrpltdsObs ) + "'">>,"Categoria" = <<lxAgrpltdsCategoria>>,"Favorito" = <<iif( lxAgrpltdsFavorito, 1, 0 )>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxAgrpltdsCodigo ) + "'">> where "Nombre" = <<"'" + this.FormatearTextoSql( lxAgrpltdsNombre ) + "'">> and  AGRPLTDS.NOMBRE != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.AgrpLtdsDet where "Nombre" = ' + "'" + this.FormatearTextoSql( .oEntidad.NOMBRE ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Referencias
				if this.oEntidad.Referencias.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxEsdefault = loItem.Esdefault
					lxIdlistado = loItem.Idlistado
					lxNombredelaccesodirecto = loItem.Nombredelaccesodirecto
					lxPersonalizacion_PK = loItem.Personalizacion_PK
					lxOrdenvisual = loItem.Ordenvisual
					lxAccesodirecto = loItem.Accesodirecto
					lxNombrelistado = loItem.Nombrelistado
					lxNombrepersonalizacion = loItem.Nombrepersonalizacion
					lxAtributofecha = loItem.Atributofecha
					lxActivado = loItem.Activado
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.AgrpLtdsDet("NROITEM","EsDefault","IDListado","NomADirect","IDPerso","Nombre","Orden","AccDirecto","NomListado","NomPerso","AtrFecha","Activado" ) values ( <<lxNroitem>>, <<iif( lxEsdefault, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIdlistado ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombredelaccesodirecto ) + "'">>, <<"'" + this.FormatearTextoSql( lxPersonalizacion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxOrdenvisual>>, <<"'" + this.FormatearTextoSql( lxAccesodirecto ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombrelistado ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombrepersonalizacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributofecha ) + "'">>, <<iif( lxActivado, 1, 0 )>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Nombre from ORGANIZACION.AGRPLTDS where " + this.ConvertirFuncionesSql( " AGRPLTDS.NOMBRE != ''" ) )
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
			Local lxAgrpltdsNombre
			lxAgrpltdsNombre = .Nombre

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Nombre" as "Nombre", "Descrip" as "Descripcion", "Filtrafec" as "Filtrafecha", "Obs" as "Observacion", "Categoria" as "Categoria", "Favorito" as "Favorito", "Codigo" as "Codigo" from ORGANIZACION.AGRPLTDS where "Nombre" = <<"'" + this.FormatearTextoSql( lxAgrpltdsNombre ) + "'">> and  AGRPLTDS.NOMBRE != ''
			endtext
			use in select('c_AGRUPALISTADOSPERSONALIZADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AGRUPALISTADOSPERSONALIZADOS', set( 'Datasession' ) )

			if reccount( 'c_AGRUPALISTADOSPERSONALIZADOS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Esdefault" as "Esdefault", "Idlistado" as "Idlistado", "Nomadirect" as "Nombredelaccesodirecto", "Idperso" as "Personalizacion", "Nombre" as "Nombre", "Orden" as "Ordenvisual", "Accdirecto" as "Accesodirecto", "Nomlistado" as "Nombrelistado", "Nomperso" as "Nombrepersonalizacion", "Atrfecha" as "Atributofecha", "Activado" as "Activado" from ORGANIZACION.AgrpLtdsDet where Nombre = <<"'" + this.FormatearTextoSql( c_AGRUPALISTADOSPERSONALIZADOS.NOMBRE ) + "'">> Order by OrdenVisual
			endtext
			use in select('c_Referencias')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Referencias', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Referencias
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxAgrpLtdsCodigo As Variant
			lxAgrpLtdsCodigo = .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Nombre" as "Nombre", "Descrip" as "Descripcion", "Filtrafec" as "Filtrafecha", "Obs" as "Observacion", "Categoria" as "Categoria", "Favorito" as "Favorito", "Codigo" as "Codigo" from ORGANIZACION.AGRPLTDS where  AGRPLTDS.NOMBRE != '' And Codigo = <<"'" + this.FormatearTextoSql( lxAgrpLtdsCodigo ) + "'">>
			endtext
			use in select('c_AGRUPALISTADOSPERSONALIZADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AGRUPALISTADOSPERSONALIZADOS', set( 'Datasession' ) )
			if reccount( 'c_AGRUPALISTADOSPERSONALIZADOS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Esdefault" as "Esdefault", "Idlistado" as "Idlistado", "Nomadirect" as "Nombredelaccesodirecto", "Idperso" as "Personalizacion", "Nombre" as "Nombre", "Orden" as "Ordenvisual", "Accdirecto" as "Accesodirecto", "Nomlistado" as "Nombrelistado", "Nomperso" as "Nombrepersonalizacion", "Atrfecha" as "Atributofecha", "Activado" as "Activado" from ORGANIZACION.AgrpLtdsDet where Nombre = <<"'" + this.FormatearTextoSql( c_AGRUPALISTADOSPERSONALIZADOS.NOMBRE ) + "'">> Order by OrdenVisual
			endtext
			use in select('c_Referencias')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Referencias', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Referencias
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxAgrpltdsNombre as Variant
		llRetorno = .t.
		lxAgrpltdsNombre = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ORGANIZACION.AGRPLTDS where "Nombre" = <<"'" + this.FormatearTextoSql( lxAgrpltdsNombre ) + "'">> and  AGRPLTDS.NOMBRE != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Nombre" as "Nombre", "Descrip" as "Descripcion", "Filtrafec" as "Filtrafecha", "Obs" as "Observacion", "Categoria" as "Categoria", "Favorito" as "Favorito", "Codigo" as "Codigo" from ORGANIZACION.AGRPLTDS where  AGRPLTDS.NOMBRE != '' order by Codigo
			endtext
			use in select('c_AGRUPALISTADOSPERSONALIZADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AGRUPALISTADOSPERSONALIZADOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Esdefault" as "Esdefault", "Idlistado" as "Idlistado", "Nomadirect" as "Nombredelaccesodirecto", "Idperso" as "Personalizacion", "Nombre" as "Nombre", "Orden" as "Ordenvisual", "Accdirecto" as "Accesodirecto", "Nomlistado" as "Nombrelistado", "Nomperso" as "Nombrepersonalizacion", "Atrfecha" as "Atributofecha", "Activado" as "Activado" from ORGANIZACION.AgrpLtdsDet where Nombre = <<"'" + this.FormatearTextoSql( c_AGRUPALISTADOSPERSONALIZADOS.NOMBRE ) + "'">> Order by OrdenVisual
			endtext
			use in select('c_Referencias')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Referencias', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Referencias
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Nombre" as "Nombre", "Descrip" as "Descripcion", "Filtrafec" as "Filtrafecha", "Obs" as "Observacion", "Categoria" as "Categoria", "Favorito" as "Favorito", "Codigo" as "Codigo" from ORGANIZACION.AGRPLTDS where  funciones.padr( Codigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  AGRPLTDS.NOMBRE != '' order by Codigo
			endtext
			use in select('c_AGRUPALISTADOSPERSONALIZADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AGRUPALISTADOSPERSONALIZADOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Esdefault" as "Esdefault", "Idlistado" as "Idlistado", "Nomadirect" as "Nombredelaccesodirecto", "Idperso" as "Personalizacion", "Nombre" as "Nombre", "Orden" as "Ordenvisual", "Accdirecto" as "Accesodirecto", "Nomlistado" as "Nombrelistado", "Nomperso" as "Nombrepersonalizacion", "Atrfecha" as "Atributofecha", "Activado" as "Activado" from ORGANIZACION.AgrpLtdsDet where Nombre = <<"'" + this.FormatearTextoSql( c_AGRUPALISTADOSPERSONALIZADOS.NOMBRE ) + "'">> Order by OrdenVisual
			endtext
			use in select('c_Referencias')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Referencias', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Referencias
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Nombre" as "Nombre", "Descrip" as "Descripcion", "Filtrafec" as "Filtrafecha", "Obs" as "Observacion", "Categoria" as "Categoria", "Favorito" as "Favorito", "Codigo" as "Codigo" from ORGANIZACION.AGRPLTDS where  funciones.padr( Codigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  AGRPLTDS.NOMBRE != '' order by Codigo desc
			endtext
			use in select('c_AGRUPALISTADOSPERSONALIZADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AGRUPALISTADOSPERSONALIZADOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Esdefault" as "Esdefault", "Idlistado" as "Idlistado", "Nomadirect" as "Nombredelaccesodirecto", "Idperso" as "Personalizacion", "Nombre" as "Nombre", "Orden" as "Ordenvisual", "Accdirecto" as "Accesodirecto", "Nomlistado" as "Nombrelistado", "Nomperso" as "Nombrepersonalizacion", "Atrfecha" as "Atributofecha", "Activado" as "Activado" from ORGANIZACION.AgrpLtdsDet where Nombre = <<"'" + this.FormatearTextoSql( c_AGRUPALISTADOSPERSONALIZADOS.NOMBRE ) + "'">> Order by OrdenVisual
			endtext
			use in select('c_Referencias')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Referencias', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Referencias
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Nombre" as "Nombre", "Descrip" as "Descripcion", "Filtrafec" as "Filtrafecha", "Obs" as "Observacion", "Categoria" as "Categoria", "Favorito" as "Favorito", "Codigo" as "Codigo" from ORGANIZACION.AGRPLTDS where  AGRPLTDS.NOMBRE != '' order by Codigo desc
			endtext
			use in select('c_AGRUPALISTADOSPERSONALIZADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AGRUPALISTADOSPERSONALIZADOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Esdefault" as "Esdefault", "Idlistado" as "Idlistado", "Nomadirect" as "Nombredelaccesodirecto", "Idperso" as "Personalizacion", "Nombre" as "Nombre", "Orden" as "Ordenvisual", "Accdirecto" as "Accesodirecto", "Nomlistado" as "Nombrelistado", "Nomperso" as "Nombrepersonalizacion", "Atrfecha" as "Atributofecha", "Activado" as "Activado" from ORGANIZACION.AgrpLtdsDet where Nombre = <<"'" + this.FormatearTextoSql( c_AGRUPALISTADOSPERSONALIZADOS.NOMBRE ) + "'">> Order by OrdenVisual
			endtext
			use in select('c_Referencias')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Referencias', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Referencias
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + "'" + this.FormatearTextoSql( .oEntidad.NOMBRE ) + "'"
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Ualtafw,Hmodifw,Smodifw,Saltafw,Umodifw,Zadsfw,Valt" + ;
"afw,Vmodifw,Horaimpo,Horaexpo,Haltafw,Esttrans,Bdaltafw,Bdmodifw,Nombre,Descrip,Filtrafec,Obs,Catego" + ;
"ria,Favorito,Codigo" + ;
" from ORGANIZACION.AGRPLTDS where  AGRPLTDS.NOMBRE != '' and " + lcFiltro )
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
			local  lxAgrpltdsFecexpo, lxAgrpltdsFectrans, lxAgrpltdsFmodifw, lxAgrpltdsFaltafw, lxAgrpltdsFecimpo, lxAgrpltdsUaltafw, lxAgrpltdsHmodifw, lxAgrpltdsSmodifw, lxAgrpltdsSaltafw, lxAgrpltdsUmodifw, lxAgrpltdsZadsfw, lxAgrpltdsValtafw, lxAgrpltdsVmodifw, lxAgrpltdsHoraimpo, lxAgrpltdsHoraexpo, lxAgrpltdsHaltafw, lxAgrpltdsEsttrans, lxAgrpltdsBdaltafw, lxAgrpltdsBdmodifw, lxAgrpltdsNombre, lxAgrpltdsDescrip, lxAgrpltdsFiltrafec, lxAgrpltdsObs, lxAgrpltdsCategoria, lxAgrpltdsFavorito, lxAgrpltdsCodigo
				lxAgrpltdsFecexpo = ctod( '  /  /    ' )			lxAgrpltdsFectrans = ctod( '  /  /    ' )			lxAgrpltdsFmodifw = ctod( '  /  /    ' )			lxAgrpltdsFaltafw = ctod( '  /  /    ' )			lxAgrpltdsFecimpo = ctod( '  /  /    ' )			lxAgrpltdsUaltafw = []			lxAgrpltdsHmodifw = []			lxAgrpltdsSmodifw = []			lxAgrpltdsSaltafw = []			lxAgrpltdsUmodifw = []			lxAgrpltdsZadsfw = []			lxAgrpltdsValtafw = []			lxAgrpltdsVmodifw = []			lxAgrpltdsHoraimpo = []			lxAgrpltdsHoraexpo = []			lxAgrpltdsHaltafw = []			lxAgrpltdsEsttrans = []			lxAgrpltdsBdaltafw = []			lxAgrpltdsBdmodifw = []			lxAgrpltdsNombre = []			lxAgrpltdsDescrip = []			lxAgrpltdsFiltrafec = .F.			lxAgrpltdsObs = []			lxAgrpltdsCategoria = 0			lxAgrpltdsFavorito = .F.			lxAgrpltdsCodigo = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.AgrpLtdsDet where "Nombre" = ' + "'" + this.FormatearTextoSql( .oEntidad.NOMBRE ) + "'" )
			this.oConexion.EjecutarSql( [delete from ORGANIZACION.AGRPLTDS where "Nombre" = ] + "'" + this.FormatearTextoSql( .oEntidad.NOMBRE ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'AGRPLTDS' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where Nombre = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(Nombre, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AGRPLTDS.NOMBRE != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Nombre" as "Nombre", "Descrip" as "Descripcion", "Filtrafec" as "Filtrafecha", "Obs" as "Observacion", "Categoria" as "Categoria", "Favorito" as "Favorito", "Codigo" as "Codigo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AGRPLTDS', '', tnTope )
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
	Function ObtenerDatosDetalleReferencias( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AGRPLTDSDET.NOMBRE != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Esdefault" as "Esdefault", "Idlistado" as "Idlistado", "Nomadirect" as "Nombredelaccesodirecto", "Idperso" as "Personalizacion", "Nombre" as "Nombre", "Orden" as "Ordenvisual", "Accdirecto" as "Accesodirecto", "Nomlistado" as "Nombrelistado", "Nomperso" as "Nombrepersonalizacion", "Atrfecha" as "Atributofecha", "Activado" as "Activado"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleReferencias( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgrpLtdsDet', 'Referencias', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleReferencias( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleReferencias( lcAtributo )
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
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
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
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMBRE AS NOMBRE'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'FILTRAFECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FILTRAFEC AS FILTRAFECHA'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'CATEGORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATEGORIA AS CATEGORIA'
				Case lcAtributo == 'FAVORITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAVORITO AS FAVORITO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleReferencias( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'ESDEFAULT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESDEFAULT AS ESDEFAULT'
				Case lcAtributo == 'IDLISTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDLISTADO AS IDLISTADO'
				Case lcAtributo == 'NOMBREDELACCESODIRECTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMADIRECT AS NOMBREDELACCESODIRECTO'
				Case lcAtributo == 'PERSONALIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDPERSO AS PERSONALIZACION'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMBRE AS NOMBRE'
				Case lcAtributo == 'ORDENVISUAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORDEN AS ORDENVISUAL'
				Case lcAtributo == 'ACCESODIRECTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACCDIRECTO AS ACCESODIRECTO'
				Case lcAtributo == 'NOMBRELISTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMLISTADO AS NOMBRELISTADO'
				Case lcAtributo == 'NOMBREPERSONALIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMPERSO AS NOMBREPERSONALIZACION'
				Case lcAtributo == 'ATRIBUTOFECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ATRFECHA AS ATRIBUTOFECHA'
				Case lcAtributo == 'ACTIVADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACTIVADO AS ACTIVADO'
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
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'NOMBRE'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'FILTRAFECHA'
				lcCampo = 'FILTRAFEC'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'CATEGORIA'
				lcCampo = 'CATEGORIA'
			Case upper( alltrim( tcAtributo ) ) == 'FAVORITO'
				lcCampo = 'FAVORITO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleReferencias( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'ESDEFAULT'
				lcCampo = 'ESDEFAULT'
			Case upper( alltrim( tcAtributo ) ) == 'IDLISTADO'
				lcCampo = 'IDLISTADO'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBREDELACCESODIRECTO'
				lcCampo = 'NOMADIRECT'
			Case upper( alltrim( tcAtributo ) ) == 'PERSONALIZACION'
				lcCampo = 'IDPERSO'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'NOMBRE'
			Case upper( alltrim( tcAtributo ) ) == 'ORDENVISUAL'
				lcCampo = 'ORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'ACCESODIRECTO'
				lcCampo = 'ACCDIRECTO'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRELISTADO'
				lcCampo = 'NOMLISTADO'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBREPERSONALIZACION'
				lcCampo = 'NOMPERSO'
			Case upper( alltrim( tcAtributo ) ) == 'ATRIBUTOFECHA'
				lcCampo = 'ATRFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'ACTIVADO'
				lcCampo = 'ACTIVADO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'REFERENCIAS'
			lcRetorno = 'AGRPLTDSDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxAgrpltdsFecexpo, lxAgrpltdsFectrans, lxAgrpltdsFmodifw, lxAgrpltdsFaltafw, lxAgrpltdsFecimpo, lxAgrpltdsUaltafw, lxAgrpltdsHmodifw, lxAgrpltdsSmodifw, lxAgrpltdsSaltafw, lxAgrpltdsUmodifw, lxAgrpltdsZadsfw, lxAgrpltdsValtafw, lxAgrpltdsVmodifw, lxAgrpltdsHoraimpo, lxAgrpltdsHoraexpo, lxAgrpltdsHaltafw, lxAgrpltdsEsttrans, lxAgrpltdsBdaltafw, lxAgrpltdsBdmodifw, lxAgrpltdsNombre, lxAgrpltdsDescrip, lxAgrpltdsFiltrafec, lxAgrpltdsObs, lxAgrpltdsCategoria, lxAgrpltdsFavorito, lxAgrpltdsCodigo
				lxAgrpltdsFecexpo =  .Fechaexpo			lxAgrpltdsFectrans =  .Fechatransferencia			lxAgrpltdsFmodifw =  .Fechamodificacionfw			lxAgrpltdsFaltafw =  .Fechaaltafw			lxAgrpltdsFecimpo =  .Fechaimpo			lxAgrpltdsUaltafw =  .Usuarioaltafw			lxAgrpltdsHmodifw =  .Horamodificacionfw			lxAgrpltdsSmodifw =  .Seriemodificacionfw			lxAgrpltdsSaltafw =  .Seriealtafw			lxAgrpltdsUmodifw =  .Usuariomodificacionfw			lxAgrpltdsZadsfw =  .Zadsfw			lxAgrpltdsValtafw =  .Versionaltafw			lxAgrpltdsVmodifw =  .Versionmodificacionfw			lxAgrpltdsHoraimpo =  .Horaimpo			lxAgrpltdsHoraexpo =  .Horaexpo			lxAgrpltdsHaltafw =  .Horaaltafw			lxAgrpltdsEsttrans =  .Estadotransferencia			lxAgrpltdsBdaltafw =  .Basededatosaltafw			lxAgrpltdsBdmodifw =  .Basededatosmodificacionfw			lxAgrpltdsNombre =  .Nombre			lxAgrpltdsDescrip =  .Descripcion			lxAgrpltdsFiltrafec =  .Filtrafecha			lxAgrpltdsObs =  .Observacion			lxAgrpltdsCategoria =  .Categoria			lxAgrpltdsFavorito =  .Favorito			lxAgrpltdsCodigo =  .Codigo
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ORGANIZACION.AGRPLTDS ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Ualtafw","Hmodifw","Smodifw","Saltafw","Umodifw","Zadsfw","Valtafw","Vmodifw","Horaimpo","Horaexpo","Haltafw","Esttrans","Bdaltafw","Bdmodifw","Nombre","Descrip","Filtrafec","Obs","Categoria","Favorito","Codigo" ) values ( <<"'" + this.ConvertirDateSql( lxAgrpltdsFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAgrpltdsFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAgrpltdsFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAgrpltdsFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAgrpltdsFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsNombre ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsDescrip ) + "'" >>, <<iif( lxAgrpltdsFiltrafec, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsObs ) + "'" >>, <<lxAgrpltdsCategoria >>, <<iif( lxAgrpltdsFavorito, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAgrpltdsCodigo ) + "'" >> )
		endtext
		loColeccion.cTabla = 'AGRPLTDS' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.NOMBRE + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Referencias
				if this.oEntidad.Referencias.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxEsdefault = loItem.Esdefault
					lxIdlistado = loItem.Idlistado
					lxNombredelaccesodirecto = loItem.Nombredelaccesodirecto
					lxPersonalizacion_PK = loItem.Personalizacion_PK
					lxOrdenvisual = loItem.Ordenvisual
					lxAccesodirecto = loItem.Accesodirecto
					lxNombrelistado = loItem.Nombrelistado
					lxNombrepersonalizacion = loItem.Nombrepersonalizacion
					lxAtributofecha = loItem.Atributofecha
					lxActivado = loItem.Activado
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.AgrpLtdsDet("NROITEM","EsDefault","IDListado","NomADirect","IDPerso","Nombre","Orden","AccDirecto","NomListado","NomPerso","AtrFecha","Activado" ) values ( <<lxNroitem>>, <<iif( lxEsdefault, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIdlistado ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombredelaccesodirecto ) + "'">>, <<"'" + this.FormatearTextoSql( lxPersonalizacion_PK ) + "'">>, << lcValorClavePrimariaString >>, <<lxOrdenvisual>>, <<"'" + this.FormatearTextoSql( lxAccesodirecto ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombrelistado ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombrepersonalizacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributofecha ) + "'">>, <<iif( lxActivado, 1, 0 )>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxAgrpltdsFecexpo, lxAgrpltdsFectrans, lxAgrpltdsFmodifw, lxAgrpltdsFaltafw, lxAgrpltdsFecimpo, lxAgrpltdsUaltafw, lxAgrpltdsHmodifw, lxAgrpltdsSmodifw, lxAgrpltdsSaltafw, lxAgrpltdsUmodifw, lxAgrpltdsZadsfw, lxAgrpltdsValtafw, lxAgrpltdsVmodifw, lxAgrpltdsHoraimpo, lxAgrpltdsHoraexpo, lxAgrpltdsHaltafw, lxAgrpltdsEsttrans, lxAgrpltdsBdaltafw, lxAgrpltdsBdmodifw, lxAgrpltdsNombre, lxAgrpltdsDescrip, lxAgrpltdsFiltrafec, lxAgrpltdsObs, lxAgrpltdsCategoria, lxAgrpltdsFavorito, lxAgrpltdsCodigo
				lxAgrpltdsFecexpo =  .Fechaexpo			lxAgrpltdsFectrans =  .Fechatransferencia			lxAgrpltdsFmodifw =  .Fechamodificacionfw			lxAgrpltdsFaltafw =  .Fechaaltafw			lxAgrpltdsFecimpo =  .Fechaimpo			lxAgrpltdsUaltafw =  .Usuarioaltafw			lxAgrpltdsHmodifw =  .Horamodificacionfw			lxAgrpltdsSmodifw =  .Seriemodificacionfw			lxAgrpltdsSaltafw =  .Seriealtafw			lxAgrpltdsUmodifw =  .Usuariomodificacionfw			lxAgrpltdsZadsfw =  .Zadsfw			lxAgrpltdsValtafw =  .Versionaltafw			lxAgrpltdsVmodifw =  .Versionmodificacionfw			lxAgrpltdsHoraimpo =  .Horaimpo			lxAgrpltdsHoraexpo =  .Horaexpo			lxAgrpltdsHaltafw =  .Horaaltafw			lxAgrpltdsEsttrans =  .Estadotransferencia			lxAgrpltdsBdaltafw =  .Basededatosaltafw			lxAgrpltdsBdmodifw =  .Basededatosmodificacionfw			lxAgrpltdsNombre =  .Nombre			lxAgrpltdsDescrip =  .Descripcion			lxAgrpltdsFiltrafec =  .Filtrafecha			lxAgrpltdsObs =  .Observacion			lxAgrpltdsCategoria =  .Categoria			lxAgrpltdsFavorito =  .Favorito			lxAgrpltdsCodigo =  .Codigo
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NOMBRE
			lcValorClavePrimariaString = "'" + this.oEntidad.NOMBRE + "'"

			lcFiltro = ["Nombre" = ] + lcValorClavePrimariaString  + [ and  AGRPLTDS.NOMBRE != '']
			text to lcSentencia noshow textmerge
				update ORGANIZACION.AGRPLTDS set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAgrpltdsFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxAgrpltdsFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAgrpltdsFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxAgrpltdsFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAgrpltdsFecimpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsSaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsUmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsVmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxAgrpltdsHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxAgrpltdsHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsHaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxAgrpltdsEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAgrpltdsBdmodifw ) + "'">>, "Nombre" = <<"'" + this.FormatearTextoSql( lxAgrpltdsNombre ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxAgrpltdsDescrip ) + "'">>, "Filtrafec" = <<iif( lxAgrpltdsFiltrafec, 1, 0 )>>, "Obs" = <<"'" + this.FormatearTextoSql( lxAgrpltdsObs ) + "'">>, "Categoria" = <<lxAgrpltdsCategoria>>, "Favorito" = <<iif( lxAgrpltdsFavorito, 1, 0 )>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxAgrpltdsCodigo ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'AGRPLTDS' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ORGANIZACION.AgrpLtdsDet where "Nombre" = ] + "'" + this.FormatearTextoSql( .oEntidad.NOMBRE ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Referencias
				if this.oEntidad.Referencias.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxEsdefault = loItem.Esdefault
					lxIdlistado = loItem.Idlistado
					lxNombredelaccesodirecto = loItem.Nombredelaccesodirecto
					lxPersonalizacion_PK = loItem.Personalizacion_PK
					lxOrdenvisual = loItem.Ordenvisual
					lxAccesodirecto = loItem.Accesodirecto
					lxNombrelistado = loItem.Nombrelistado
					lxNombrepersonalizacion = loItem.Nombrepersonalizacion
					lxAtributofecha = loItem.Atributofecha
					lxActivado = loItem.Activado
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.AgrpLtdsDet("NROITEM","EsDefault","IDListado","NomADirect","IDPerso","Nombre","Orden","AccDirecto","NomListado","NomPerso","AtrFecha","Activado" ) values ( <<lxNroitem>>, <<iif( lxEsdefault, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIdlistado ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombredelaccesodirecto ) + "'">>, <<"'" + this.FormatearTextoSql( lxPersonalizacion_PK ) + "'">>, << lcValorClavePrimariaString >>, <<lxOrdenvisual>>, <<"'" + this.FormatearTextoSql( lxAccesodirecto ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombrelistado ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombrepersonalizacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributofecha ) + "'">>, <<iif( lxActivado, 1, 0 )>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
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
			lxValorClavePrimaria = this.oEntidad.NOMBRE
			lcValorClavePrimariaString = "'" + this.oEntidad.NOMBRE + "'"

			lcFiltro = ["Nombre" = ] + lcValorClavePrimariaString  + [ and  AGRPLTDS.NOMBRE != '']
		loColeccion.Agregar( 'delete from ORGANIZACION.AGRPLTDS where ' + lcFiltro )
			loColeccion.Agregar([delete from ORGANIZACION.AgrpLtdsDet where "Nombre" = ] + "'" + this.FormatearTextoSql( .oEntidad.NOMBRE ) + "'")
			loColeccion.cTabla = 'AGRPLTDS' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ORGANIZACION.AGRPLTDS where  AGRPLTDS.NOMBRE != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ORGANIZACION.AGRPLTDS where Nombre = " + "'" + this.FormatearTextoSql( this.oEntidad.NOMBRE ) + "'"+ " and  AGRPLTDS.NOMBRE != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxAgrpLtdsCodigo as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'AGRUPALISTADOSPERSONALIZADOS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ORGANIZACION.AGRPLTDS Where  Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo     ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..Nombre
				if lxValorClavePK == curSeek.Nombre or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.Nombre and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.Nombre
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ORGANIZACION.AGRPLTDS set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Nombre = ] + "'" + this.FormatearTextoSql( &lcCursor..Nombre ) + "'"+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, FiltraFec = ] + Transform( iif( &lcCursor..FiltraFec, 1, 0 ))+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, Categoria = ] + transform( &lcCursor..Categoria )+ [, Favorito = ] + Transform( iif( &lcCursor..Favorito, 1, 0 ))+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + [ Where Nombre = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ORGANIZACION.AGRPLTDS Where Nombre = ] + "'" + this.FormatearTextoSql( &lcCursor..Nombre ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FECTRANS, FMODIFW, FALTAFW, FECIMPO, UALTAFW, HMODIFW, SMODIFW, SALTAFW, UMODIFW, ZADSFW, VALTAFW, VMODIFW, HORAIMPO, HORAEXPO, HALTAFW, ESTTRANS, BDALTAFW, BDMODIFW, Nombre, Descrip, FiltraFec, Obs, Categoria, Favorito, Codigo
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Nombre ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..FiltraFec, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + transform( &lcCursor..Categoria ) + ',' + Transform( iif( &lcCursor..Favorito, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ORGANIZACION.AGRPLTDS ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'AGRUPALISTADOSPERSONALIZADOS'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'Nombre','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','Nombre')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ORGANIZACION.AgrpLtdsDet Where Nombre] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMREFERENCIAALISTADO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Nombre in ( select Nombre from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","EsDefault","IDListado","NomADirect","IDPerso","Nombre","Orden","AccDirecto","NomListado","NomPerso","AtrFecha","Activado"
		endText
		this.oConexion.EjecutarSql( [Insert into ORGANIZACION.AgrpLtdsDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.EsDefault , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IDListado  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NomADirect ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IDPerso    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Nombre     ) + "'" + ',' + transform( cDetallesExistentes.Orden      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AccDirecto ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NomListado ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NomPerso   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AtrFecha   ) + "'" + ',' + Transform( iif( cDetallesExistentes.Activado  , 1, 0 )) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Nombre C (50) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número interno: ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'AGRUPALISTADOSPERSONALIZADOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'AGRUPALISTADOSPERSONALIZADOS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'AGRUPALISTADOSPERSONALIZADOS_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMREFERENCIAALISTADO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ORGANIZACION.TablaTrabajo_AgrpLtds')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'AGRUPALISTADOSPERSONALIZADOS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Nombre
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Codigo )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad AGRUPALISTADOSPERSONALIZADOS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'AGRUPALISTADOSPERSONALIZADOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Nombre as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Nombre, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'AGRUPALISTADOSPERSONALIZADOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_AgrpLtds') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_AgrpLtds
Create Table ORGANIZACION.TablaTrabajo_AgrpLtds ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"nombre" char( 50 )  null, 
"descrip" char( 250 )  null, 
"filtrafec" bit  null, 
"obs" varchar(max)  null, 
"categoria" numeric( 2, 0 )  null, 
"favorito" bit  null, 
"codigo" char( 38 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_AgrpLtds' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_AgrpLtds' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'AGRUPALISTADOSPERSONALIZADOS'
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
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('nombre','nombre')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('filtrafec','filtrafec')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('categoria','categoria')
			.AgregarMapeo('favorito','favorito')
			.AgregarMapeo('codigo','codigo')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ORGANIZACION.TablaTrabajo_AgrpLtds'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.NOMBRE = isnull( d.NOMBRE, t.NOMBRE ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.FILTRAFEC = isnull( d.FILTRAFEC, t.FILTRAFEC ),t.OBS = isnull( d.OBS, t.OBS ),t.CATEGORIA = isnull( d.CATEGORIA, t.CATEGORIA ),t.FAVORITO = isnull( d.FAVORITO, t.FAVORITO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO )
					from ORGANIZACION.AGRPLTDS t inner join deleted d 
							 on t.Nombre = d.Nombre
							 and  t.Codigo = d.Codigo
				-- Fin Updates
				insert into ORGANIZACION.AGRPLTDS(Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Ualtafw,Hmodifw,Smodifw,Saltafw,Umodifw,Zadsfw,Valtafw,Vmodifw,Horaimpo,Horaexpo,Haltafw,Esttrans,Bdaltafw,Bdmodifw,Nombre,Descrip,Filtrafec,Obs,Categoria,Favorito,Codigo)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.NOMBRE,''),isnull( d.DESCRIP,''),isnull( d.FILTRAFEC,0),isnull( d.OBS,''),isnull( d.CATEGORIA,0),isnull( d.FAVORITO,0),isnull( d.CODIGO,'')
						From deleted d left join ORGANIZACION.AGRPLTDS pk 
							 on d.Nombre = pk.Nombre
						 left join ORGANIZACION.AGRPLTDS cc 
							 on  d.Codigo = cc.Codigo
						Where pk.Nombre Is Null 
							 and cc.Codigo Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO INTERNO ' + cast( d.Codigo as Varchar(38) ) + '','La clave principal no es la esperada'
					from ORGANIZACION.AGRPLTDS t inner join deleted d 
							on   t.Codigo = d.Codigo
						left join deleted h 
							 on t.Nombre = h.Nombre
							 where h.Nombre is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO INTERNO ' + cast( d.Codigo as Varchar(38) ) + '','La clave principal a importar ya existe'
					from ORGANIZACION.AGRPLTDS t inner join deleted d 
							 on t.Nombre = d.Nombre
						left join deleted h 
							on   t.Codigo = h.Codigo
							where   h.Codigo is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgrpLtdsDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ORGANIZACION.DELETE_TablaTrabajo_AGRPLTDS_AgrpLtdsDet
ON ORGANIZACION.TablaTrabajo_AGRPLTDS_AgrpLtdsDet
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.ESDEFAULT = isnull( d.ESDEFAULT, t.ESDEFAULT ),
t.IDLISTADO = isnull( d.IDLISTADO, t.IDLISTADO ),
t.NOMADIRECT = isnull( d.NOMADIRECT, t.NOMADIRECT ),
t.IDPERSO = isnull( d.IDPERSO, t.IDPERSO ),
t.NOMBRE = isnull( d.NOMBRE, t.NOMBRE ),
t.ORDEN = isnull( d.ORDEN, t.ORDEN ),
t.ACCDIRECTO = isnull( d.ACCDIRECTO, t.ACCDIRECTO ),
t.NOMLISTADO = isnull( d.NOMLISTADO, t.NOMLISTADO ),
t.NOMPERSO = isnull( d.NOMPERSO, t.NOMPERSO ),
t.ATRFECHA = isnull( d.ATRFECHA, t.ATRFECHA ),
t.ACTIVADO = isnull( d.ACTIVADO, t.ACTIVADO )
from ORGANIZACION.AgrpLtdsDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ORGANIZACION.AgrpLtdsDet
( 
"NROITEM",
"ESDEFAULT",
"IDLISTADO",
"NOMADIRECT",
"IDPERSO",
"NOMBRE",
"ORDEN",
"ACCDIRECTO",
"NOMLISTADO",
"NOMPERSO",
"ATRFECHA",
"ACTIVADO"
 )
Select 
d.NROITEM,
d.ESDEFAULT,
d.IDLISTADO,
d.NOMADIRECT,
d.IDPERSO,
d.NOMBRE,
d.ORDEN,
d.ACCDIRECTO,
d.NOMLISTADO,
d.NOMPERSO,
d.ATRFECHA,
d.ACTIVADO
From deleted d left join ORGANIZACION.AgrpLtdsDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_AgrpLtds') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_AgrpLtds
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_AGRUPALISTADOSPERSONALIZADOS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_AGRUPALISTADOSPERSONALIZADOS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_AGRUPALISTADOSPERSONALIZADOS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_AGRUPALISTADOSPERSONALIZADOS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_AGRUPALISTADOSPERSONALIZADOS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_AGRUPALISTADOSPERSONALIZADOS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Usuarioaltafw = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Seriealtafw, [] )
					.Usuariomodificacionfw = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Versionmodificacionfw, [] )
					.Horaimpo = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Horaimpo, [] )
					.Horaexpo = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Horaexpo, [] )
					.Horaaltafw = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Horaaltafw, [] )
					.Estadotransferencia = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Basededatosmodificacionfw, [] )
					.Nombre = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Nombre, [] )
					.Descripcion = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Descripcion, [] )
					.Filtrafecha = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Filtrafecha, .F. )
					.Referencias.Limpiar()
					.Referencias.SetearEsNavegacion( .lProcesando )
					.Referencias.Cargar()
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Categoria = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Categoria, 0 )
					.Favorito = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Favorito, .F. )
					.Codigo = nvl( c_AGRUPALISTADOSPERSONALIZADOS.Codigo, [] )
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
			lxRetorno = c_AGRUPALISTADOSPERSONALIZADOS.NOMBRE
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.Referencias
		for lnIndex = loDetalle.count to 1 step -1
			if !loDetalle.ValidarExistenciaCamposFijosItemPlano( loDetalle.Item[lnIndex].NroItem )
				loDetalle.Remove( lnIndex )
			endif
		endfor
		
		lnContadorNroItem = 1
		for each loItem in loDetalle foxObject
			loItem.NroItem = lnContadorNroItem
			lnContadorNroItem = lnContadorNroItem + 1
		endfor

	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_AGRUPALISTADOSPERSONALIZADOS.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ORGANIZACION.AGRPLTDS' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Nombre"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,Nombre as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    Nombre from (
							select * 
								from ORGANIZACION.AGRPLTDS 
								Where   AGRPLTDS.NOMBRE != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "AGRPLTDS", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Nombre"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Nombre" as "Nombre", "Descrip" as "Descripcion", "Filtrafec" as "Filtrafecha", "Obs" as "Observacion", "Categoria" as "Categoria", "Favorito" as "Favorito", "Codigo" as "Codigo"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ORGANIZACION.AGRPLTDS 
								Where   AGRPLTDS.NOMBRE != ''
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
	Tabla = 'AGRPLTDS'
	Filtro = " AGRPLTDS.NOMBRE != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " AGRPLTDS.NOMBRE != ''"
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
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="FECHAEXPO                               " tabla="AGRPLTDS       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="FECHATRANSFERENCIA                      " tabla="AGRPLTDS       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="FECHAMODIFICACIONFW                     " tabla="AGRPLTDS       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="FECHAALTAFW                             " tabla="AGRPLTDS       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="FECHAIMPO                               " tabla="AGRPLTDS       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="USUARIOALTAFW                           " tabla="AGRPLTDS       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="HORAMODIFICACIONFW                      " tabla="AGRPLTDS       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="SERIEMODIFICACIONFW                     " tabla="AGRPLTDS       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="SERIEALTAFW                             " tabla="AGRPLTDS       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="USUARIOMODIFICACIONFW                   " tabla="AGRPLTDS       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="ZADSFW                                  " tabla="AGRPLTDS       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="VERSIONALTAFW                           " tabla="AGRPLTDS       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="VERSIONMODIFICACIONFW                   " tabla="AGRPLTDS       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="HORAIMPO                                " tabla="AGRPLTDS       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="HORAEXPO                                " tabla="AGRPLTDS       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="HORAALTAFW                              " tabla="AGRPLTDS       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="ESTADOTRANSFERENCIA                     " tabla="AGRPLTDS       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="BASEDEDATOSALTAFW                       " tabla="AGRPLTDS       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="AGRPLTDS       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="NOMBRE                                  " tabla="AGRPLTDS       " campo="NOMBRE    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="1" etiqueta="Nombre                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="DESCRIPCION                             " tabla="AGRPLTDS       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="FILTRAFECHA                             " tabla="AGRPLTDS       " campo="FILTRAFEC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Filtra por fecha                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="REFERENCIAS                             " tabla="AGRPLTDSDET    " campo="NOMBRE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="Referencias                                                                                                                                                     " dominio="DETALLEITEMREFERENCIAALISTADO " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="OBSERVACION                             " tabla="AGRPLTDS       " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="CATEGORIA                               " tabla="AGRPLTDS       " campo="CATEGORIA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Categoría                                                                                                                                                       " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="FAVORITO                                " tabla="AGRPLTDS       " campo="FAVORITO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="0" etiqueta="Favorito                                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPALISTADOSPERSONALIZADOS            " atributo="CODIGO                                  " tabla="AGRPLTDS       " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerGuidPk()                                                                                                                                                                                                                        " obligatorio="false" admitebusqueda="3" etiqueta="Número interno                                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="99" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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