
define class Din_EntidadDISENOTRANSFORMACIONLINCEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_DISENOTRANSFORMACIONLINCE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( Numero, 10, 0)]
	cExpresionCCPorCampos = [str( #tabla#.Numero, 10, 0)]
	cTagClaveCandidata = '_DTLCC'
	cTagClavePk = '_DTLPK'
	cTablaPrincipal = 'DISLINCE'
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
			local  lxDislinceFecexpo, lxDislinceFectrans, lxDislinceFecimpo, lxDislinceFaltafw, lxDislinceFmodifw, lxDislinceSaltafw, lxDislinceHmodifw, lxDislinceSmodifw, lxDislinceHoraimpo, lxDislinceUmodifw, lxDislinceZadsfw, lxDislinceValtafw, lxDislinceVmodifw, lxDislinceUaltafw, lxDislinceHoraexpo, lxDislinceBdmodifw, lxDislinceEsttrans, lxDislinceHaltafw, lxDislinceBdaltafw, lxDislinceTimestamp, lxDislinceBloqreg, lxDislinceCcod, lxDislinceNumero, lxDislinceCentidad, lxDislinceLhabilitad, lxDislinceLdefault, lxDislinceCobs
				lxDislinceFecexpo =  .Fechaexpo			lxDislinceFectrans =  .Fechatransferencia			lxDislinceFecimpo =  .Fechaimpo			lxDislinceFaltafw =  .Fechaaltafw			lxDislinceFmodifw =  .Fechamodificacionfw			lxDislinceSaltafw =  .Seriealtafw			lxDislinceHmodifw =  .Horamodificacionfw			lxDislinceSmodifw =  .Seriemodificacionfw			lxDislinceHoraimpo =  .Horaimpo			lxDislinceUmodifw =  .Usuariomodificacionfw			lxDislinceZadsfw =  .Zadsfw			lxDislinceValtafw =  .Versionaltafw			lxDislinceVmodifw =  .Versionmodificacionfw			lxDislinceUaltafw =  .Usuarioaltafw			lxDislinceHoraexpo =  .Horaexpo			lxDislinceBdmodifw =  .Basededatosmodificacionfw			lxDislinceEsttrans =  .Estadotransferencia			lxDislinceHaltafw =  .Horaaltafw			lxDislinceBdaltafw =  .Basededatosaltafw			lxDislinceTimestamp = goLibrerias.ObtenerTimestamp()			lxDislinceBloqreg =  .Bloquearregistro			lxDislinceCcod =  .Codigo			lxDislinceNumero =  .Numero			lxDislinceCentidad =  .Entidad			lxDislinceLhabilitad =  .Habilitado			lxDislinceLdefault =  .Defaultdiseno			lxDislinceCobs =  .Obs
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxDislinceCcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ORGANIZACION.DISLINCE ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Saltafw","Hmodifw","Smodifw","Horaimpo","Umodifw","Zadsfw","Valtafw","Vmodifw","Ualtafw","Horaexpo","Bdmodifw","Esttrans","Haltafw","Bdaltafw","Timestamp","Bloqreg","Ccod","Numero","Centidad","Lhabilitad","Ldefault","Cobs" ) values ( <<"'" + this.ConvertirDateSql( lxDislinceFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDislinceFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDislinceFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDislinceFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDislinceFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceBdaltafw ) + "'" >>, <<lxDislinceTimestamp >>, <<iif( lxDislinceBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDislinceCcod ) + "'" >>, <<lxDislinceNumero >>, <<"'" + this.FormatearTextoSql( lxDislinceCentidad ) + "'" >>, <<iif( lxDislinceLhabilitad, 1, 0 ) >>, <<iif( lxDislinceLdefault, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDislinceCobs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Atributos
				if this.oEntidad.Atributos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxAtributo = loItem.Atributo
					lxEtiqueta = loItem.Etiqueta
					lxConversion_PK = loItem.Conversion_PK
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisLinceAtri("NROITEM","BLOQREG","iCod","cAtributo","cEtiqueta","cConv" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributo ) + "'">>, <<"'" + this.FormatearTextoSql( lxEtiqueta ) + "'">>, <<"'" + this.FormatearTextoSql( lxConversion_PK ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxDislinceTimestamp
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
			local  lxDislinceFecexpo, lxDislinceFectrans, lxDislinceFecimpo, lxDislinceFaltafw, lxDislinceFmodifw, lxDislinceSaltafw, lxDislinceHmodifw, lxDislinceSmodifw, lxDislinceHoraimpo, lxDislinceUmodifw, lxDislinceZadsfw, lxDislinceValtafw, lxDislinceVmodifw, lxDislinceUaltafw, lxDislinceHoraexpo, lxDislinceBdmodifw, lxDislinceEsttrans, lxDislinceHaltafw, lxDislinceBdaltafw, lxDislinceTimestamp, lxDislinceBloqreg, lxDislinceCcod, lxDislinceNumero, lxDislinceCentidad, lxDislinceLhabilitad, lxDislinceLdefault, lxDislinceCobs
				lxDislinceFecexpo =  .Fechaexpo			lxDislinceFectrans =  .Fechatransferencia			lxDislinceFecimpo =  .Fechaimpo			lxDislinceFaltafw =  .Fechaaltafw			lxDislinceFmodifw =  .Fechamodificacionfw			lxDislinceSaltafw =  .Seriealtafw			lxDislinceHmodifw =  .Horamodificacionfw			lxDislinceSmodifw =  .Seriemodificacionfw			lxDislinceHoraimpo =  .Horaimpo			lxDislinceUmodifw =  .Usuariomodificacionfw			lxDislinceZadsfw =  .Zadsfw			lxDislinceValtafw =  .Versionaltafw			lxDislinceVmodifw =  .Versionmodificacionfw			lxDislinceUaltafw =  .Usuarioaltafw			lxDislinceHoraexpo =  .Horaexpo			lxDislinceBdmodifw =  .Basededatosmodificacionfw			lxDislinceEsttrans =  .Estadotransferencia			lxDislinceHaltafw =  .Horaaltafw			lxDislinceBdaltafw =  .Basededatosaltafw			lxDislinceTimestamp = goLibrerias.ObtenerTimestamp()			lxDislinceBloqreg =  .Bloquearregistro			lxDislinceCcod =  .Codigo			lxDislinceNumero =  .Numero			lxDislinceCentidad =  .Entidad			lxDislinceLhabilitad =  .Habilitado			lxDislinceLdefault =  .Defaultdiseno			lxDislinceCobs =  .Obs
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
				update ORGANIZACION.DISLINCE set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxDislinceFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxDislinceFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxDislinceFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxDislinceFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxDislinceFmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxDislinceSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxDislinceHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxDislinceSmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxDislinceHoraimpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxDislinceUmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxDislinceZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxDislinceValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxDislinceVmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxDislinceUaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxDislinceHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxDislinceBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxDislinceEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxDislinceHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxDislinceBdaltafw ) + "'">>,"Timestamp" = <<lxDislinceTimestamp>>,"Bloqreg" = <<iif( lxDislinceBloqreg, 1, 0 )>>,"Ccod" = <<"'" + this.FormatearTextoSql( lxDislinceCcod ) + "'">>,"Numero" = <<lxDislinceNumero>>,"Centidad" = <<"'" + this.FormatearTextoSql( lxDislinceCentidad ) + "'">>,"Lhabilitad" = <<iif( lxDislinceLhabilitad, 1, 0 )>>,"Ldefault" = <<iif( lxDislinceLdefault, 1, 0 )>>,"Cobs" = <<"'" + this.FormatearTextoSql( lxDislinceCobs ) + "'">> where "Ccod" = <<"'" + this.FormatearTextoSql( lxDislinceCcod ) + "'">> and  DISLINCE.CCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DisLinceAtri where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Atributos
				if this.oEntidad.Atributos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxAtributo = loItem.Atributo
					lxEtiqueta = loItem.Etiqueta
					lxConversion_PK = loItem.Conversion_PK
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisLinceAtri("NROITEM","BLOQREG","iCod","cAtributo","cEtiqueta","cConv" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributo ) + "'">>, <<"'" + this.FormatearTextoSql( lxEtiqueta ) + "'">>, <<"'" + this.FormatearTextoSql( lxConversion_PK ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxDislinceTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 cCod from ORGANIZACION.DISLINCE where " + this.ConvertirFuncionesSql( " DISLINCE.CCOD != ''" ) )
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
			Local lxDislinceCcod
			lxDislinceCcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Ccod" as "Codigo", "Numero" as "Numero", "Centidad" as "Entidad", "Lhabilitad" as "Habilitado", "Ldefault" as "Defaultdiseno", "Cobs" as "Obs" from ORGANIZACION.DISLINCE where "Ccod" = <<"'" + this.FormatearTextoSql( lxDislinceCcod ) + "'">> and  DISLINCE.CCOD != ''
			endtext
			use in select('c_DISENOTRANSFORMACIONLINCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOTRANSFORMACIONLINCE', set( 'Datasession' ) )

			if reccount( 'c_DISENOTRANSFORMACIONLINCE' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Catributo" as "Atributo", "Cetiqueta" as "Etiqueta", "Cconv" as "Conversion" from ORGANIZACION.DisLinceAtri where iCod = <<"'" + this.FormatearTextoSql( c_DISENOTRANSFORMACIONLINCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Atributos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Atributos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Atributos
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxDisLinceNumero As Variant
			lxDisLinceNumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Ccod" as "Codigo", "Numero" as "Numero", "Centidad" as "Entidad", "Lhabilitad" as "Habilitado", "Ldefault" as "Defaultdiseno", "Cobs" as "Obs" from ORGANIZACION.DISLINCE where  DISLINCE.CCOD != '' And Numero = <<lxDisLinceNumero>>
			endtext
			use in select('c_DISENOTRANSFORMACIONLINCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOTRANSFORMACIONLINCE', set( 'Datasession' ) )
			if reccount( 'c_DISENOTRANSFORMACIONLINCE' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Catributo" as "Atributo", "Cetiqueta" as "Etiqueta", "Cconv" as "Conversion" from ORGANIZACION.DisLinceAtri where iCod = <<"'" + this.FormatearTextoSql( c_DISENOTRANSFORMACIONLINCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Atributos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Atributos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Atributos
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxDislinceCcod as Variant
		llRetorno = .t.
		lxDislinceCcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ORGANIZACION.DISLINCE where "Ccod" = <<"'" + this.FormatearTextoSql( lxDislinceCcod ) + "'">> and  DISLINCE.CCOD != ''
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
				lcOrden =  str( .Numero, 10, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Ccod" as "Codigo", "Numero" as "Numero", "Centidad" as "Entidad", "Lhabilitad" as "Habilitado", "Ldefault" as "Defaultdiseno", "Cobs" as "Obs" from ORGANIZACION.DISLINCE where  DISLINCE.CCOD != '' order by Numero,cCod
			endtext
			use in select('c_DISENOTRANSFORMACIONLINCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOTRANSFORMACIONLINCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Catributo" as "Atributo", "Cetiqueta" as "Etiqueta", "Cconv" as "Conversion" from ORGANIZACION.DisLinceAtri where iCod = <<"'" + this.FormatearTextoSql( c_DISENOTRANSFORMACIONLINCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Atributos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Atributos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Atributos
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
				lcOrden =  str( .Numero, 10, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Ccod" as "Codigo", "Numero" as "Numero", "Centidad" as "Entidad", "Lhabilitad" as "Habilitado", "Ldefault" as "Defaultdiseno", "Cobs" as "Obs" from ORGANIZACION.DISLINCE where  str( Numero, 10, 0) + funciones.padr( cCod, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  DISLINCE.CCOD != '' order by Numero,cCod
			endtext
			use in select('c_DISENOTRANSFORMACIONLINCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOTRANSFORMACIONLINCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Catributo" as "Atributo", "Cetiqueta" as "Etiqueta", "Cconv" as "Conversion" from ORGANIZACION.DisLinceAtri where iCod = <<"'" + this.FormatearTextoSql( c_DISENOTRANSFORMACIONLINCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Atributos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Atributos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Atributos
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
				lcOrden =  str( .Numero, 10, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Ccod" as "Codigo", "Numero" as "Numero", "Centidad" as "Entidad", "Lhabilitad" as "Habilitado", "Ldefault" as "Defaultdiseno", "Cobs" as "Obs" from ORGANIZACION.DISLINCE where  str( Numero, 10, 0) + funciones.padr( cCod, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  DISLINCE.CCOD != '' order by Numero desc,cCod desc
			endtext
			use in select('c_DISENOTRANSFORMACIONLINCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOTRANSFORMACIONLINCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Catributo" as "Atributo", "Cetiqueta" as "Etiqueta", "Cconv" as "Conversion" from ORGANIZACION.DisLinceAtri where iCod = <<"'" + this.FormatearTextoSql( c_DISENOTRANSFORMACIONLINCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Atributos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Atributos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Atributos
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
				lcOrden =  str( .Numero, 10, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Ccod" as "Codigo", "Numero" as "Numero", "Centidad" as "Entidad", "Lhabilitad" as "Habilitado", "Ldefault" as "Defaultdiseno", "Cobs" as "Obs" from ORGANIZACION.DISLINCE where  DISLINCE.CCOD != '' order by Numero desc,cCod desc
			endtext
			use in select('c_DISENOTRANSFORMACIONLINCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOTRANSFORMACIONLINCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Catributo" as "Atributo", "Cetiqueta" as "Etiqueta", "Cconv" as "Conversion" from ORGANIZACION.DisLinceAtri where iCod = <<"'" + this.FormatearTextoSql( c_DISENOTRANSFORMACIONLINCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Atributos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Atributos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Atributos
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Saltafw,Hmodifw,Smodifw,Horaimpo,Umodifw,Zadsfw,Val" + ;
"tafw,Vmodifw,Ualtafw,Horaexpo,Bdmodifw,Esttrans,Haltafw,Bdaltafw,Timestamp,Bloqreg,Ccod,Numero,Centi" + ;
"dad,Lhabilitad,Ldefault,Cobs" + ;
" from ORGANIZACION.DISLINCE where  DISLINCE.CCOD != '' and " + lcFiltro )
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
			local  lxDislinceFecexpo, lxDislinceFectrans, lxDislinceFecimpo, lxDislinceFaltafw, lxDislinceFmodifw, lxDislinceSaltafw, lxDislinceHmodifw, lxDislinceSmodifw, lxDislinceHoraimpo, lxDislinceUmodifw, lxDislinceZadsfw, lxDislinceValtafw, lxDislinceVmodifw, lxDislinceUaltafw, lxDislinceHoraexpo, lxDislinceBdmodifw, lxDislinceEsttrans, lxDislinceHaltafw, lxDislinceBdaltafw, lxDislinceTimestamp, lxDislinceBloqreg, lxDislinceCcod, lxDislinceNumero, lxDislinceCentidad, lxDislinceLhabilitad, lxDislinceLdefault, lxDislinceCobs
				lxDislinceFecexpo = ctod( '  /  /    ' )			lxDislinceFectrans = ctod( '  /  /    ' )			lxDislinceFecimpo = ctod( '  /  /    ' )			lxDislinceFaltafw = ctod( '  /  /    ' )			lxDislinceFmodifw = ctod( '  /  /    ' )			lxDislinceSaltafw = []			lxDislinceHmodifw = []			lxDislinceSmodifw = []			lxDislinceHoraimpo = []			lxDislinceUmodifw = []			lxDislinceZadsfw = []			lxDislinceValtafw = []			lxDislinceVmodifw = []			lxDislinceUaltafw = []			lxDislinceHoraexpo = []			lxDislinceBdmodifw = []			lxDislinceEsttrans = []			lxDislinceHaltafw = []			lxDislinceBdaltafw = []			lxDislinceTimestamp = goLibrerias.ObtenerTimestamp()			lxDislinceBloqreg = .F.			lxDislinceCcod = []			lxDislinceNumero = 0			lxDislinceCentidad = []			lxDislinceLhabilitad = .F.			lxDislinceLdefault = .F.			lxDislinceCobs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DisLinceAtri where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ORGANIZACION.DISLINCE where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'DISLINCE' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where cCod = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(cCod, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DISLINCE.CCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Ccod" as "Codigo", "Numero" as "Numero", "Centidad" as "Entidad", "Lhabilitad" as "Habilitado", "Ldefault" as "Defaultdiseno", "Cobs" as "Obs"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DISLINCE', '', tnTope )
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
	Function ObtenerDatosDetalleAtributos( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DISLINCEATRI.ICOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Catributo" as "Atributo", "Cetiqueta" as "Etiqueta", "Cconv" as "Conversion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAtributos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DisLinceAtri', 'Atributos', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleAtributos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleAtributos( lcAtributo )
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
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOD AS CODIGO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'ENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CENTIDAD AS ENTIDAD'
				Case lcAtributo == 'HABILITADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LHABILITAD AS HABILITADO'
				Case lcAtributo == 'DEFAULTDISENO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LDEFAULT AS DEFAULTDISENO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBS AS OBS'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleAtributos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ICOD AS CODIGO'
				Case lcAtributo == 'ATRIBUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATRIBUTO AS ATRIBUTO'
				Case lcAtributo == 'ETIQUETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CETIQUETA AS ETIQUETA'
				Case lcAtributo == 'CONVERSION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCONV AS CONVERSION'
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
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CCOD'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDAD'
				lcCampo = 'CENTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'HABILITADO'
				lcCampo = 'LHABILITAD'
			Case upper( alltrim( tcAtributo ) ) == 'DEFAULTDISENO'
				lcCampo = 'LDEFAULT'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'COBS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleAtributos( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'ICOD'
			Case upper( alltrim( tcAtributo ) ) == 'ATRIBUTO'
				lcCampo = 'CATRIBUTO'
			Case upper( alltrim( tcAtributo ) ) == 'ETIQUETA'
				lcCampo = 'CETIQUETA'
			Case upper( alltrim( tcAtributo ) ) == 'CONVERSION'
				lcCampo = 'CCONV'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'ATRIBUTOS'
			lcRetorno = 'DISLINCEATRI'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxDislinceFecexpo, lxDislinceFectrans, lxDislinceFecimpo, lxDislinceFaltafw, lxDislinceFmodifw, lxDislinceSaltafw, lxDislinceHmodifw, lxDislinceSmodifw, lxDislinceHoraimpo, lxDislinceUmodifw, lxDislinceZadsfw, lxDislinceValtafw, lxDislinceVmodifw, lxDislinceUaltafw, lxDislinceHoraexpo, lxDislinceBdmodifw, lxDislinceEsttrans, lxDislinceHaltafw, lxDislinceBdaltafw, lxDislinceTimestamp, lxDislinceBloqreg, lxDislinceCcod, lxDislinceNumero, lxDislinceCentidad, lxDislinceLhabilitad, lxDislinceLdefault, lxDislinceCobs
				lxDislinceFecexpo =  .Fechaexpo			lxDislinceFectrans =  .Fechatransferencia			lxDislinceFecimpo =  .Fechaimpo			lxDislinceFaltafw =  .Fechaaltafw			lxDislinceFmodifw =  .Fechamodificacionfw			lxDislinceSaltafw =  .Seriealtafw			lxDislinceHmodifw =  .Horamodificacionfw			lxDislinceSmodifw =  .Seriemodificacionfw			lxDislinceHoraimpo =  .Horaimpo			lxDislinceUmodifw =  .Usuariomodificacionfw			lxDislinceZadsfw =  .Zadsfw			lxDislinceValtafw =  .Versionaltafw			lxDislinceVmodifw =  .Versionmodificacionfw			lxDislinceUaltafw =  .Usuarioaltafw			lxDislinceHoraexpo =  .Horaexpo			lxDislinceBdmodifw =  .Basededatosmodificacionfw			lxDislinceEsttrans =  .Estadotransferencia			lxDislinceHaltafw =  .Horaaltafw			lxDislinceBdaltafw =  .Basededatosaltafw			lxDislinceTimestamp = goLibrerias.ObtenerTimestamp()			lxDislinceBloqreg =  .Bloquearregistro			lxDislinceCcod =  .Codigo			lxDislinceNumero =  .Numero			lxDislinceCentidad =  .Entidad			lxDislinceLhabilitad =  .Habilitado			lxDislinceLdefault =  .Defaultdiseno			lxDislinceCobs =  .Obs
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ORGANIZACION.DISLINCE ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Saltafw","Hmodifw","Smodifw","Horaimpo","Umodifw","Zadsfw","Valtafw","Vmodifw","Ualtafw","Horaexpo","Bdmodifw","Esttrans","Haltafw","Bdaltafw","Timestamp","Bloqreg","Ccod","Numero","Centidad","Lhabilitad","Ldefault","Cobs" ) values ( <<"'" + this.ConvertirDateSql( lxDislinceFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDislinceFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDislinceFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDislinceFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDislinceFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDislinceBdaltafw ) + "'" >>, <<lxDislinceTimestamp >>, <<iif( lxDislinceBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDislinceCcod ) + "'" >>, <<lxDislinceNumero >>, <<"'" + this.FormatearTextoSql( lxDislinceCentidad ) + "'" >>, <<iif( lxDislinceLhabilitad, 1, 0 ) >>, <<iif( lxDislinceLdefault, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDislinceCobs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'DISLINCE' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Atributos
				if this.oEntidad.Atributos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxAtributo = loItem.Atributo
					lxEtiqueta = loItem.Etiqueta
					lxConversion_PK = loItem.Conversion_PK
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisLinceAtri("NROITEM","BLOQREG","iCod","cAtributo","cEtiqueta","cConv" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAtributo ) + "'">>, <<"'" + this.FormatearTextoSql( lxEtiqueta ) + "'">>, <<"'" + this.FormatearTextoSql( lxConversion_PK ) + "'">> ) 
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
			local  lxDislinceFecexpo, lxDislinceFectrans, lxDislinceFecimpo, lxDislinceFaltafw, lxDislinceFmodifw, lxDislinceSaltafw, lxDislinceHmodifw, lxDislinceSmodifw, lxDislinceHoraimpo, lxDislinceUmodifw, lxDislinceZadsfw, lxDislinceValtafw, lxDislinceVmodifw, lxDislinceUaltafw, lxDislinceHoraexpo, lxDislinceBdmodifw, lxDislinceEsttrans, lxDislinceHaltafw, lxDislinceBdaltafw, lxDislinceTimestamp, lxDislinceBloqreg, lxDislinceCcod, lxDislinceNumero, lxDislinceCentidad, lxDislinceLhabilitad, lxDislinceLdefault, lxDislinceCobs
				lxDislinceFecexpo =  .Fechaexpo			lxDislinceFectrans =  .Fechatransferencia			lxDislinceFecimpo =  .Fechaimpo			lxDislinceFaltafw =  .Fechaaltafw			lxDislinceFmodifw =  .Fechamodificacionfw			lxDislinceSaltafw =  .Seriealtafw			lxDislinceHmodifw =  .Horamodificacionfw			lxDislinceSmodifw =  .Seriemodificacionfw			lxDislinceHoraimpo =  .Horaimpo			lxDislinceUmodifw =  .Usuariomodificacionfw			lxDislinceZadsfw =  .Zadsfw			lxDislinceValtafw =  .Versionaltafw			lxDislinceVmodifw =  .Versionmodificacionfw			lxDislinceUaltafw =  .Usuarioaltafw			lxDislinceHoraexpo =  .Horaexpo			lxDislinceBdmodifw =  .Basededatosmodificacionfw			lxDislinceEsttrans =  .Estadotransferencia			lxDislinceHaltafw =  .Horaaltafw			lxDislinceBdaltafw =  .Basededatosaltafw			lxDislinceTimestamp = goLibrerias.ObtenerTimestamp()			lxDislinceBloqreg =  .Bloquearregistro			lxDislinceCcod =  .Codigo			lxDislinceNumero =  .Numero			lxDislinceCentidad =  .Entidad			lxDislinceLhabilitad =  .Habilitado			lxDislinceLdefault =  .Defaultdiseno			lxDislinceCobs =  .Obs
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  DISLINCE.CCOD != '']
			text to lcSentencia noshow textmerge
				update ORGANIZACION.DISLINCE set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxDislinceFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxDislinceFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxDislinceFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxDislinceFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxDislinceFmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxDislinceSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxDislinceHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxDislinceSmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxDislinceHoraimpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxDislinceUmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxDislinceZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxDislinceValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxDislinceVmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxDislinceUaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxDislinceHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxDislinceBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxDislinceEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxDislinceHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxDislinceBdaltafw ) + "'">>, "Timestamp" = <<lxDislinceTimestamp>>, "Bloqreg" = <<iif( lxDislinceBloqreg, 1, 0 )>>, "Ccod" = <<"'" + this.FormatearTextoSql( lxDislinceCcod ) + "'">>, "Numero" = <<lxDislinceNumero>>, "Centidad" = <<"'" + this.FormatearTextoSql( lxDislinceCentidad ) + "'">>, "Lhabilitad" = <<iif( lxDislinceLhabilitad, 1, 0 )>>, "Ldefault" = <<iif( lxDislinceLdefault, 1, 0 )>>, "Cobs" = <<"'" + this.FormatearTextoSql( lxDislinceCobs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'DISLINCE' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ORGANIZACION.DisLinceAtri where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Atributos
				if this.oEntidad.Atributos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxAtributo = loItem.Atributo
					lxEtiqueta = loItem.Etiqueta
					lxConversion_PK = loItem.Conversion_PK
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisLinceAtri("NROITEM","BLOQREG","iCod","cAtributo","cEtiqueta","cConv" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAtributo ) + "'">>, <<"'" + this.FormatearTextoSql( lxEtiqueta ) + "'">>, <<"'" + this.FormatearTextoSql( lxConversion_PK ) + "'">> ) 
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
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  DISLINCE.CCOD != '']
		loColeccion.Agregar( 'delete from ORGANIZACION.DISLINCE where ' + lcFiltro )
			loColeccion.Agregar([delete from ORGANIZACION.DisLinceAtri where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'DISLINCE' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ORGANIZACION.DISLINCE where  DISLINCE.CCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ORGANIZACION.DISLINCE where cCod = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  DISLINCE.CCOD != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxDisLinceNumero as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOTRANSFORMACIONLINCE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ORGANIZACION.DISLINCE Where  Numero = ] + transform( &lcCursor..Numero     ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..cCod
				if lxValorClavePK == curSeek.cCod or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.cCod and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.cCod
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ORGANIZACION.DISLINCE set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, cEntidad = ] + "'" + this.FormatearTextoSql( &lcCursor..cEntidad ) + "'"+ [, lHabilitad = ] + Transform( iif( &lcCursor..lHabilitad, 1, 0 ))+ [, lDefault = ] + Transform( iif( &lcCursor..lDefault, 1, 0 ))+ [, cObs = ] + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'" + [ Where cCod = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ORGANIZACION.DISLINCE Where cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FECTRANS, FECIMPO, FALTAFW, FMODIFW, SALTAFW, HMODIFW, SMODIFW, HORAIMPO, UMODIFW, ZADSFW, VALTAFW, VMODIFW, UALTAFW, HORAEXPO, BDMODIFW, ESTTRANS, HALTAFW, BDALTAFW, TIMESTAMP, BLOQREG, cCod, Numero, cEntidad, lHabilitad, lDefault, cObs
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'" + ',' + transform( &lcCursor..Numero ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cEntidad ) + "'" + ',' + Transform( iif( &lcCursor..lHabilitad, 1, 0 )) + ',' + Transform( iif( &lcCursor..lDefault, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ORGANIZACION.DISLINCE ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOTRANSFORMACIONLINCE'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'cCod','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','cCod')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ORGANIZACION.DisLinceAtri Where iCod] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMATRIBUTOSLINCE'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where iCod in ( select cCod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","BLOQREG","iCod","cAtributo","cEtiqueta","cConv"
		endText
		this.oConexion.EjecutarSql( [Insert into ORGANIZACION.DisLinceAtri ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.BLOQREG   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cAtributo  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cEtiqueta  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cConv      ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( cCod C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..Numero     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'DISENOTRANSFORMACIONLINCE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DISENOTRANSFORMACIONLINCE_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DISENOTRANSFORMACIONLINCE_COBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMATRIBUTOSLINCE'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ORGANIZACION.TablaTrabajo_DisLince')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'DISENOTRANSFORMACIONLINCE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..cCod
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Numero )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad DISENOTRANSFORMACIONLINCE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOTRANSFORMACIONLINCE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,cCod as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( cCod, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( Numero, 10, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( Numero, 10, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOTRANSFORMACIONLINCE'
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_DisLince') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_DisLince
Create Table ORGANIZACION.TablaTrabajo_DisLince ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"horaexpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"bloqreg" bit  null, 
"ccod" char( 38 )  null, 
"numero" numeric( 10, 0 )  null, 
"centidad" char( 40 )  null, 
"lhabilitad" bit  null, 
"ldefault" bit  null, 
"cobs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_DisLince' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_DisLince' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOTRANSFORMACIONLINCE'
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
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('ccod','ccod')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('centidad','centidad')
			.AgregarMapeo('lhabilitad','lhabilitad')
			.AgregarMapeo('ldefault','ldefault')
			.AgregarMapeo('cobs','cobs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ORGANIZACION.TablaTrabajo_DisLince'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.CCOD = isnull( d.CCOD, t.CCOD ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.CENTIDAD = isnull( d.CENTIDAD, t.CENTIDAD ),t.LHABILITAD = isnull( d.LHABILITAD, t.LHABILITAD ),t.LDEFAULT = isnull( d.LDEFAULT, t.LDEFAULT ),t.COBS = isnull( d.COBS, t.COBS )
					from ORGANIZACION.DISLINCE t inner join deleted d 
							 on t.cCod = d.cCod
							 and  t.Numero = d.Numero
				-- Fin Updates
				insert into ORGANIZACION.DISLINCE(Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Saltafw,Hmodifw,Smodifw,Horaimpo,Umodifw,Zadsfw,Valtafw,Vmodifw,Ualtafw,Horaexpo,Bdmodifw,Esttrans,Haltafw,Bdaltafw,Timestamp,Bloqreg,Ccod,Numero,Centidad,Lhabilitad,Ldefault,Cobs)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.UMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.TIMESTAMP,0),isnull( d.BLOQREG,0),isnull( d.CCOD,''),isnull( d.NUMERO,0),isnull( d.CENTIDAD,''),isnull( d.LHABILITAD,0),isnull( d.LDEFAULT,0),isnull( d.COBS,'')
						From deleted d left join ORGANIZACION.DISLINCE pk 
							 on d.cCod = pk.cCod
						 left join ORGANIZACION.DISLINCE cc 
							 on  d.Numero = cc.Numero
						Where pk.cCod Is Null 
							 and cc.Numero Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.Numero as Varchar(10) ) + '','La clave principal no es la esperada'
					from ORGANIZACION.DISLINCE t inner join deleted d 
							on   t.Numero = d.Numero
						left join deleted h 
							 on t.cCod = h.cCod
							 where h.cCod is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.Numero as Varchar(10) ) + '','La clave principal a importar ya existe'
					from ORGANIZACION.DISLINCE t inner join deleted d 
							 on t.cCod = d.cCod
						left join deleted h 
							on   t.Numero = h.Numero
							where   h.Numero is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DisLinceAtri( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ORGANIZACION.DELETE_TablaTrabajo_DISLINCE_DisLinceAtri
ON ORGANIZACION.TablaTrabajo_DISLINCE_DisLinceAtri
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),
t.ICOD = isnull( d.ICOD, t.ICOD ),
t.CATRIBUTO = isnull( d.CATRIBUTO, t.CATRIBUTO ),
t.CETIQUETA = isnull( d.CETIQUETA, t.CETIQUETA ),
t.CCONV = isnull( d.CCONV, t.CCONV )
from ORGANIZACION.DisLinceAtri t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ORGANIZACION.DisLinceAtri
( 
"NROITEM",
"BLOQREG",
"ICOD",
"CATRIBUTO",
"CETIQUETA",
"CCONV"
 )
Select 
d.NROITEM,
d.BLOQREG,
d.ICOD,
d.CATRIBUTO,
d.CETIQUETA,
d.CCONV
From deleted d left join ORGANIZACION.DisLinceAtri pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_DisLince') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_DisLince
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_DISENOTRANSFORMACIONLINCE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOTRANSFORMACIONLINCE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOTRANSFORMACIONLINCE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOTRANSFORMACIONLINCE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOTRANSFORMACIONLINCE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOTRANSFORMACIONLINCE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Seriealtafw = nvl( c_DISENOTRANSFORMACIONLINCE.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_DISENOTRANSFORMACIONLINCE.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_DISENOTRANSFORMACIONLINCE.Seriemodificacionfw, [] )
					.Horaimpo = nvl( c_DISENOTRANSFORMACIONLINCE.Horaimpo, [] )
					.Usuariomodificacionfw = nvl( c_DISENOTRANSFORMACIONLINCE.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_DISENOTRANSFORMACIONLINCE.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_DISENOTRANSFORMACIONLINCE.Versionmodificacionfw, [] )
					.Usuarioaltafw = nvl( c_DISENOTRANSFORMACIONLINCE.Usuarioaltafw, [] )
					.Horaexpo = nvl( c_DISENOTRANSFORMACIONLINCE.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_DISENOTRANSFORMACIONLINCE.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_DISENOTRANSFORMACIONLINCE.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_DISENOTRANSFORMACIONLINCE.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_DISENOTRANSFORMACIONLINCE.Basededatosaltafw, [] )
					.Timestamp = nvl( c_DISENOTRANSFORMACIONLINCE.Timestamp, 0 )
					.Bloquearregistro = nvl( c_DISENOTRANSFORMACIONLINCE.Bloquearregistro, .F. )
					.Codigo = nvl( c_DISENOTRANSFORMACIONLINCE.Codigo, [] )
					.Numero = nvl( c_DISENOTRANSFORMACIONLINCE.Numero, 0 )
					.Entidad = nvl( c_DISENOTRANSFORMACIONLINCE.Entidad, [] )
					.Habilitado = nvl( c_DISENOTRANSFORMACIONLINCE.Habilitado, .F. )
					.Defaultdiseno = nvl( c_DISENOTRANSFORMACIONLINCE.Defaultdiseno, .F. )
					.Atributos.Limpiar()
					.Atributos.SetearEsNavegacion( .lProcesando )
					.Atributos.Cargar()
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
	function ObtenerIdPorClaveCandidata() as variant
		local lxRetorno as Variant
		lxRetorno = ''
		if this.ConsultarPorClaveCandidata()
			lxRetorno = c_DISENOTRANSFORMACIONLINCE.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.Atributos
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
		return c_DISENOTRANSFORMACIONLINCE.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ORGANIZACION.DISLINCE' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "cCod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,cCod as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    cCod from (
							select * 
								from ORGANIZACION.DISLINCE 
								Where   DISLINCE.CCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "DISLINCE", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "cCod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Ccod" as "Codigo", "Numero" as "Numero", "Centidad" as "Entidad", "Lhabilitad" as "Habilitado", "Ldefault" as "Defaultdiseno", "Cobs" as "Obs"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ORGANIZACION.DISLINCE 
								Where   DISLINCE.CCOD != ''
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
	Tabla = 'DISLINCE'
	Filtro = " DISLINCE.CCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " DISLINCE.CCOD != ''"
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
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="FECHAEXPO                               " tabla="DISLINCE       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="FECHATRANSFERENCIA                      " tabla="DISLINCE       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="FECHAIMPO                               " tabla="DISLINCE       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="FECHAALTAFW                             " tabla="DISLINCE       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="FECHAMODIFICACIONFW                     " tabla="DISLINCE       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="SERIEALTAFW                             " tabla="DISLINCE       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="HORAMODIFICACIONFW                      " tabla="DISLINCE       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="SERIEMODIFICACIONFW                     " tabla="DISLINCE       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="HORAIMPO                                " tabla="DISLINCE       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="USUARIOMODIFICACIONFW                   " tabla="DISLINCE       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="ZADSFW                                  " tabla="DISLINCE       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="VERSIONALTAFW                           " tabla="DISLINCE       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="VERSIONMODIFICACIONFW                   " tabla="DISLINCE       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="USUARIOALTAFW                           " tabla="DISLINCE       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="HORAEXPO                                " tabla="DISLINCE       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="DISLINCE       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="ESTADOTRANSFERENCIA                     " tabla="DISLINCE       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="HORAALTAFW                              " tabla="DISLINCE       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="BASEDEDATOSALTAFW                       " tabla="DISLINCE       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="TIMESTAMP                               " tabla="DISLINCE       " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="BLOQUEARREGISTRO                        " tabla="DISLINCE       " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="CODIGO                                  " tabla="DISLINCE       " campo="CCOD      " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="NUMERO                                  " tabla="DISLINCE       " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Número                                                                                                                                                          " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="ENTIDAD                                 " tabla="DISLINCE       " campo="CENTIDAD  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Entidad                                                                                                                                                         " dominio="COMBOENTIDADESLINCE           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="HABILITADO                              " tabla="DISLINCE       " campo="LHABILITAD" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="200" etiqueta="Habilitado                                                                                                                                                      " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="DEFAULTDISENO                           " tabla="DISLINCE       " campo="LDEFAULT  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="Diseño predeterminado                                                                                                                                           " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="ATRIBUTOS                               " tabla="DISLINCEATRI   " campo="ICOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="Campos                                                                                                                                                          " dominio="DETALLEITEMATRIBUTOSLINCE     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="16" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOTRANSFORMACIONLINCE               " atributo="OBS                                     " tabla="DISLINCE       " campo="COBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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