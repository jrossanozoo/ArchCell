
define class Din_EntidadADT_PRECIODEARTICULOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ADT_PRECIODEARTICULO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_AUD018PK'
	cTablaPrincipal = 'ADT_PRECIOAR'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
				.cUbicacionDB = 'SUCURSAL'
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
			local  lxAdt_precioarFectrans, lxAdt_precioarFaltafw, lxAdt_precioarFmodifw, lxAdt_precioarFecimpo, lxAdt_precioarAdt_fecha, lxAdt_precioarFecexpo, lxAdt_precioarFechavig, lxAdt_precioarTimestampa, lxAdt_precioarPdirori, lxAdt_precioarCodori, lxAdt_precioarPdirecto, lxAdt_precioarAdt_ext, lxAdt_precioarHoraimpo, lxAdt_precioarHaltafw, lxAdt_precioarValtafw, lxAdt_precioarZadsfw, lxAdt_precioarVmodifw, lxAdt_precioarUmodifw, lxAdt_precioarUaltafw, lxAdt_precioarHmodifw, lxAdt_precioarSmodifw, lxAdt_precioarSaltafw, lxAdt_precioarHoraexpo, lxAdt_precioarEntori, lxAdt_precioarAdt_ent, lxAdt_precioarEsttrans, lxAdt_precioarAdt_vers, lxAdt_precioarAdt_usr, lxAdt_precioarAdt_adn, lxAdt_precioarTalle, lxAdt_precioarBdaltafw, lxAdt_precioarBdmodifw, lxAdt_precioarAdt_hora, lxAdt_precioarAdt_comp, lxAdt_precioarAdt_serie, lxAdt_precioarColores, lxAdt_precioarAdt_cod, lxAdt_precioarListapre, lxAdt_precioarCodigo, lxAdt_precioarArticulo
				lxAdt_precioarFectrans =  .Fechatransferencia			lxAdt_precioarFaltafw =  .Fechaaltafw			lxAdt_precioarFmodifw =  .Fechamodificacionfw			lxAdt_precioarFecimpo =  .Fechaimpo			lxAdt_precioarAdt_fecha =  .Adt_fecha			lxAdt_precioarFecexpo =  .Fechaexpo			lxAdt_precioarFechavig =  .Fechavigencia			lxAdt_precioarTimestampa =  .Timestampalta			lxAdt_precioarPdirori =  .Preciodirectooriginal			lxAdt_precioarCodori =  .Codigoorigen			lxAdt_precioarPdirecto =  .Preciodirecto			lxAdt_precioarAdt_ext =  .Adt_ext			lxAdt_precioarHoraimpo =  .Horaimpo			lxAdt_precioarHaltafw =  .Horaaltafw			lxAdt_precioarValtafw =  .Versionaltafw			lxAdt_precioarZadsfw =  .Zadsfw			lxAdt_precioarVmodifw =  .Versionmodificacionfw			lxAdt_precioarUmodifw =  .Usuariomodificacionfw			lxAdt_precioarUaltafw =  .Usuarioaltafw			lxAdt_precioarHmodifw =  .Horamodificacionfw			lxAdt_precioarSmodifw =  .Seriemodificacionfw			lxAdt_precioarSaltafw =  .Seriealtafw			lxAdt_precioarHoraexpo =  .Horaexpo			lxAdt_precioarEntori =  .Entidadorigen			lxAdt_precioarAdt_ent =  .Adt_ent			lxAdt_precioarEsttrans =  .Estadotransferencia			lxAdt_precioarAdt_vers =  .Adt_vers			lxAdt_precioarAdt_usr =  .Adt_usr			lxAdt_precioarAdt_adn =  .Adt_adn			lxAdt_precioarTalle =  .Talle			lxAdt_precioarBdaltafw =  .Basededatosaltafw			lxAdt_precioarBdmodifw =  .Basededatosmodificacionfw			lxAdt_precioarAdt_hora =  .Adt_hora			lxAdt_precioarAdt_comp =  .Adt_comp			lxAdt_precioarAdt_serie =  .Adt_serie			lxAdt_precioarColores =  upper( .Color_PK ) 			lxAdt_precioarAdt_cod =  .Adt_cod			lxAdt_precioarListapre =  upper( .ListaDePrecio_PK ) 			lxAdt_precioarCodigo =  upper( .Codigo_PK ) 			lxAdt_precioarArticulo =  upper( .Articulo_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxAdt_precioarAdt_cod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_PRECIOAR ( "Fectrans","Faltafw","Fmodifw","Fecimpo","Adt_fecha","Fecexpo","Fechavig","Timestampa","Pdirori","Codori","Pdirecto","Adt_ext","Horaimpo","Haltafw","Valtafw","Zadsfw","Vmodifw","Umodifw","Ualtafw","Hmodifw","Smodifw","Saltafw","Horaexpo","Entori","Adt_ent","Esttrans","Adt_vers","Adt_usr","Adt_adn","Talle","Bdaltafw","Bdmodifw","Adt_hora","Adt_comp","Adt_serie","Colores","Adt_cod","Listapre","Codigo","Articulo" ) values ( <<"'" + this.ConvertirDateSql( lxAdt_precioarFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_precioarFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_precioarFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_precioarFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_precioarAdt_fecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_precioarFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_precioarFechavig ) + "'" >>, <<lxAdt_precioarTimestampa >>, <<lxAdt_precioarPdirori >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarCodori ) + "'" >>, <<lxAdt_precioarPdirecto >>, <<iif( lxAdt_precioarAdt_ext, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarEntori ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_ent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_vers ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_usr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_adn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarTalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_hora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_comp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_serie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarColores ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_cod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarListapre ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarArticulo ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ADT_COD
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
		return this.oEntidad.ADT_COD
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxAdt_precioarFectrans, lxAdt_precioarFaltafw, lxAdt_precioarFmodifw, lxAdt_precioarFecimpo, lxAdt_precioarAdt_fecha, lxAdt_precioarFecexpo, lxAdt_precioarFechavig, lxAdt_precioarTimestampa, lxAdt_precioarPdirori, lxAdt_precioarCodori, lxAdt_precioarPdirecto, lxAdt_precioarAdt_ext, lxAdt_precioarHoraimpo, lxAdt_precioarHaltafw, lxAdt_precioarValtafw, lxAdt_precioarZadsfw, lxAdt_precioarVmodifw, lxAdt_precioarUmodifw, lxAdt_precioarUaltafw, lxAdt_precioarHmodifw, lxAdt_precioarSmodifw, lxAdt_precioarSaltafw, lxAdt_precioarHoraexpo, lxAdt_precioarEntori, lxAdt_precioarAdt_ent, lxAdt_precioarEsttrans, lxAdt_precioarAdt_vers, lxAdt_precioarAdt_usr, lxAdt_precioarAdt_adn, lxAdt_precioarTalle, lxAdt_precioarBdaltafw, lxAdt_precioarBdmodifw, lxAdt_precioarAdt_hora, lxAdt_precioarAdt_comp, lxAdt_precioarAdt_serie, lxAdt_precioarColores, lxAdt_precioarAdt_cod, lxAdt_precioarListapre, lxAdt_precioarCodigo, lxAdt_precioarArticulo
				lxAdt_precioarFectrans =  .Fechatransferencia			lxAdt_precioarFaltafw =  .Fechaaltafw			lxAdt_precioarFmodifw =  .Fechamodificacionfw			lxAdt_precioarFecimpo =  .Fechaimpo			lxAdt_precioarAdt_fecha =  .Adt_fecha			lxAdt_precioarFecexpo =  .Fechaexpo			lxAdt_precioarFechavig =  .Fechavigencia			lxAdt_precioarTimestampa =  .Timestampalta			lxAdt_precioarPdirori =  .Preciodirectooriginal			lxAdt_precioarCodori =  .Codigoorigen			lxAdt_precioarPdirecto =  .Preciodirecto			lxAdt_precioarAdt_ext =  .Adt_ext			lxAdt_precioarHoraimpo =  .Horaimpo			lxAdt_precioarHaltafw =  .Horaaltafw			lxAdt_precioarValtafw =  .Versionaltafw			lxAdt_precioarZadsfw =  .Zadsfw			lxAdt_precioarVmodifw =  .Versionmodificacionfw			lxAdt_precioarUmodifw =  .Usuariomodificacionfw			lxAdt_precioarUaltafw =  .Usuarioaltafw			lxAdt_precioarHmodifw =  .Horamodificacionfw			lxAdt_precioarSmodifw =  .Seriemodificacionfw			lxAdt_precioarSaltafw =  .Seriealtafw			lxAdt_precioarHoraexpo =  .Horaexpo			lxAdt_precioarEntori =  .Entidadorigen			lxAdt_precioarAdt_ent =  .Adt_ent			lxAdt_precioarEsttrans =  .Estadotransferencia			lxAdt_precioarAdt_vers =  .Adt_vers			lxAdt_precioarAdt_usr =  .Adt_usr			lxAdt_precioarAdt_adn =  .Adt_adn			lxAdt_precioarTalle =  .Talle			lxAdt_precioarBdaltafw =  .Basededatosaltafw			lxAdt_precioarBdmodifw =  .Basededatosmodificacionfw			lxAdt_precioarAdt_hora =  .Adt_hora			lxAdt_precioarAdt_comp =  .Adt_comp			lxAdt_precioarAdt_serie =  .Adt_serie			lxAdt_precioarColores =  upper( .Color_PK ) 			lxAdt_precioarAdt_cod =  .Adt_cod			lxAdt_precioarListapre =  upper( .ListaDePrecio_PK ) 			lxAdt_precioarCodigo =  upper( .Codigo_PK ) 			lxAdt_precioarArticulo =  upper( .Articulo_PK ) 
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.ADT_COD
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ADT_PRECIOAR set "Fectrans" = <<"'" + this.ConvertirDateSql( lxAdt_precioarFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxAdt_precioarFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxAdt_precioarFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxAdt_precioarFecimpo ) + "'">>,"Adt_fecha" = <<"'" + this.ConvertirDateSql( lxAdt_precioarAdt_fecha ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxAdt_precioarFecexpo ) + "'">>,"Fechavig" = <<"'" + this.ConvertirDateSql( lxAdt_precioarFechavig ) + "'">>,"Timestampa" = <<lxAdt_precioarTimestampa>>,"Pdirori" = <<lxAdt_precioarPdirori>>,"Codori" = <<"'" + this.FormatearTextoSql( lxAdt_precioarCodori ) + "'">>,"Pdirecto" = <<lxAdt_precioarPdirecto>>,"Adt_ext" = <<iif( lxAdt_precioarAdt_ext, 1, 0 )>>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxAdt_precioarHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarHaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarSaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxAdt_precioarHoraexpo ) + "'">>,"Entori" = <<"'" + this.FormatearTextoSql( lxAdt_precioarEntori ) + "'">>,"Adt_ent" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_ent ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxAdt_precioarEsttrans ) + "'">>,"Adt_vers" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_vers ) + "'">>,"Adt_usr" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_usr ) + "'">>,"Adt_adn" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_adn ) + "'">>,"Talle" = <<"'" + this.FormatearTextoSql( lxAdt_precioarTalle ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarBdmodifw ) + "'">>,"Adt_hora" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_hora ) + "'">>,"Adt_comp" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_comp ) + "'">>,"Adt_serie" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_serie ) + "'">>,"Colores" = <<"'" + this.FormatearTextoSql( lxAdt_precioarColores ) + "'">>,"Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_cod ) + "'">>,"Listapre" = <<"'" + this.FormatearTextoSql( lxAdt_precioarListapre ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxAdt_precioarCodigo ) + "'">>,"Articulo" = <<"'" + this.FormatearTextoSql( lxAdt_precioarArticulo ) + "'">> where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_cod ) + "'">> and  ADT_PRECIOAR.ADT_COD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 ADT_Cod from ZooLogic.ADT_PRECIOAR where " + this.ConvertirFuncionesSql( " ADT_PRECIOAR.ADT_COD != ''" ) )
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
			Local lxAdt_precioarAdt_cod
			lxAdt_precioarAdt_cod = .Adt_cod

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Fecexpo" as "Fechaexpo", "Fechavig" as "Fechavigencia", "Timestampa" as "Timestampalta", "Pdirori" as "Preciodirectooriginal", "Codori" as "Codigoorigen", "Pdirecto" as "Preciodirecto", "Adt_ext" as "Adt_ext", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Entori" as "Entidadorigen", "Adt_ent" as "Adt_ent", "Esttrans" as "Estadotransferencia", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Talle" as "Talle", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Adt_comp" as "Adt_comp", "Adt_serie" as "Adt_serie", "Colores" as "Color", "Adt_cod" as "Adt_cod", "Listapre" as "Listadeprecio", "Codigo" as "Codigo", "Articulo" as "Articulo" from ZooLogic.ADT_PRECIOAR where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_cod ) + "'">> and  ADT_PRECIOAR.ADT_COD != ''
			endtext
			use in select('c_ADT_PRECIODEARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_PRECIODEARTICULO', set( 'Datasession' ) )

			if reccount( 'c_ADT_PRECIODEARTICULO' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxAdt_precioarAdt_cod as Variant
		llRetorno = .t.
		lxAdt_precioarAdt_cod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ADT_PRECIOAR where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_cod ) + "'">> and  ADT_PRECIOAR.ADT_COD != ''
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
				lcOrden =   iif( empty( .FECHAALTAFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FECHAALTAFW ) ) + .HORAALTAFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Fecexpo" as "Fechaexpo", "Fechavig" as "Fechavigencia", "Timestampa" as "Timestampalta", "Pdirori" as "Preciodirectooriginal", "Codori" as "Codigoorigen", "Pdirecto" as "Preciodirecto", "Adt_ext" as "Adt_ext", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Entori" as "Entidadorigen", "Adt_ent" as "Adt_ent", "Esttrans" as "Estadotransferencia", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Talle" as "Talle", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Adt_comp" as "Adt_comp", "Adt_serie" as "Adt_serie", "Colores" as "Color", "Adt_cod" as "Adt_cod", "Listapre" as "Listadeprecio", "Codigo" as "Codigo", "Articulo" as "Articulo" from ZooLogic.ADT_PRECIOAR where  ADT_PRECIOAR.ADT_COD != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_ADT_PRECIODEARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_PRECIODEARTICULO', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .FECHAALTAFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FECHAALTAFW ) ) + .HORAALTAFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Fecexpo" as "Fechaexpo", "Fechavig" as "Fechavigencia", "Timestampa" as "Timestampalta", "Pdirori" as "Preciodirectooriginal", "Codori" as "Codigoorigen", "Pdirecto" as "Preciodirecto", "Adt_ext" as "Adt_ext", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Entori" as "Entidadorigen", "Adt_ent" as "Adt_ent", "Esttrans" as "Estadotransferencia", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Talle" as "Talle", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Adt_comp" as "Adt_comp", "Adt_serie" as "Adt_serie", "Colores" as "Color", "Adt_cod" as "Adt_cod", "Listapre" as "Listadeprecio", "Codigo" as "Codigo", "Articulo" as "Articulo" from ZooLogic.ADT_PRECIOAR where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ADT_PRECIOAR.ADT_COD != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_ADT_PRECIODEARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_PRECIODEARTICULO', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .FECHAALTAFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FECHAALTAFW ) ) + .HORAALTAFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Fecexpo" as "Fechaexpo", "Fechavig" as "Fechavigencia", "Timestampa" as "Timestampalta", "Pdirori" as "Preciodirectooriginal", "Codori" as "Codigoorigen", "Pdirecto" as "Preciodirecto", "Adt_ext" as "Adt_ext", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Entori" as "Entidadorigen", "Adt_ent" as "Adt_ent", "Esttrans" as "Estadotransferencia", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Talle" as "Talle", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Adt_comp" as "Adt_comp", "Adt_serie" as "Adt_serie", "Colores" as "Color", "Adt_cod" as "Adt_cod", "Listapre" as "Listadeprecio", "Codigo" as "Codigo", "Articulo" as "Articulo" from ZooLogic.ADT_PRECIOAR where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ADT_PRECIOAR.ADT_COD != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_ADT_PRECIODEARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_PRECIODEARTICULO', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .FECHAALTAFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FECHAALTAFW ) ) + .HORAALTAFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Fecexpo" as "Fechaexpo", "Fechavig" as "Fechavigencia", "Timestampa" as "Timestampalta", "Pdirori" as "Preciodirectooriginal", "Codori" as "Codigoorigen", "Pdirecto" as "Preciodirecto", "Adt_ext" as "Adt_ext", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Entori" as "Entidadorigen", "Adt_ent" as "Adt_ent", "Esttrans" as "Estadotransferencia", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Talle" as "Talle", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Adt_comp" as "Adt_comp", "Adt_serie" as "Adt_serie", "Colores" as "Color", "Adt_cod" as "Adt_cod", "Listapre" as "Listadeprecio", "Codigo" as "Codigo", "Articulo" as "Articulo" from ZooLogic.ADT_PRECIOAR where  ADT_PRECIOAR.ADT_COD != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_ADT_PRECIODEARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_PRECIODEARTICULO', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + "'" + this.FormatearTextoSql( .oEntidad.ADT_COD ) + "'"
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Faltafw,Fmodifw,Fecimpo,Adt_fecha,Fecexpo,Fechavig,Timestampa,Pdirori,Codori,Pdirec" + ;
"to,Adt_ext,Horaimpo,Haltafw,Valtafw,Zadsfw,Vmodifw,Umodifw,Ualtafw,Hmodifw,Smodifw,Saltafw,Horaexpo," + ;
"Entori,Adt_ent,Esttrans,Adt_vers,Adt_usr,Adt_adn,Talle,Bdaltafw,Bdmodifw,Adt_hora,Adt_comp,Adt_serie" + ;
",Colores,Adt_cod,Listapre,Codigo,Articulo" + ;
" from ZooLogic.ADT_PRECIOAR where  ADT_PRECIOAR.ADT_COD != '' and " + lcFiltro )
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
			local  lxAdt_precioarFectrans, lxAdt_precioarFaltafw, lxAdt_precioarFmodifw, lxAdt_precioarFecimpo, lxAdt_precioarAdt_fecha, lxAdt_precioarFecexpo, lxAdt_precioarFechavig, lxAdt_precioarTimestampa, lxAdt_precioarPdirori, lxAdt_precioarCodori, lxAdt_precioarPdirecto, lxAdt_precioarAdt_ext, lxAdt_precioarHoraimpo, lxAdt_precioarHaltafw, lxAdt_precioarValtafw, lxAdt_precioarZadsfw, lxAdt_precioarVmodifw, lxAdt_precioarUmodifw, lxAdt_precioarUaltafw, lxAdt_precioarHmodifw, lxAdt_precioarSmodifw, lxAdt_precioarSaltafw, lxAdt_precioarHoraexpo, lxAdt_precioarEntori, lxAdt_precioarAdt_ent, lxAdt_precioarEsttrans, lxAdt_precioarAdt_vers, lxAdt_precioarAdt_usr, lxAdt_precioarAdt_adn, lxAdt_precioarTalle, lxAdt_precioarBdaltafw, lxAdt_precioarBdmodifw, lxAdt_precioarAdt_hora, lxAdt_precioarAdt_comp, lxAdt_precioarAdt_serie, lxAdt_precioarColores, lxAdt_precioarAdt_cod, lxAdt_precioarListapre, lxAdt_precioarCodigo, lxAdt_precioarArticulo
				lxAdt_precioarFectrans = ctod( '  /  /    ' )			lxAdt_precioarFaltafw = ctod( '  /  /    ' )			lxAdt_precioarFmodifw = ctod( '  /  /    ' )			lxAdt_precioarFecimpo = ctod( '  /  /    ' )			lxAdt_precioarAdt_fecha = ctod( '  /  /    ' )			lxAdt_precioarFecexpo = ctod( '  /  /    ' )			lxAdt_precioarFechavig = ctod( '  /  /    ' )			lxAdt_precioarTimestampa = 0			lxAdt_precioarPdirori = 0			lxAdt_precioarCodori = []			lxAdt_precioarPdirecto = 0			lxAdt_precioarAdt_ext = .F.			lxAdt_precioarHoraimpo = []			lxAdt_precioarHaltafw = []			lxAdt_precioarValtafw = []			lxAdt_precioarZadsfw = []			lxAdt_precioarVmodifw = []			lxAdt_precioarUmodifw = []			lxAdt_precioarUaltafw = []			lxAdt_precioarHmodifw = []			lxAdt_precioarSmodifw = []			lxAdt_precioarSaltafw = []			lxAdt_precioarHoraexpo = []			lxAdt_precioarEntori = []			lxAdt_precioarAdt_ent = []			lxAdt_precioarEsttrans = []			lxAdt_precioarAdt_vers = []			lxAdt_precioarAdt_usr = []			lxAdt_precioarAdt_adn = []			lxAdt_precioarTalle = []			lxAdt_precioarBdaltafw = []			lxAdt_precioarBdmodifw = []			lxAdt_precioarAdt_hora = []			lxAdt_precioarAdt_comp = []			lxAdt_precioarAdt_serie = []			lxAdt_precioarColores = []			lxAdt_precioarAdt_cod = []			lxAdt_precioarListapre = []			lxAdt_precioarCodigo = []			lxAdt_precioarArticulo = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ADT_PRECIOAR where "ADT_Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.ADT_COD ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'ADT_PRECIOAR' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where ADT_Cod = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(ADT_Cod, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ADT_PRECIOAR.ADT_COD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Fecexpo" as "Fechaexpo", "Fechavig" as "Fechavigencia", "Timestampa" as "Timestampalta", "Pdirori" as "Preciodirectooriginal", "Codori" as "Codigoorigen", "Pdirecto" as "Preciodirecto", "Adt_ext" as "Adt_ext", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Entori" as "Entidadorigen", "Adt_ent" as "Adt_ent", "Esttrans" as "Estadotransferencia", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Talle" as "Talle", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Adt_comp" as "Adt_comp", "Adt_serie" as "Adt_serie", "Colores" as "Color", "Adt_cod" as "Adt_cod", "Listapre" as "Listadeprecio", "Codigo" as "Codigo", "Articulo" as "Articulo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ADT_PRECIOAR', '', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'ADT_FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_FECHA AS ADT_FECHA'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAVIGENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAVIG AS FECHAVIGENCIA'
				Case lcAtributo == 'TIMESTAMPALTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMPA AS TIMESTAMPALTA'
				Case lcAtributo == 'PRECIODIRECTOORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PDIRORI AS PRECIODIRECTOORIGINAL'
				Case lcAtributo == 'CODIGOORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODORI AS CODIGOORIGEN'
				Case lcAtributo == 'PRECIODIRECTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PDIRECTO AS PRECIODIRECTO'
				Case lcAtributo == 'ADT_EXT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_EXT AS ADT_EXT'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'ENTIDADORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTORI AS ENTIDADORIGEN'
				Case lcAtributo == 'ADT_ENT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_ENT AS ADT_ENT'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'ADT_VERS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_VERS AS ADT_VERS'
				Case lcAtributo == 'ADT_USR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_USR AS ADT_USR'
				Case lcAtributo == 'ADT_ADN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_ADN AS ADT_ADN'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLE AS TALLE'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ADT_HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_HORA AS ADT_HORA'
				Case lcAtributo == 'ADT_COMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_COMP AS ADT_COMP'
				Case lcAtributo == 'ADT_SERIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_SERIE AS ADT_SERIE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLORES AS COLOR'
				Case lcAtributo == 'ADT_COD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_COD AS ADT_COD'
				Case lcAtributo == 'LISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LISTAPRE AS LISTADEPRECIO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTICULO AS ARTICULO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_FECHA'
				lcCampo = 'ADT_FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVIGENCIA'
				lcCampo = 'FECHAVIG'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMPALTA'
				lcCampo = 'TIMESTAMPA'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIODIRECTOORIGINAL'
				lcCampo = 'PDIRORI'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOORIGEN'
				lcCampo = 'CODORI'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIODIRECTO'
				lcCampo = 'PDIRECTO'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_EXT'
				lcCampo = 'ADT_EXT'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDADORIGEN'
				lcCampo = 'ENTORI'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_ENT'
				lcCampo = 'ADT_ENT'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_VERS'
				lcCampo = 'ADT_VERS'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_USR'
				lcCampo = 'ADT_USR'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_ADN'
				lcCampo = 'ADT_ADN'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'TALLE'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_HORA'
				lcCampo = 'ADT_HORA'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_COMP'
				lcCampo = 'ADT_COMP'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_SERIE'
				lcCampo = 'ADT_SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'COLORES'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_COD'
				lcCampo = 'ADT_COD'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIO'
				lcCampo = 'LISTAPRE'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'ARTICULO'
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
			local  lxAdt_precioarFectrans, lxAdt_precioarFaltafw, lxAdt_precioarFmodifw, lxAdt_precioarFecimpo, lxAdt_precioarAdt_fecha, lxAdt_precioarFecexpo, lxAdt_precioarFechavig, lxAdt_precioarTimestampa, lxAdt_precioarPdirori, lxAdt_precioarCodori, lxAdt_precioarPdirecto, lxAdt_precioarAdt_ext, lxAdt_precioarHoraimpo, lxAdt_precioarHaltafw, lxAdt_precioarValtafw, lxAdt_precioarZadsfw, lxAdt_precioarVmodifw, lxAdt_precioarUmodifw, lxAdt_precioarUaltafw, lxAdt_precioarHmodifw, lxAdt_precioarSmodifw, lxAdt_precioarSaltafw, lxAdt_precioarHoraexpo, lxAdt_precioarEntori, lxAdt_precioarAdt_ent, lxAdt_precioarEsttrans, lxAdt_precioarAdt_vers, lxAdt_precioarAdt_usr, lxAdt_precioarAdt_adn, lxAdt_precioarTalle, lxAdt_precioarBdaltafw, lxAdt_precioarBdmodifw, lxAdt_precioarAdt_hora, lxAdt_precioarAdt_comp, lxAdt_precioarAdt_serie, lxAdt_precioarColores, lxAdt_precioarAdt_cod, lxAdt_precioarListapre, lxAdt_precioarCodigo, lxAdt_precioarArticulo
				lxAdt_precioarFectrans =  .Fechatransferencia			lxAdt_precioarFaltafw =  .Fechaaltafw			lxAdt_precioarFmodifw =  .Fechamodificacionfw			lxAdt_precioarFecimpo =  .Fechaimpo			lxAdt_precioarAdt_fecha =  .Adt_fecha			lxAdt_precioarFecexpo =  .Fechaexpo			lxAdt_precioarFechavig =  .Fechavigencia			lxAdt_precioarTimestampa =  .Timestampalta			lxAdt_precioarPdirori =  .Preciodirectooriginal			lxAdt_precioarCodori =  .Codigoorigen			lxAdt_precioarPdirecto =  .Preciodirecto			lxAdt_precioarAdt_ext =  .Adt_ext			lxAdt_precioarHoraimpo =  .Horaimpo			lxAdt_precioarHaltafw =  .Horaaltafw			lxAdt_precioarValtafw =  .Versionaltafw			lxAdt_precioarZadsfw =  .Zadsfw			lxAdt_precioarVmodifw =  .Versionmodificacionfw			lxAdt_precioarUmodifw =  .Usuariomodificacionfw			lxAdt_precioarUaltafw =  .Usuarioaltafw			lxAdt_precioarHmodifw =  .Horamodificacionfw			lxAdt_precioarSmodifw =  .Seriemodificacionfw			lxAdt_precioarSaltafw =  .Seriealtafw			lxAdt_precioarHoraexpo =  .Horaexpo			lxAdt_precioarEntori =  .Entidadorigen			lxAdt_precioarAdt_ent =  .Adt_ent			lxAdt_precioarEsttrans =  .Estadotransferencia			lxAdt_precioarAdt_vers =  .Adt_vers			lxAdt_precioarAdt_usr =  .Adt_usr			lxAdt_precioarAdt_adn =  .Adt_adn			lxAdt_precioarTalle =  .Talle			lxAdt_precioarBdaltafw =  .Basededatosaltafw			lxAdt_precioarBdmodifw =  .Basededatosmodificacionfw			lxAdt_precioarAdt_hora =  .Adt_hora			lxAdt_precioarAdt_comp =  .Adt_comp			lxAdt_precioarAdt_serie =  .Adt_serie			lxAdt_precioarColores =  upper( .Color_PK ) 			lxAdt_precioarAdt_cod =  .Adt_cod			lxAdt_precioarListapre =  upper( .ListaDePrecio_PK ) 			lxAdt_precioarCodigo =  upper( .Codigo_PK ) 			lxAdt_precioarArticulo =  upper( .Articulo_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ADT_PRECIOAR ( "Fectrans","Faltafw","Fmodifw","Fecimpo","Adt_fecha","Fecexpo","Fechavig","Timestampa","Pdirori","Codori","Pdirecto","Adt_ext","Horaimpo","Haltafw","Valtafw","Zadsfw","Vmodifw","Umodifw","Ualtafw","Hmodifw","Smodifw","Saltafw","Horaexpo","Entori","Adt_ent","Esttrans","Adt_vers","Adt_usr","Adt_adn","Talle","Bdaltafw","Bdmodifw","Adt_hora","Adt_comp","Adt_serie","Colores","Adt_cod","Listapre","Codigo","Articulo" ) values ( <<"'" + this.ConvertirDateSql( lxAdt_precioarFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_precioarFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_precioarFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_precioarFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_precioarAdt_fecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_precioarFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_precioarFechavig ) + "'" >>, <<lxAdt_precioarTimestampa >>, <<lxAdt_precioarPdirori >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarCodori ) + "'" >>, <<lxAdt_precioarPdirecto >>, <<iif( lxAdt_precioarAdt_ext, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarEntori ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_ent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_vers ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_usr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_adn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarTalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_hora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_comp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_serie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarColores ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_cod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarListapre ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_precioarArticulo ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ADT_PRECIOAR' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.ADT_COD + "'"
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxAdt_precioarFectrans, lxAdt_precioarFaltafw, lxAdt_precioarFmodifw, lxAdt_precioarFecimpo, lxAdt_precioarAdt_fecha, lxAdt_precioarFecexpo, lxAdt_precioarFechavig, lxAdt_precioarTimestampa, lxAdt_precioarPdirori, lxAdt_precioarCodori, lxAdt_precioarPdirecto, lxAdt_precioarAdt_ext, lxAdt_precioarHoraimpo, lxAdt_precioarHaltafw, lxAdt_precioarValtafw, lxAdt_precioarZadsfw, lxAdt_precioarVmodifw, lxAdt_precioarUmodifw, lxAdt_precioarUaltafw, lxAdt_precioarHmodifw, lxAdt_precioarSmodifw, lxAdt_precioarSaltafw, lxAdt_precioarHoraexpo, lxAdt_precioarEntori, lxAdt_precioarAdt_ent, lxAdt_precioarEsttrans, lxAdt_precioarAdt_vers, lxAdt_precioarAdt_usr, lxAdt_precioarAdt_adn, lxAdt_precioarTalle, lxAdt_precioarBdaltafw, lxAdt_precioarBdmodifw, lxAdt_precioarAdt_hora, lxAdt_precioarAdt_comp, lxAdt_precioarAdt_serie, lxAdt_precioarColores, lxAdt_precioarAdt_cod, lxAdt_precioarListapre, lxAdt_precioarCodigo, lxAdt_precioarArticulo
				lxAdt_precioarFectrans =  .Fechatransferencia			lxAdt_precioarFaltafw =  .Fechaaltafw			lxAdt_precioarFmodifw =  .Fechamodificacionfw			lxAdt_precioarFecimpo =  .Fechaimpo			lxAdt_precioarAdt_fecha =  .Adt_fecha			lxAdt_precioarFecexpo =  .Fechaexpo			lxAdt_precioarFechavig =  .Fechavigencia			lxAdt_precioarTimestampa =  .Timestampalta			lxAdt_precioarPdirori =  .Preciodirectooriginal			lxAdt_precioarCodori =  .Codigoorigen			lxAdt_precioarPdirecto =  .Preciodirecto			lxAdt_precioarAdt_ext =  .Adt_ext			lxAdt_precioarHoraimpo =  .Horaimpo			lxAdt_precioarHaltafw =  .Horaaltafw			lxAdt_precioarValtafw =  .Versionaltafw			lxAdt_precioarZadsfw =  .Zadsfw			lxAdt_precioarVmodifw =  .Versionmodificacionfw			lxAdt_precioarUmodifw =  .Usuariomodificacionfw			lxAdt_precioarUaltafw =  .Usuarioaltafw			lxAdt_precioarHmodifw =  .Horamodificacionfw			lxAdt_precioarSmodifw =  .Seriemodificacionfw			lxAdt_precioarSaltafw =  .Seriealtafw			lxAdt_precioarHoraexpo =  .Horaexpo			lxAdt_precioarEntori =  .Entidadorigen			lxAdt_precioarAdt_ent =  .Adt_ent			lxAdt_precioarEsttrans =  .Estadotransferencia			lxAdt_precioarAdt_vers =  .Adt_vers			lxAdt_precioarAdt_usr =  .Adt_usr			lxAdt_precioarAdt_adn =  .Adt_adn			lxAdt_precioarTalle =  .Talle			lxAdt_precioarBdaltafw =  .Basededatosaltafw			lxAdt_precioarBdmodifw =  .Basededatosmodificacionfw			lxAdt_precioarAdt_hora =  .Adt_hora			lxAdt_precioarAdt_comp =  .Adt_comp			lxAdt_precioarAdt_serie =  .Adt_serie			lxAdt_precioarColores =  upper( .Color_PK ) 			lxAdt_precioarAdt_cod =  .Adt_cod			lxAdt_precioarListapre =  upper( .ListaDePrecio_PK ) 			lxAdt_precioarCodigo =  upper( .Codigo_PK ) 			lxAdt_precioarArticulo =  upper( .Articulo_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ADT_COD
			lcValorClavePrimariaString = "'" + this.oEntidad.ADT_COD + "'"

			lcFiltro = ["Adt_cod" = ] + lcValorClavePrimariaString  + [ and  ADT_PRECIOAR.ADT_COD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ADT_PRECIOAR set "Fectrans" = <<"'" + this.ConvertirDateSql( lxAdt_precioarFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxAdt_precioarFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAdt_precioarFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAdt_precioarFecimpo ) + "'">>, "Adt_fecha" = <<"'" + this.ConvertirDateSql( lxAdt_precioarAdt_fecha ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAdt_precioarFecexpo ) + "'">>, "Fechavig" = <<"'" + this.ConvertirDateSql( lxAdt_precioarFechavig ) + "'">>, "Timestampa" = <<lxAdt_precioarTimestampa>>, "Pdirori" = <<lxAdt_precioarPdirori>>, "Codori" = <<"'" + this.FormatearTextoSql( lxAdt_precioarCodori ) + "'">>, "Pdirecto" = <<lxAdt_precioarPdirecto>>, "Adt_ext" = <<iif( lxAdt_precioarAdt_ext, 1, 0 )>>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxAdt_precioarHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarHaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarSaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxAdt_precioarHoraexpo ) + "'">>, "Entori" = <<"'" + this.FormatearTextoSql( lxAdt_precioarEntori ) + "'">>, "Adt_ent" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_ent ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxAdt_precioarEsttrans ) + "'">>, "Adt_vers" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_vers ) + "'">>, "Adt_usr" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_usr ) + "'">>, "Adt_adn" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_adn ) + "'">>, "Talle" = <<"'" + this.FormatearTextoSql( lxAdt_precioarTalle ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_precioarBdmodifw ) + "'">>, "Adt_hora" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_hora ) + "'">>, "Adt_comp" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_comp ) + "'">>, "Adt_serie" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_serie ) + "'">>, "Colores" = <<"'" + this.FormatearTextoSql( lxAdt_precioarColores ) + "'">>, "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_precioarAdt_cod ) + "'">>, "Listapre" = <<"'" + this.FormatearTextoSql( lxAdt_precioarListapre ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxAdt_precioarCodigo ) + "'">>, "Articulo" = <<"'" + this.FormatearTextoSql( lxAdt_precioarArticulo ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ADT_PRECIOAR' 
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
			lxValorClavePrimaria = this.oEntidad.ADT_COD
			lcValorClavePrimariaString = "'" + this.oEntidad.ADT_COD + "'"

			lcFiltro = ["Adt_cod" = ] + lcValorClavePrimariaString  + [ and  ADT_PRECIOAR.ADT_COD != '']
		loColeccion.Agregar( 'delete from ZooLogic.ADT_PRECIOAR where ' + lcFiltro )
			loColeccion.cTabla = 'ADT_PRECIOAR' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ADT_PRECIOAR where  ADT_PRECIOAR.ADT_COD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ADT_PRECIOAR where ADT_Cod = " + "'" + this.FormatearTextoSql( this.oEntidad.ADT_COD ) + "'"+ " and  ADT_PRECIOAR.ADT_COD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_PRECIODEARTICULO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ADT_PRECIOAR Where ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.ADT_PRECIOAR set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, ADT_Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..ADT_Fecha ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECHAVIG = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAVIG ) + "'"+ [, TimestampA = ] + transform( &lcCursor..TimestampA )+ [, PDIRORI = ] + transform( &lcCursor..PDIRORI )+ [, Codori = ] + "'" + this.FormatearTextoSql( &lcCursor..Codori ) + "'"+ [, PDIRECTO = ] + transform( &lcCursor..PDIRECTO )+ [, ADT_Ext = ] + Transform( iif( &lcCursor..ADT_Ext, 1, 0 ))+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, Entori = ] + "'" + this.FormatearTextoSql( &lcCursor..Entori ) + "'"+ [, ADT_Ent = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Ent ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, ADT_Vers = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Vers ) + "'"+ [, ADT_Usr = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Usr ) + "'"+ [, ADT_ADN = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_ADN ) + "'"+ [, TALLE = ] + "'" + this.FormatearTextoSql( &lcCursor..TALLE ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ADT_Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Hora ) + "'"+ [, ADT_Comp = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Comp ) + "'"+ [, ADT_Serie = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Serie ) + "'"+ [, COLORES = ] + "'" + this.FormatearTextoSql( &lcCursor..COLORES ) + "'"+ [, ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'"+ [, LISTAPRE = ] + "'" + this.FormatearTextoSql( &lcCursor..LISTAPRE ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, ARTICULO = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTICULO ) + "'" + [ Where ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECTRANS, FALTAFW, FMODIFW, FECIMPO, ADT_Fecha, FECEXPO, FECHAVIG, TimestampA, PDIRORI, Codori, PDIRECTO, ADT_Ext, HORAIMPO, HALTAFW, VALTAFW, ZADSFW, VMODIFW, UMODIFW, UALTAFW, HMODIFW, SMODIFW, SALTAFW, HORAEXPO, Entori, ADT_Ent, ESTTRANS, ADT_Vers, ADT_Usr, ADT_ADN, TALLE, BDALTAFW, BDMODIFW, ADT_Hora, ADT_Comp, ADT_Serie, COLORES, ADT_Cod, LISTAPRE, CODIGO, ARTICULO
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..ADT_Fecha ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAVIG ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TimestampA ) + ',' + transform( &lcCursor..PDIRORI ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codori ) + "'" + ',' + transform( &lcCursor..PDIRECTO ) + ',' + Transform( iif( &lcCursor..ADT_Ext, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Entori ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Ent ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Vers ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Usr ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_ADN ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..TALLE ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Hora ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Comp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Serie ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COLORES ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LISTAPRE ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ARTICULO ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.ADT_PRECIOAR ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_PRECIODEARTICULO'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( ADT_Cod C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..ADT_Cod    )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'ADT_PRECIODEARTICULO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ADT_PRECIODEARTICULO_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ADT_PRECIOAR')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ADT_PRECIODEARTICULO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..ADT_Cod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ADT_PRECIODEARTICULO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_PRECIODEARTICULO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,ADT_Cod as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( ADT_Cod, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_PRECIODEARTICULO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  ADT_Fecha 
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECHAVIG  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ADT_PRECIOAR') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ADT_PRECIOAR
Create Table ZooLogic.TablaTrabajo_ADT_PRECIOAR ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"adt_fecha" datetime  null, 
"fecexpo" datetime  null, 
"fechavig" datetime  null, 
"timestampa" numeric( 14, 0 )  null, 
"pdirori" numeric( 17, 2 )  null, 
"codori" char( 20 )  null, 
"pdirecto" numeric( 16, 2 )  null, 
"adt_ext" bit  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"horaexpo" char( 8 )  null, 
"entori" char( 40 )  null, 
"adt_ent" char( 40 )  null, 
"esttrans" char( 20 )  null, 
"adt_vers" char( 13 )  null, 
"adt_usr" char( 100 )  null, 
"adt_adn" char( 10 )  null, 
"talle" char( 3 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"adt_hora" char( 8 )  null, 
"adt_comp" char( 254 )  null, 
"adt_serie" char( 20 )  null, 
"colores" char( 2 )  null, 
"adt_cod" char( 38 )  null, 
"listapre" char( 6 )  null, 
"codigo" char( 46 )  null, 
"articulo" char( 13 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ADT_PRECIOAR' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ADT_PRECIOAR' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_PRECIODEARTICULO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('adt_fecha','adt_fecha')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fechavig','fechavig')
			.AgregarMapeo('timestampa','timestampa')
			.AgregarMapeo('pdirori','pdirori')
			.AgregarMapeo('codori','codori')
			.AgregarMapeo('pdirecto','pdirecto')
			.AgregarMapeo('adt_ext','adt_ext')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('entori','entori')
			.AgregarMapeo('adt_ent','adt_ent')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('adt_vers','adt_vers')
			.AgregarMapeo('adt_usr','adt_usr')
			.AgregarMapeo('adt_adn','adt_adn')
			.AgregarMapeo('talle','talle')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('adt_hora','adt_hora')
			.AgregarMapeo('adt_comp','adt_comp')
			.AgregarMapeo('adt_serie','adt_serie')
			.AgregarMapeo('colores','colores')
			.AgregarMapeo('adt_cod','adt_cod')
			.AgregarMapeo('listapre','listapre')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('articulo','articulo')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ADT_PRECIOAR'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.ADT_FECHA = isnull( d.ADT_FECHA, t.ADT_FECHA ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECHAVIG = isnull( d.FECHAVIG, t.FECHAVIG ),t.TIMESTAMPA = isnull( d.TIMESTAMPA, t.TIMESTAMPA ),t.PDIRORI = isnull( d.PDIRORI, t.PDIRORI ),t.CODORI = isnull( d.CODORI, t.CODORI ),t.PDIRECTO = isnull( d.PDIRECTO, t.PDIRECTO ),t.ADT_EXT = isnull( d.ADT_EXT, t.ADT_EXT ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.ENTORI = isnull( d.ENTORI, t.ENTORI ),t.ADT_ENT = isnull( d.ADT_ENT, t.ADT_ENT ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.ADT_VERS = isnull( d.ADT_VERS, t.ADT_VERS ),t.ADT_USR = isnull( d.ADT_USR, t.ADT_USR ),t.ADT_ADN = isnull( d.ADT_ADN, t.ADT_ADN ),t.TALLE = isnull( d.TALLE, t.TALLE ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ADT_HORA = isnull( d.ADT_HORA, t.ADT_HORA ),t.ADT_COMP = isnull( d.ADT_COMP, t.ADT_COMP ),t.ADT_SERIE = isnull( d.ADT_SERIE, t.ADT_SERIE ),t.COLORES = isnull( d.COLORES, t.COLORES ),t.ADT_COD = isnull( d.ADT_COD, t.ADT_COD ),t.LISTAPRE = isnull( d.LISTAPRE, t.LISTAPRE ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.ARTICULO = isnull( d.ARTICULO, t.ARTICULO )
					from ZooLogic.ADT_PRECIOAR t inner join deleted d 
							 on t.ADT_Cod = d.ADT_Cod
				-- Fin Updates
				insert into ZooLogic.ADT_PRECIOAR(Fectrans,Faltafw,Fmodifw,Fecimpo,Adt_fecha,Fecexpo,Fechavig,Timestampa,Pdirori,Codori,Pdirecto,Adt_ext,Horaimpo,Haltafw,Valtafw,Zadsfw,Vmodifw,Umodifw,Ualtafw,Hmodifw,Smodifw,Saltafw,Horaexpo,Entori,Adt_ent,Esttrans,Adt_vers,Adt_usr,Adt_adn,Talle,Bdaltafw,Bdmodifw,Adt_hora,Adt_comp,Adt_serie,Colores,Adt_cod,Listapre,Codigo,Articulo)
					Select isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.ADT_FECHA,''),isnull( d.FECEXPO,''),isnull( d.FECHAVIG,''),[funciones].ObtenerTimestamp() + row_number() OVER (ORDER BY d.ADT_Cod),isnull( d.PDIRORI,0),isnull( d.CODORI,''),isnull( d.PDIRECTO,0),isnull( d.ADT_EXT,0),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.ENTORI,''),isnull( d.ADT_ENT,''),isnull( d.ESTTRANS,''),isnull( d.ADT_VERS,''),isnull( d.ADT_USR,''),isnull( d.ADT_ADN,''),isnull( d.TALLE,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ADT_HORA,''),isnull( d.ADT_COMP,''),isnull( d.ADT_SERIE,''),isnull( d.COLORES,''),isnull( d.ADT_COD,''),isnull( d.LISTAPRE,''),isnull( d.CODIGO,''),isnull( d.ARTICULO,'')
						From deleted d left join ZooLogic.ADT_PRECIOAR pk 
							 on d.ADT_Cod = pk.ADT_Cod
						Where pk.ADT_Cod Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ADT_PRECIOAR') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ADT_PRECIOAR
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ADT_PRECIODEARTICULO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_PRECIODEARTICULO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_PRECIODEARTICULO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_PRECIODEARTICULO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_PRECIODEARTICULO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Adt_fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_PRECIODEARTICULO.Adt_fecha, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_PRECIODEARTICULO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechavigencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_PRECIODEARTICULO.Fechavigencia, ctod( '  /  /    ' ) ) )
					.Timestampalta = nvl( c_ADT_PRECIODEARTICULO.Timestampalta, 0 )
					.Preciodirectooriginal = nvl( c_ADT_PRECIODEARTICULO.Preciodirectooriginal, 0 )
					.Codigoorigen = nvl( c_ADT_PRECIODEARTICULO.Codigoorigen, [] )
					.Preciodirecto = nvl( c_ADT_PRECIODEARTICULO.Preciodirecto, 0 )
					.Adt_ext = nvl( c_ADT_PRECIODEARTICULO.Adt_ext, .F. )
					.Horaimpo = nvl( c_ADT_PRECIODEARTICULO.Horaimpo, [] )
					.Horaaltafw = nvl( c_ADT_PRECIODEARTICULO.Horaaltafw, [] )
					.Versionaltafw = nvl( c_ADT_PRECIODEARTICULO.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_ADT_PRECIODEARTICULO.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_ADT_PRECIODEARTICULO.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_ADT_PRECIODEARTICULO.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_ADT_PRECIODEARTICULO.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_ADT_PRECIODEARTICULO.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_ADT_PRECIODEARTICULO.Seriealtafw, [] )
					.Horaexpo = nvl( c_ADT_PRECIODEARTICULO.Horaexpo, [] )
					.Entidadorigen = nvl( c_ADT_PRECIODEARTICULO.Entidadorigen, [] )
					.Adt_ent = nvl( c_ADT_PRECIODEARTICULO.Adt_ent, [] )
					.Estadotransferencia = nvl( c_ADT_PRECIODEARTICULO.Estadotransferencia, [] )
					.Adt_vers = nvl( c_ADT_PRECIODEARTICULO.Adt_vers, [] )
					.Adt_usr = nvl( c_ADT_PRECIODEARTICULO.Adt_usr, [] )
					.Adt_adn = nvl( c_ADT_PRECIODEARTICULO.Adt_adn, [] )
					.Talle = nvl( c_ADT_PRECIODEARTICULO.Talle, [] )
					.Basededatosaltafw = nvl( c_ADT_PRECIODEARTICULO.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_ADT_PRECIODEARTICULO.Basededatosmodificacionfw, [] )
					.Adt_hora = nvl( c_ADT_PRECIODEARTICULO.Adt_hora, [] )
					.Adt_comp = nvl( c_ADT_PRECIODEARTICULO.Adt_comp, [] )
					.Adt_serie = nvl( c_ADT_PRECIODEARTICULO.Adt_serie, [] )
					.Color_PK =  nvl( c_ADT_PRECIODEARTICULO.Color, [] )
					.Adt_cod = nvl( c_ADT_PRECIODEARTICULO.Adt_cod, [] )
					.Listadeprecio_PK =  nvl( c_ADT_PRECIODEARTICULO.Listadeprecio, [] )
					.Codigo_PK =  nvl( c_ADT_PRECIODEARTICULO.Codigo, [] )
					.Articulo_PK =  nvl( c_ADT_PRECIODEARTICULO.Articulo, [] )
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
		return c_ADT_PRECIODEARTICULO.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ZooLogic.ADT_PRECIOAR' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "ADT_Cod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,ADT_Cod as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    ADT_Cod from (
							select * 
								from ZooLogic.ADT_PRECIOAR 
								Where   ADT_PRECIOAR.ADT_COD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ADT_PRECIOAR", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "ADT_Cod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Fecexpo" as "Fechaexpo", "Fechavig" as "Fechavigencia", "Timestampa" as "Timestampalta", "Pdirori" as "Preciodirectooriginal", "Codori" as "Codigoorigen", "Pdirecto" as "Preciodirecto", "Adt_ext" as "Adt_ext", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Entori" as "Entidadorigen", "Adt_ent" as "Adt_ent", "Esttrans" as "Estadotransferencia", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Talle" as "Talle", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Adt_comp" as "Adt_comp", "Adt_serie" as "Adt_serie", "Colores" as "Color", "Adt_cod" as "Adt_cod", "Listapre" as "Listadeprecio", "Codigo" as "Codigo", "Articulo" as "Articulo"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ADT_PRECIOAR 
								Where   ADT_PRECIOAR.ADT_COD != ''
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
	Tabla = 'ADT_PRECIOAR'
	Filtro = " ADT_PRECIOAR.ADT_COD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ADT_PRECIOAR.ADT_COD != ''"
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
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="FECHATRANSFERENCIA                      " tabla="ADT_PRECIOAR   " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="FECHAALTAFW                             " tabla="ADT_PRECIOAR   " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="FECHAMODIFICACIONFW                     " tabla="ADT_PRECIOAR   " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="FECHAIMPO                               " tabla="ADT_PRECIOAR   " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="ADT_FECHA                               " tabla="ADT_PRECIOAR   " campo="ADT_FECHA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="FECHAEXPO                               " tabla="ADT_PRECIOAR   " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="FECHAVIGENCIA                           " tabla="ADT_PRECIOAR   " campo="FECHAVIG  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Fecha de vigencia                                                                                                                                               " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="TIMESTAMPALTA                           " tabla="ADT_PRECIOAR   " campo="TIMESTAMPA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="14" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Timestamp                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="PRECIODIRECTOORIGINAL                   " tabla="ADT_PRECIOAR   " campo="PDIRORI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Precio directo                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="CODIGOORIGEN                            " tabla="ADT_PRECIOAR   " campo="CODORI    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Codigo Origen                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="PRECIODIRECTO                           " tabla="ADT_PRECIOAR   " campo="PDIRECTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Precio directo                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="ADT_EXT                                 " tabla="ADT_PRECIOAR   " campo="ADT_EXT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Información remota                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="HORAIMPO                                " tabla="ADT_PRECIOAR   " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="HORAALTAFW                              " tabla="ADT_PRECIOAR   " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="VERSIONALTAFW                           " tabla="ADT_PRECIOAR   " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="ZADSFW                                  " tabla="ADT_PRECIOAR   " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="VERSIONMODIFICACIONFW                   " tabla="ADT_PRECIOAR   " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="USUARIOMODIFICACIONFW                   " tabla="ADT_PRECIOAR   " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="USUARIOALTAFW                           " tabla="ADT_PRECIOAR   " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="HORAMODIFICACIONFW                      " tabla="ADT_PRECIOAR   " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="SERIEMODIFICACIONFW                     " tabla="ADT_PRECIOAR   " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="SERIEALTAFW                             " tabla="ADT_PRECIOAR   " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="HORAEXPO                                " tabla="ADT_PRECIOAR   " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="ENTIDADORIGEN                           " tabla="ADT_PRECIOAR   " campo="ENTORI    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Entidad de origen                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="ADT_ENT                                 " tabla="ADT_PRECIOAR   " campo="ADT_ENT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Entidad                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="ESTADOTRANSFERENCIA                     " tabla="ADT_PRECIOAR   " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="ADT_VERS                                " tabla="ADT_PRECIOAR   " campo="ADT_VERS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Versión                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="ADT_USR                                 " tabla="ADT_PRECIOAR   " campo="ADT_USR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="ADT_ADN                                 " tabla="ADT_PRECIOAR   " campo="ADT_ADN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="ADN                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="TALLE                                   " tabla="ADT_PRECIOAR   " campo="TALLE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Talle                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="BASEDEDATOSALTAFW                       " tabla="ADT_PRECIOAR   " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ADT_PRECIOAR   " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="ADT_HORA                                " tabla="ADT_PRECIOAR   " campo="ADT_HORA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Hora                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="ADT_COMP                                " tabla="ADT_PRECIOAR   " campo="ADT_COMP  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="ADT_SERIE                               " tabla="ADT_PRECIOAR   " campo="ADT_SERIE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="COLOR                                   " tabla="ADT_PRECIOAR   " campo="COLORES   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="Color                                   " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Color                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="ADT_COD                                 " tabla="ADT_PRECIOAR   " campo="ADT_COD   " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="LISTADEPRECIO                           " tabla="ADT_PRECIOAR   " campo="LISTAPRE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ListaDePrecios                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Lista de Precio                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="CODIGO                                  " tabla="ADT_PRECIOAR   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PRECIODEARTICULO                        " tipodato="C         " longitud="46" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Precio de articulo                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_PRECIODEARTICULO                    " atributo="ARTICULO                                " tabla="ADT_PRECIOAR   " campo="ARTICULO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="Articulo                                " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Articulo                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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