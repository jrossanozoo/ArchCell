
define class Din_EntidadMODIFICACIONPRECIOSAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_MODIFICACIONPRECIOS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( Numero, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.Numero, 8, 0)]
	cTagClaveCandidata = '_PRECC'
	cTagClavePk = '_PREPK'
	cTablaPrincipal = 'MODPRE'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
			.ColSentencias = _screen.zoo.crearobjeto('zooColeccion')
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
			local  lxModpreFecexpo, lxModpreFectrans, lxModpreFecimpo, lxModpreFaltafw, lxModpreFmodifw, lxModpreUaltafw, lxModpreSmodifw, lxModpreSaltafw, lxModpreUmodifw, lxModpreVmodifw, lxModpreZadsfw, lxModpreValtafw, lxModpreDescfw, lxModpreHmodifw, lxModpreHaltafw, lxModpreBdaltafw, lxModpreHoraimpo, lxModpreBdmodifw, lxModpreEsttrans, lxModpreHoraexpo, lxModpreTimestamp, lxModpreAnulado, lxModpreFecha, lxModpreCodigo, lxModpreMobs, lxModpreFechabase, lxModpreNumero, lxModpreFechavig
				lxModpreFecexpo =  .Fechaexpo			lxModpreFectrans =  .Fechatransferencia			lxModpreFecimpo =  .Fechaimpo			lxModpreFaltafw =  .Fechaaltafw			lxModpreFmodifw =  .Fechamodificacionfw			lxModpreUaltafw =  .Usuarioaltafw			lxModpreSmodifw =  .Seriemodificacionfw			lxModpreSaltafw =  .Seriealtafw			lxModpreUmodifw =  .Usuariomodificacionfw			lxModpreVmodifw =  .Versionmodificacionfw			lxModpreZadsfw =  .Zadsfw			lxModpreValtafw =  .Versionaltafw			lxModpreDescfw =  .Descripcionfw			lxModpreHmodifw =  .Horamodificacionfw			lxModpreHaltafw =  .Horaaltafw			lxModpreBdaltafw =  .Basededatosaltafw			lxModpreHoraimpo =  .Horaimpo			lxModpreBdmodifw =  .Basededatosmodificacionfw			lxModpreEsttrans =  .Estadotransferencia			lxModpreHoraexpo =  .Horaexpo			lxModpreTimestamp = goLibrerias.ObtenerTimestamp()			lxModpreAnulado =  .Anulado			lxModpreFecha =  .Fecha			lxModpreCodigo =  .Codigo			lxModpreMobs =  .Observacion			lxModpreFechabase =  .Fechabase			lxModpreNumero =  .Numero			lxModpreFechavig =  .Fechavigencia
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxModpreCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.MODPRE ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Ualtafw","Smodifw","Saltafw","Umodifw","Vmodifw","Zadsfw","Valtafw","Descfw","Hmodifw","Haltafw","Bdaltafw","Horaimpo","Bdmodifw","Esttrans","Horaexpo","Timestamp","Anulado","Fecha","Codigo","Mobs","Fechabase","Numero","Fechavig" ) values ( <<"'" + this.ConvertirDateSql( lxModpreFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModpreFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModpreFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModpreFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModpreFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreHoraexpo ) + "'" >>, <<lxModpreTimestamp >>, <<iif( lxModpreAnulado, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxModpreFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreMobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModpreFechabase ) + "'" >>, <<lxModpreNumero >>, <<"'" + this.ConvertirDateSql( lxModpreFechavig ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModPrecios
				if this.oEntidad.ModPrecios.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxListadeprecio_PK = loItem.Listadeprecio_PK
					lxPreciodelista = loItem.Preciodelista
					lxPrecioact = loItem.Precioact
					lxTimestampalta = loItem.Timestampalta
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODIPRECDET("CODIGO","COMP","NROITEM","Equiv","CodArt","DescArt","cColor","Coltxt","Talle","Talltxt","CodLisPr","CodPreLis","CodPreAct","TimestampA" ) values ( <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxListadeprecio_PK ) + "'">>, <<lxPreciodelista>>, <<lxPrecioact>>, <<lxTimestampalta>> ) 
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
		this.oEntidad.Timestamp = lxModpreTimestamp
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
			this.GenerarSentenciasComponentes()
			if .lAnular
				.Limpiar()
				.CargarAtributosAnulacion()
			endif
			local  lxModpreFecexpo, lxModpreFectrans, lxModpreFecimpo, lxModpreFaltafw, lxModpreFmodifw, lxModpreUaltafw, lxModpreSmodifw, lxModpreSaltafw, lxModpreUmodifw, lxModpreVmodifw, lxModpreZadsfw, lxModpreValtafw, lxModpreDescfw, lxModpreHmodifw, lxModpreHaltafw, lxModpreBdaltafw, lxModpreHoraimpo, lxModpreBdmodifw, lxModpreEsttrans, lxModpreHoraexpo, lxModpreTimestamp, lxModpreAnulado, lxModpreFecha, lxModpreCodigo, lxModpreMobs, lxModpreFechabase, lxModpreNumero, lxModpreFechavig
				lxModpreFecexpo =  .Fechaexpo			lxModpreFectrans =  .Fechatransferencia			lxModpreFecimpo =  .Fechaimpo			lxModpreFaltafw =  .Fechaaltafw			lxModpreFmodifw =  .Fechamodificacionfw			lxModpreUaltafw =  .Usuarioaltafw			lxModpreSmodifw =  .Seriemodificacionfw			lxModpreSaltafw =  .Seriealtafw			lxModpreUmodifw =  .Usuariomodificacionfw			lxModpreVmodifw =  .Versionmodificacionfw			lxModpreZadsfw =  .Zadsfw			lxModpreValtafw =  .Versionaltafw			lxModpreDescfw =  .Descripcionfw			lxModpreHmodifw =  .Horamodificacionfw			lxModpreHaltafw =  .Horaaltafw			lxModpreBdaltafw =  .Basededatosaltafw			lxModpreHoraimpo =  .Horaimpo			lxModpreBdmodifw =  .Basededatosmodificacionfw			lxModpreEsttrans =  .Estadotransferencia			lxModpreHoraexpo =  .Horaexpo			lxModpreTimestamp = goLibrerias.ObtenerTimestamp()			lxModpreAnulado =  .Anulado			lxModpreFecha =  .Fecha			lxModpreCodigo =  .Codigo			lxModpreMobs =  .Observacion			lxModpreFechabase =  .Fechabase			lxModpreNumero =  .Numero			lxModpreFechavig =  .Fechavigencia
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
				update ZooLogic.MODPRE set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxModpreFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxModpreFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxModpreFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxModpreFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxModpreFmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxModpreUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxModpreSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxModpreSaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxModpreUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxModpreVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxModpreZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxModpreValtafw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxModpreDescfw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxModpreHmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxModpreHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxModpreBdaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxModpreHoraimpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxModpreBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxModpreEsttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxModpreHoraexpo ) + "'">>,"Timestamp" = <<lxModpreTimestamp>>,"Anulado" = <<iif( lxModpreAnulado, 1, 0 )>>,"Fecha" = <<"'" + this.ConvertirDateSql( lxModpreFecha ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxModpreCodigo ) + "'">>,"Mobs" = <<"'" + this.FormatearTextoSql( lxModpreMobs ) + "'">>,"Fechabase" = <<"'" + this.ConvertirDateSql( lxModpreFechabase ) + "'">>,"Numero" = <<lxModpreNumero>>,"Fechavig" = <<"'" + this.ConvertirDateSql( lxModpreFechavig ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxModpreCodigo ) + "'">> and  MODPRE.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.MODIPRECDET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModPrecios
				if this.oEntidad.ModPrecios.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxListadeprecio_PK = loItem.Listadeprecio_PK
					lxPreciodelista = loItem.Preciodelista
					lxPrecioact = loItem.Precioact
					lxTimestampalta = loItem.Timestampalta
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODIPRECDET("CODIGO","COMP","NROITEM","Equiv","CodArt","DescArt","cColor","Coltxt","Talle","Talltxt","CodLisPr","CodPreLis","CodPreAct","TimestampA" ) values ( <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxListadeprecio_PK ) + "'">>, <<lxPreciodelista>>, <<lxPrecioact>>, <<lxTimestampalta>> ) 
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
		this.oEntidad.Timestamp = lxModpreTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.MODPRE where " + this.ConvertirFuncionesSql( " MODPRE.CODIGO != ''" ) )
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
			Local lxModpreCodigo
			lxModpreCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Fecha" as "Fecha", "Codigo" as "Codigo", "Mobs" as "Observacion", "Fechabase" as "Fechabase", "Numero" as "Numero", "Fechavig" as "Fechavigencia" from ZooLogic.MODPRE where "Codigo" = <<"'" + this.FormatearTextoSql( lxModpreCodigo ) + "'">> and  MODPRE.CODIGO != ''
			endtext
			use in select('c_MODIFICACIONPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODIFICACIONPRECIOS', set( 'Datasession' ) )

			if reccount( 'c_MODIFICACIONPRECIOS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Equiv" as "Equivalencia", "Codart" as "Articulo", "Descart" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talle" as "Talle", "Talltxt" as "Talledetalle", "Codlispr" as "Listadeprecio", "Codprelis" as "Preciodelista", "Codpreact" as "Precioact", "Timestampa" as "Timestampalta" from ZooLogic.MODIPRECDET where CODIGO = <<"'" + this.FormatearTextoSql( c_MODIFICACIONPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModPrecios')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModPrecios', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModPrecios
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxMODPRENumero As Variant
			lxMODPRENumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Fecha" as "Fecha", "Codigo" as "Codigo", "Mobs" as "Observacion", "Fechabase" as "Fechabase", "Numero" as "Numero", "Fechavig" as "Fechavigencia" from ZooLogic.MODPRE where  MODPRE.CODIGO != '' And Numero = <<lxMODPRENumero>>
			endtext
			use in select('c_MODIFICACIONPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODIFICACIONPRECIOS', set( 'Datasession' ) )
			if reccount( 'c_MODIFICACIONPRECIOS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Equiv" as "Equivalencia", "Codart" as "Articulo", "Descart" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talle" as "Talle", "Talltxt" as "Talledetalle", "Codlispr" as "Listadeprecio", "Codprelis" as "Preciodelista", "Codpreact" as "Precioact", "Timestampa" as "Timestampalta" from ZooLogic.MODIPRECDET where CODIGO = <<"'" + this.FormatearTextoSql( c_MODIFICACIONPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModPrecios')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModPrecios', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModPrecios
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxModpreCodigo as Variant
		llRetorno = .t.
		lxModpreCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.MODPRE where "Codigo" = <<"'" + this.FormatearTextoSql( lxModpreCodigo ) + "'">> and  MODPRE.CODIGO != ''
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
				lcOrden =  str( .Numero, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Fecha" as "Fecha", "Codigo" as "Codigo", "Mobs" as "Observacion", "Fechabase" as "Fechabase", "Numero" as "Numero", "Fechavig" as "Fechavigencia" from ZooLogic.MODPRE where  MODPRE.CODIGO != '' order by Numero,CODIGO
			endtext
			use in select('c_MODIFICACIONPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODIFICACIONPRECIOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Equiv" as "Equivalencia", "Codart" as "Articulo", "Descart" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talle" as "Talle", "Talltxt" as "Talledetalle", "Codlispr" as "Listadeprecio", "Codprelis" as "Preciodelista", "Codpreact" as "Precioact", "Timestampa" as "Timestampalta" from ZooLogic.MODIPRECDET where CODIGO = <<"'" + this.FormatearTextoSql( c_MODIFICACIONPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModPrecios')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModPrecios', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModPrecios
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
				lcOrden =  str( .Numero, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Fecha" as "Fecha", "Codigo" as "Codigo", "Mobs" as "Observacion", "Fechabase" as "Fechabase", "Numero" as "Numero", "Fechavig" as "Fechavigencia" from ZooLogic.MODPRE where  str( Numero, 8, 0) + funciones.padr( CODIGO, 20, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MODPRE.CODIGO != '' order by Numero,CODIGO
			endtext
			use in select('c_MODIFICACIONPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODIFICACIONPRECIOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Equiv" as "Equivalencia", "Codart" as "Articulo", "Descart" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talle" as "Talle", "Talltxt" as "Talledetalle", "Codlispr" as "Listadeprecio", "Codprelis" as "Preciodelista", "Codpreact" as "Precioact", "Timestampa" as "Timestampalta" from ZooLogic.MODIPRECDET where CODIGO = <<"'" + this.FormatearTextoSql( c_MODIFICACIONPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModPrecios')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModPrecios', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModPrecios
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
				lcOrden =  str( .Numero, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Fecha" as "Fecha", "Codigo" as "Codigo", "Mobs" as "Observacion", "Fechabase" as "Fechabase", "Numero" as "Numero", "Fechavig" as "Fechavigencia" from ZooLogic.MODPRE where  str( Numero, 8, 0) + funciones.padr( CODIGO, 20, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MODPRE.CODIGO != '' order by Numero desc,CODIGO desc
			endtext
			use in select('c_MODIFICACIONPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODIFICACIONPRECIOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Equiv" as "Equivalencia", "Codart" as "Articulo", "Descart" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talle" as "Talle", "Talltxt" as "Talledetalle", "Codlispr" as "Listadeprecio", "Codprelis" as "Preciodelista", "Codpreact" as "Precioact", "Timestampa" as "Timestampalta" from ZooLogic.MODIPRECDET where CODIGO = <<"'" + this.FormatearTextoSql( c_MODIFICACIONPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModPrecios')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModPrecios', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModPrecios
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
				lcOrden =  str( .Numero, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Fecha" as "Fecha", "Codigo" as "Codigo", "Mobs" as "Observacion", "Fechabase" as "Fechabase", "Numero" as "Numero", "Fechavig" as "Fechavigencia" from ZooLogic.MODPRE where  MODPRE.CODIGO != '' order by Numero desc,CODIGO desc
			endtext
			use in select('c_MODIFICACIONPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODIFICACIONPRECIOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Equiv" as "Equivalencia", "Codart" as "Articulo", "Descart" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talle" as "Talle", "Talltxt" as "Talledetalle", "Codlispr" as "Listadeprecio", "Codprelis" as "Preciodelista", "Codpreact" as "Precioact", "Timestampa" as "Timestampalta" from ZooLogic.MODIPRECDET where CODIGO = <<"'" + this.FormatearTextoSql( c_MODIFICACIONPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModPrecios')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModPrecios', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModPrecios
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Ualtafw,Smodifw,Saltafw,Umodifw,Vmodifw,Zadsfw,Valt" + ;
"afw,Descfw,Hmodifw,Haltafw,Bdaltafw,Horaimpo,Bdmodifw,Esttrans,Horaexpo,Timestamp,Anulado,Fecha,Codi" + ;
"go,Mobs,Fechabase,Numero,Fechavig" + ;
" from ZooLogic.MODPRE where  MODPRE.CODIGO != '' and " + lcFiltro )
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
			local  lxModpreFecexpo, lxModpreFectrans, lxModpreFecimpo, lxModpreFaltafw, lxModpreFmodifw, lxModpreUaltafw, lxModpreSmodifw, lxModpreSaltafw, lxModpreUmodifw, lxModpreVmodifw, lxModpreZadsfw, lxModpreValtafw, lxModpreDescfw, lxModpreHmodifw, lxModpreHaltafw, lxModpreBdaltafw, lxModpreHoraimpo, lxModpreBdmodifw, lxModpreEsttrans, lxModpreHoraexpo, lxModpreTimestamp, lxModpreAnulado, lxModpreFecha, lxModpreCodigo, lxModpreMobs, lxModpreFechabase, lxModpreNumero, lxModpreFechavig
				lxModpreFecexpo = ctod( '  /  /    ' )			lxModpreFectrans = ctod( '  /  /    ' )			lxModpreFecimpo = ctod( '  /  /    ' )			lxModpreFaltafw = ctod( '  /  /    ' )			lxModpreFmodifw = ctod( '  /  /    ' )			lxModpreUaltafw = []			lxModpreSmodifw = []			lxModpreSaltafw = []			lxModpreUmodifw = []			lxModpreVmodifw = []			lxModpreZadsfw = []			lxModpreValtafw = []			lxModpreDescfw = []			lxModpreHmodifw = []			lxModpreHaltafw = []			lxModpreBdaltafw = []			lxModpreHoraimpo = []			lxModpreBdmodifw = []			lxModpreEsttrans = []			lxModpreHoraexpo = []			lxModpreTimestamp = goLibrerias.ObtenerTimestamp()			lxModpreAnulado = .F.			lxModpreFecha = ctod( '  /  /    ' )			lxModpreCodigo = []			lxModpreMobs = []			lxModpreFechabase = ctod( '  /  /    ' )			lxModpreNumero = 0			lxModpreFechavig = ctod( '  /  /    ' )
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.MODIPRECDET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.MODPRE where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
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
			lcTabla = 'MODPRE' + '_' + tcCampo
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
		lcWhere = " Where  MODPRE.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Fecha" as "Fecha", "Codigo" as "Codigo", "Mobs" as "Observacion", "Fechabase" as "Fechabase", "Numero" as "Numero", "Fechavig" as "Fechavigencia"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MODPRE', '', tnTope )
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
	Function ObtenerDatosDetalleModPrecios( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  MODIPRECDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Codigo" as "Codigo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Equiv" as "Equivalencia", "Codart" as "Articulo", "Descart" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talle" as "Talle", "Talltxt" as "Talledetalle", "Codlispr" as "Listadeprecio", "Codprelis" as "Preciodelista", "Codpreact" as "Precioact", "Timestampa" as "Timestampalta"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleModPrecios( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MODIPRECDET', 'ModPrecios', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleModPrecios( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleModPrecios( lcAtributo )
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
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOBS AS OBSERVACION'
				Case lcAtributo == 'FECHABASE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHABASE AS FECHABASE'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'FECHAVIGENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAVIG AS FECHAVIGENCIA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleModPrecios( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'EQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIV AS EQUIVALENCIA'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODART AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCART AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLTXT AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLE AS TALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLTXT AS TALLEDETALLE'
				Case lcAtributo == 'LISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODLISPR AS LISTADEPRECIO'
				Case lcAtributo == 'PRECIODELISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODPRELIS AS PRECIODELISTA'
				Case lcAtributo == 'PRECIOACT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODPREACT AS PRECIOACT'
				Case lcAtributo == 'TIMESTAMPALTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMPA AS TIMESTAMPALTA'
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
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'MOBS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHABASE'
				lcCampo = 'FECHABASE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVIGENCIA'
				lcCampo = 'FECHAVIG'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleModPrecios( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIA'
				lcCampo = 'EQUIV'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'CODART'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'DESCART'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'COLTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'TALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'TALLTXT'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIO'
				lcCampo = 'CODLISPR'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIODELISTA'
				lcCampo = 'CODPRELIS'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOACT'
				lcCampo = 'CODPREACT'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMPALTA'
				lcCampo = 'TIMESTAMPA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'MODPRECIOS'
			lcRetorno = 'MODIPRECDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxModpreFecexpo, lxModpreFectrans, lxModpreFecimpo, lxModpreFaltafw, lxModpreFmodifw, lxModpreUaltafw, lxModpreSmodifw, lxModpreSaltafw, lxModpreUmodifw, lxModpreVmodifw, lxModpreZadsfw, lxModpreValtafw, lxModpreDescfw, lxModpreHmodifw, lxModpreHaltafw, lxModpreBdaltafw, lxModpreHoraimpo, lxModpreBdmodifw, lxModpreEsttrans, lxModpreHoraexpo, lxModpreTimestamp, lxModpreAnulado, lxModpreFecha, lxModpreCodigo, lxModpreMobs, lxModpreFechabase, lxModpreNumero, lxModpreFechavig
				lxModpreFecexpo =  .Fechaexpo			lxModpreFectrans =  .Fechatransferencia			lxModpreFecimpo =  .Fechaimpo			lxModpreFaltafw =  .Fechaaltafw			lxModpreFmodifw =  .Fechamodificacionfw			lxModpreUaltafw =  .Usuarioaltafw			lxModpreSmodifw =  .Seriemodificacionfw			lxModpreSaltafw =  .Seriealtafw			lxModpreUmodifw =  .Usuariomodificacionfw			lxModpreVmodifw =  .Versionmodificacionfw			lxModpreZadsfw =  .Zadsfw			lxModpreValtafw =  .Versionaltafw			lxModpreDescfw =  .Descripcionfw			lxModpreHmodifw =  .Horamodificacionfw			lxModpreHaltafw =  .Horaaltafw			lxModpreBdaltafw =  .Basededatosaltafw			lxModpreHoraimpo =  .Horaimpo			lxModpreBdmodifw =  .Basededatosmodificacionfw			lxModpreEsttrans =  .Estadotransferencia			lxModpreHoraexpo =  .Horaexpo			lxModpreTimestamp = goLibrerias.ObtenerTimestamp()			lxModpreAnulado =  .Anulado			lxModpreFecha =  .Fecha			lxModpreCodigo =  .Codigo			lxModpreMobs =  .Observacion			lxModpreFechabase =  .Fechabase			lxModpreNumero =  .Numero			lxModpreFechavig =  .Fechavigencia
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.MODPRE ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Ualtafw","Smodifw","Saltafw","Umodifw","Vmodifw","Zadsfw","Valtafw","Descfw","Hmodifw","Haltafw","Bdaltafw","Horaimpo","Bdmodifw","Esttrans","Horaexpo","Timestamp","Anulado","Fecha","Codigo","Mobs","Fechabase","Numero","Fechavig" ) values ( <<"'" + this.ConvertirDateSql( lxModpreFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModpreFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModpreFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModpreFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModpreFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreHoraexpo ) + "'" >>, <<lxModpreTimestamp >>, <<iif( lxModpreAnulado, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxModpreFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModpreMobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModpreFechabase ) + "'" >>, <<lxModpreNumero >>, <<"'" + this.ConvertirDateSql( lxModpreFechavig ) + "'" >> )
		endtext
		loColeccion.cTabla = 'MODPRE' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModPrecios
				if this.oEntidad.ModPrecios.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxListadeprecio_PK = loItem.Listadeprecio_PK
					lxPreciodelista = loItem.Preciodelista
					lxPrecioact = loItem.Precioact
					lxTimestampalta = loItem.Timestampalta
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODIPRECDET("CODIGO","COMP","NROITEM","Equiv","CodArt","DescArt","cColor","Coltxt","Talle","Talltxt","CodLisPr","CodPreLis","CodPreAct","TimestampA" ) values ( << lcValorClavePrimariaString >>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxListadeprecio_PK ) + "'">>, <<lxPreciodelista>>, <<lxPrecioact>>, <<lxTimestampalta>> ) 
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
			if .lAnular
				.oAtributosAnulacion = .CrearObjeto( 'zooColeccion' )
				.ObtenerAtributosAnulacion()
				.Limpiar()
				.CargarAtributosAnulacion()
			endif
			local  lxModpreFecexpo, lxModpreFectrans, lxModpreFecimpo, lxModpreFaltafw, lxModpreFmodifw, lxModpreUaltafw, lxModpreSmodifw, lxModpreSaltafw, lxModpreUmodifw, lxModpreVmodifw, lxModpreZadsfw, lxModpreValtafw, lxModpreDescfw, lxModpreHmodifw, lxModpreHaltafw, lxModpreBdaltafw, lxModpreHoraimpo, lxModpreBdmodifw, lxModpreEsttrans, lxModpreHoraexpo, lxModpreTimestamp, lxModpreAnulado, lxModpreFecha, lxModpreCodigo, lxModpreMobs, lxModpreFechabase, lxModpreNumero, lxModpreFechavig
				lxModpreFecexpo =  .Fechaexpo			lxModpreFectrans =  .Fechatransferencia			lxModpreFecimpo =  .Fechaimpo			lxModpreFaltafw =  .Fechaaltafw			lxModpreFmodifw =  .Fechamodificacionfw			lxModpreUaltafw =  .Usuarioaltafw			lxModpreSmodifw =  .Seriemodificacionfw			lxModpreSaltafw =  .Seriealtafw			lxModpreUmodifw =  .Usuariomodificacionfw			lxModpreVmodifw =  .Versionmodificacionfw			lxModpreZadsfw =  .Zadsfw			lxModpreValtafw =  .Versionaltafw			lxModpreDescfw =  .Descripcionfw			lxModpreHmodifw =  .Horamodificacionfw			lxModpreHaltafw =  .Horaaltafw			lxModpreBdaltafw =  .Basededatosaltafw			lxModpreHoraimpo =  .Horaimpo			lxModpreBdmodifw =  .Basededatosmodificacionfw			lxModpreEsttrans =  .Estadotransferencia			lxModpreHoraexpo =  .Horaexpo			lxModpreTimestamp = goLibrerias.ObtenerTimestamp()			lxModpreAnulado =  .Anulado			lxModpreFecha =  .Fecha			lxModpreCodigo =  .Codigo			lxModpreMobs =  .Observacion			lxModpreFechabase =  .Fechabase			lxModpreNumero =  .Numero			lxModpreFechavig =  .Fechavigencia
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MODPRE.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.MODPRE set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxModpreFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxModpreFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxModpreFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxModpreFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxModpreFmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxModpreUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxModpreSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxModpreSaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxModpreUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxModpreVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxModpreZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxModpreValtafw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxModpreDescfw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxModpreHmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxModpreHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxModpreBdaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxModpreHoraimpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxModpreBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxModpreEsttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxModpreHoraexpo ) + "'">>, "Timestamp" = <<lxModpreTimestamp>>, "Anulado" = <<iif( lxModpreAnulado, 1, 0 )>>, "Fecha" = <<"'" + this.ConvertirDateSql( lxModpreFecha ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxModpreCodigo ) + "'">>, "Mobs" = <<"'" + this.FormatearTextoSql( lxModpreMobs ) + "'">>, "Fechabase" = <<"'" + this.ConvertirDateSql( lxModpreFechabase ) + "'">>, "Numero" = <<lxModpreNumero>>, "Fechavig" = <<"'" + this.ConvertirDateSql( lxModpreFechavig ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'MODPRE' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.MODIPRECDET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModPrecios
				if this.oEntidad.ModPrecios.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxListadeprecio_PK = loItem.Listadeprecio_PK
					lxPreciodelista = loItem.Preciodelista
					lxPrecioact = loItem.Precioact
					lxTimestampalta = loItem.Timestampalta
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODIPRECDET("CODIGO","COMP","NROITEM","Equiv","CodArt","DescArt","cColor","Coltxt","Talle","Talltxt","CodLisPr","CodPreLis","CodPreAct","TimestampA" ) values ( << lcValorClavePrimariaString >>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxListadeprecio_PK ) + "'">>, <<lxPreciodelista>>, <<lxPrecioact>>, <<lxTimestampalta>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MODPRE.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.MODPRE where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.MODIPRECDET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'MODPRE' 
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerObjetoBusqueda() as Void
		return newobject( 'ObjetoBusqueda', '', '', this.oEntidad )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function GenerarSentenciasComponentes() as void
		local loColSentencias as ZooColeccion of zooColeccion.prg, lcItem as String
		dodefault()
		this.colSentencias.Remove( -1 )

		with this.oEntidad
			.ModPrecios.oItem.oCompPrecios.lNuevo = .EsNuevo()
			.ModPrecios.oItem.oCompPrecios.lEdicion = .EsEdicion()
			.ModPrecios.oItem.oCompPrecios.lEliminar = .lEliminar
			.ModPrecios.oItem.oCompPrecios.lAnular = .lAnular
			loColSentencias = .ModPrecios.oItem.oCompPrecios.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
		endwith
		
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerSentenciaActualizacionTimeStamp() As String
		local lnTimeStamp as integer, lcRetorno as string, lcUpdateRealTime as string
		with this.oEntidad
		
			lnTimeStamp = goLibrerias.ObtenerTimestamp()
			lcUpdateRealTime = ", "+this.obtenercampoentidad("fechamodificacionfw")+" = "+goServicios.Datos.ObtenerFechaFormateada(goServicios.Librerias.ObtenerFecha());
			+ ", "+this.obtenercampoentidad("horamodificacionfw")+" = '"+goServicios.Librerias.ObtenerHora()+"'"
			lcRetorno = [update ZooLogic.MODPRE set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  MODPRE.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.MODPRE where  MODPRE.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.MODPRE where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  MODPRE.CODIGO != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxMODPRENumero as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MODIFICACIONPRECIOS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.MODPRE Where  Numero = ] + transform( &lcCursor..Numero     ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..CODIGO
				if lxValorClavePK == curSeek.CODIGO or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.CODIGO and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.CODIGO
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						if this.oEntidad.cContexto == 'C'
							if curSeek.ANULADO
								Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.MODPRE set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, FECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, MObs = ] + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'"+ [, Fechabase = ] + "'" + this.ConvertirDateSql( &lcCursor..Fechabase ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, FECHAVIG = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAVIG ) + "'" + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
								this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica anulado ).', tlLoguear )
							else
								this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque ya existe y no esta anulado.', tlLoguear )
							endif
						else
							this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque ya existe.', tlLoguear )
						endif
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.MODPRE Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FECTRANS, FECIMPO, FALTAFW, FMODIFW, UALTAFW, SMODIFW, SALTAFW, UMODIFW, VMODIFW, ZADSFW, VALTAFW, DescFW, HMODIFW, HALTAFW, BDALTAFW, HORAIMPO, BDMODIFW, ESTTRANS, HORAEXPO, TIMESTAMP, Anulado, FECHA, CODIGO, MObs, Fechabase, Numero, FECHAVIG
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + transform( &lcCursor..TIMESTAMP )
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fechabase ) + "'" + ',' + transform( &lcCursor..Numero ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAVIG ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.MODPRE ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MODIFICACIONPRECIOS'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'CODIGO','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','CODIGO')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.MODIPRECDET Where CODIGO] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMMODIFICACIONPRECIOS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"CODIGO","COMP","NROITEM","Equiv","CodArt","DescArt","cColor","Coltxt","Talle","Talltxt","CodLisPr","CodPreLis","CodPreAct","TimestampA"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.MODIPRECDET ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodArt     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DescArt    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColor     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Coltxt     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Talle      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Talltxt    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodLisPr   ) + "'" + ',' + transform( cDetallesExistentes.CodPreLis  ) + ',' + transform( cDetallesExistentes.CodPreAct  ) + ',' + transform( cDetallesExistentes.TimestampA ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO C (20) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		this.oEntidad.ModPrecios.oItem.oCompPrecios.Recibir( this.oEntidad, 'ModPrecios',this.oEntidad.cPrefijoRecibir + 'ITEMMODIFICACIONPRECIOS',this.oEntidad.cPrefijoRecibir + 'MODIFICACIONPRECIOS')
		
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
			Case  lcAlias == lcPrefijo + 'MODIFICACIONPRECIOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MODIFICACIONPRECIOS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MODIFICACIONPRECIOS_MOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMMODIFICACIONPRECIOS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_MODPRE')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'MODIFICACIONPRECIOS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Numero )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad MODIFICACIONPRECIOS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MODIFICACIONPRECIOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( Numero, 8, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( Numero, 8, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MODIFICACIONPRECIOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECHA     
		* Validar ANTERIORES A 1/1/1753  Fechabase 
		* Validar ANTERIORES A 1/1/1753  FECHAVIG  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MODPRE') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MODPRE
Create Table ZooLogic.TablaTrabajo_MODPRE ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"descfw" char( 200 )  null, 
"hmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"anulado" bit  null, 
"fecha" datetime  null, 
"codigo" char( 20 )  null, 
"mobs" varchar(max)  null, 
"fechabase" datetime  null, 
"numero" numeric( 8, 0 )  null, 
"fechavig" datetime  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_MODPRE' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_MODPRE' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MODIFICACIONPRECIOS'
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
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('mobs','mobs')
			.AgregarMapeo('fechabase','fechabase')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('fechavig','fechavig')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_MODPRE'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.MOBS = isnull( d.MOBS, t.MOBS ),t.FECHABASE = isnull( d.FECHABASE, t.FECHABASE ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.FECHAVIG = isnull( d.FECHAVIG, t.FECHAVIG )
					from ZooLogic.MODPRE t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.Numero = d.Numero
				-- Fin Updates
				insert into ZooLogic.MODPRE(Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Ualtafw,Smodifw,Saltafw,Umodifw,Vmodifw,Zadsfw,Valtafw,Descfw,Hmodifw,Haltafw,Bdaltafw,Horaimpo,Bdmodifw,Esttrans,Horaexpo,Timestamp,Anulado,Fecha,Codigo,Mobs,Fechabase,Numero,Fechavig)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.DESCFW,''),isnull( d.HMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),isnull( d.TIMESTAMP,0),isnull( d.ANULADO,0),isnull( d.FECHA,''),isnull( d.CODIGO,''),isnull( d.MOBS,''),isnull( d.FECHABASE,''),isnull( d.NUMERO,0),isnull( d.FECHAVIG,'')
						From deleted d left join ZooLogic.MODPRE pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.MODPRE cc 
							 on  d.Numero = cc.Numero
						Where pk.CODIGO Is Null 
							 and cc.Numero Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.Numero as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.MODPRE t inner join deleted d 
							on   t.Numero = d.Numero
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.Numero as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.MODPRE t inner join deleted d 
							 on t.CODIGO = d.CODIGO
						left join deleted h 
							on   t.Numero = h.Numero
							where   h.Numero is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_MODIPRECDET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_MODPRE_MODIPRECDET
ON ZooLogic.TablaTrabajo_MODPRE_MODIPRECDET
AFTER DELETE
As
Begin
Update t Set 
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.CODART = isnull( d.CODART, t.CODART ),
t.DESCART = isnull( d.DESCART, t.DESCART ),
t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),
t.COLTXT = isnull( d.COLTXT, t.COLTXT ),
t.TALLE = isnull( d.TALLE, t.TALLE ),
t.TALLTXT = isnull( d.TALLTXT, t.TALLTXT ),
t.CODLISPR = isnull( d.CODLISPR, t.CODLISPR ),
t.CODPRELIS = isnull( d.CODPRELIS, t.CODPRELIS ),
t.CODPREACT = isnull( d.CODPREACT, t.CODPREACT ),
t.TIMESTAMPA = isnull( d.TIMESTAMPA, t.TIMESTAMPA )
from ZooLogic.MODIPRECDET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.MODIPRECDET
( 
"CODIGO",
"COMP",
"NROITEM",
"EQUIV",
"CODART",
"DESCART",
"CCOLOR",
"COLTXT",
"TALLE",
"TALLTXT",
"CODLISPR",
"CODPRELIS",
"CODPREACT",
"TIMESTAMPA"
 )
Select 
d.CODIGO,
d.COMP,
d.NROITEM,
d.EQUIV,
d.CODART,
d.DESCART,
d.CCOLOR,
d.COLTXT,
d.TALLE,
d.TALLTXT,
d.CODLISPR,
d.CODPRELIS,
d.CODPREACT,
d.TIMESTAMPA
From deleted d left join ZooLogic.MODIPRECDET pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MODPRE') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MODPRE
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_MODIFICACIONPRECIOS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONPRECIOS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONPRECIOS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONPRECIOS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONPRECIOS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONPRECIOS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Usuarioaltafw = nvl( c_MODIFICACIONPRECIOS.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_MODIFICACIONPRECIOS.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_MODIFICACIONPRECIOS.Seriealtafw, [] )
					.Usuariomodificacionfw = nvl( c_MODIFICACIONPRECIOS.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_MODIFICACIONPRECIOS.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_MODIFICACIONPRECIOS.Versionaltafw, [] )
					.Descripcionfw = nvl( c_MODIFICACIONPRECIOS.Descripcionfw, [] )
					.Horamodificacionfw = nvl( c_MODIFICACIONPRECIOS.Horamodificacionfw, [] )
					.Horaaltafw = nvl( c_MODIFICACIONPRECIOS.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_MODIFICACIONPRECIOS.Basededatosaltafw, [] )
					.Horaimpo = nvl( c_MODIFICACIONPRECIOS.Horaimpo, [] )
					.Basededatosmodificacionfw = nvl( c_MODIFICACIONPRECIOS.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_MODIFICACIONPRECIOS.Estadotransferencia, [] )
					.Horaexpo = nvl( c_MODIFICACIONPRECIOS.Horaexpo, [] )
					.Timestamp = nvl( c_MODIFICACIONPRECIOS.Timestamp, 0 )
					.Anulado = nvl( c_MODIFICACIONPRECIOS.Anulado, .F. )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONPRECIOS.Fecha, ctod( '  /  /    ' ) ) )
					.Modprecios.Limpiar()
					.Modprecios.SetearEsNavegacion( .lProcesando )
					.Modprecios.Cargar()
					.Codigo = nvl( c_MODIFICACIONPRECIOS.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Fechabase = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONPRECIOS.Fechabase, ctod( '  /  /    ' ) ) )
					.Numero = nvl( c_MODIFICACIONPRECIOS.Numero, 0 )
					.Fechavigencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONPRECIOS.Fechavigencia, ctod( '  /  /    ' ) ) )
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
			lxRetorno = c_MODIFICACIONPRECIOS.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.ModPrecios
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
		return c_MODIFICACIONPRECIOS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.MODPRE' )
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
								from ZooLogic.MODPRE 
								Where   MODPRE.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "MODPRE", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Fecha" as "Fecha", "Codigo" as "Codigo", "Mobs" as "Observacion", "Fechabase" as "Fechabase", "Numero" as "Numero", "Fechavig" as "Fechavigencia"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.MODPRE 
								Where   MODPRE.CODIGO != ''
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
	Tabla = 'MODPRE'
	Filtro = " MODPRE.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " MODPRE.CODIGO != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = "MODPRE.Numero"
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
	<row entidad="MODIFICACIONPRECIOS                     " atributo="FECHAEXPO                               " tabla="MODPRE         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="FECHATRANSFERENCIA                      " tabla="MODPRE         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="FECHAIMPO                               " tabla="MODPRE         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="FECHAALTAFW                             " tabla="MODPRE         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="FECHAMODIFICACIONFW                     " tabla="MODPRE         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="USUARIOALTAFW                           " tabla="MODPRE         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="SERIEMODIFICACIONFW                     " tabla="MODPRE         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="SERIEALTAFW                             " tabla="MODPRE         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="USUARIOMODIFICACIONFW                   " tabla="MODPRE         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="VERSIONMODIFICACIONFW                   " tabla="MODPRE         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="ZADSFW                                  " tabla="MODPRE         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="VERSIONALTAFW                           " tabla="MODPRE         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="DESCRIPCIONFW                           " tabla="MODPRE         " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="HORAMODIFICACIONFW                      " tabla="MODPRE         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="HORAALTAFW                              " tabla="MODPRE         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="BASEDEDATOSALTAFW                       " tabla="MODPRE         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="HORAIMPO                                " tabla="MODPRE         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="MODPRE         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="ESTADOTRANSFERENCIA                     " tabla="MODPRE         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="HORAEXPO                                " tabla="MODPRE         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="TIMESTAMP                               " tabla="MODPRE         " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="ANULADO                                 " tabla="MODPRE         " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Anulado                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="FECHA                                   " tabla="MODPRE         " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="200" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="MODPRECIOS                              " tabla="MODIPRECDET    " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="Precios de artículos                                                                                                                                            " dominio="DETALLEITEMMODIFICACIONPRECIOS" detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="CODIGO                                  " tabla="MODPRE         " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="99" etiqueta="Identificador                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="OBSERVACION                             " tabla="MODPRE         " campo="MOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="FECHABASE                               " tabla="MODPRE         " campo="FECHABASE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="203" etiqueta="Fecha base de precios                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="NUMERO                                  " tabla="MODPRE         " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CLAVEDEBUSQUEDA               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONPRECIOS                     " atributo="FECHAVIGENCIA                           " tabla="MODPRE         " campo="FECHAVIG  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha() +1                                                                                                                                                                                                                      " obligatorio="true" admitebusqueda="204" etiqueta="Vigencia desde                                                                                                                                                  " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
</VFPData>

			Endtext

			text to .cEstructuraDetalle noshow 
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
	<row entidad="ITEMMODIFICACIONPRECIOS                 " atributo="ARTICULO                                " tabla="MODIPRECDET    " campo="CODART    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="201" etiqueta="DetallePreciosDeArtículos, Artículo                                                                                                                             " dominio="CLAVECONLECTURACB             " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODIPRECDET On MODPRE.CODIGO = MODIPRECDET.CODIGO And  MODPRE.CODIGO != ''                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODIFICACIONPRECIOS                 " atributo="ARTICULODETALLE                         " tabla="MODIPRECDET    " campo="DESCART   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="DetallePreciosDeArtículos, Artículo descripción                                                                                                                 " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="articulo.descripcion                                                                                                                                                                                                                                          " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODIPRECDET On MODPRE.CODIGO = MODIPRECDET.CODIGO And  MODPRE.CODIGO != ''                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODIFICACIONPRECIOS                 " atributo="COLOR                                   " tabla="MODIPRECDET    " campo="CCOLOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="DetallePreciosDeArtículos, Color                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODIPRECDET On MODPRE.CODIGO = MODIPRECDET.CODIGO And  MODPRE.CODIGO != ''                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODIFICACIONPRECIOS                 " atributo="COLORDETALLE                            " tabla="MODIPRECDET    " campo="COLTXT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="DetallePreciosDeArtículos, Color descripción                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Color.Descripcion                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODIPRECDET On MODPRE.CODIGO = MODIPRECDET.CODIGO And  MODPRE.CODIGO != ''                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODIFICACIONPRECIOS                 " atributo="TALLE                                   " tabla="MODIPRECDET    " campo="TALLE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="DetallePreciosDeArtículos, Talle                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODIPRECDET On MODPRE.CODIGO = MODIPRECDET.CODIGO And  MODPRE.CODIGO != ''                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODIFICACIONPRECIOS                 " atributo="LISTADEPRECIO                           " tabla="MODIPRECDET    " campo="CODLISPR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="DetallePreciosDeArtículos, L. precio                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODIPRECDET On MODPRE.CODIGO = MODIPRECDET.CODIGO And  MODPRE.CODIGO != ''                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODIFICACIONPRECIOS                 " atributo="PRECIODELISTA                           " tabla="MODIPRECDET    " campo="CODPRELIS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="207" etiqueta="DetallePreciosDeArtículos, P. vigente                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODIPRECDET On MODPRE.CODIGO = MODIPRECDET.CODIGO And  MODPRE.CODIGO != ''                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODIFICACIONPRECIOS                 " atributo="PRECIOACT                               " tabla="MODIPRECDET    " campo="CODPREACT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="208" etiqueta="DetallePreciosDeArtículos, P. nuevo                                                                                                                             " dominio="PRECIONONEGATIVO              " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODIPRECDET On MODPRE.CODIGO = MODIPRECDET.CODIGO And  MODPRE.CODIGO != ''                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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