
define class Din_EntidadMOVIMIENTODECAJAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_MOVIMIENTODECAJA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_036PK'
	cTablaPrincipal = 'MOVCAJA'
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
			local  lxMovcajaFecexpo, lxMovcajaFaltafw, lxMovcajaFecimpo, lxMovcajaFectrans, lxMovcajaFmodifw, lxMovcajaFechacompr, lxMovcajaFecha, lxMovcajaIdmovi, lxMovcajaTipovalor, lxMovcajaPtovta, lxMovcajaNumcomp, lxMovcajaTimestamp, lxMovcajaHoraimpo, lxMovcajaHoraexpo, lxMovcajaSmodifw, lxMovcajaHmodifw, lxMovcajaValtafw, lxMovcajaVmodifw, lxMovcajaUaltafw, lxMovcajaUmodifw, lxMovcajaSaltafw, lxMovcajaZadsfw, lxMovcajaItemvalor, lxMovcajaHaltafw, lxMovcajaEsttrans, lxMovcajaTarea, lxMovcajaBdmodifw, lxMovcajaBdaltafw, lxMovcajaAccion, lxMovcajaFactsec, lxMovcajaIdvendedor, lxMovcajaTurno, lxMovcajaIdcajaaudi, lxMovcajaFechacaja, lxMovcajaHora, lxMovcajaIdvalor, lxMovcajaIdcaja, lxMovcajaTipocomp, lxMovcajaMonto, lxMovcajaDescrip, lxMovcajaCotiz
				lxMovcajaFecexpo =  .Fechaexpo			lxMovcajaFaltafw =  .Fechaaltafw			lxMovcajaFecimpo =  .Fechaimpo			lxMovcajaFectrans =  .Fechatransferencia			lxMovcajaFmodifw =  .Fechamodificacionfw			lxMovcajaFechacompr =  .Fechacomprobante			lxMovcajaFecha =  .Fecha			lxMovcajaIdmovi =  .Id			lxMovcajaTipovalor =  .Tipovalor			lxMovcajaPtovta =  .Puntodeventa			lxMovcajaNumcomp =  .Numerocomprobante			lxMovcajaTimestamp = goLibrerias.ObtenerTimestamp()			lxMovcajaHoraimpo =  .Horaimpo			lxMovcajaHoraexpo =  .Horaexpo			lxMovcajaSmodifw =  .Seriemodificacionfw			lxMovcajaHmodifw =  .Horamodificacionfw			lxMovcajaValtafw =  .Versionaltafw			lxMovcajaVmodifw =  .Versionmodificacionfw			lxMovcajaUaltafw =  .Usuarioaltafw			lxMovcajaUmodifw =  .Usuariomodificacionfw			lxMovcajaSaltafw =  .Seriealtafw			lxMovcajaZadsfw =  .Zadsfw			lxMovcajaItemvalor =  .Itemvalor			lxMovcajaHaltafw =  .Horaaltafw			lxMovcajaEsttrans =  .Estadotransferencia			lxMovcajaTarea =  .Tarea			lxMovcajaBdmodifw =  .Basededatosmodificacionfw			lxMovcajaBdaltafw =  .Basededatosaltafw			lxMovcajaAccion =  .Accion			lxMovcajaFactsec =  .Secuencia			lxMovcajaIdvendedor =  upper( .Vendedor_PK ) 			lxMovcajaTurno =  .Turno			lxMovcajaIdcajaaudi =  .Cajaauditoria_PK 			lxMovcajaFechacaja =  .Fechacaja			lxMovcajaHora =  .Hora			lxMovcajaIdvalor =  upper( .Valor_PK ) 			lxMovcajaIdcaja =  .Cajaestado_PK 			lxMovcajaTipocomp =  .Tipocomprobante			lxMovcajaMonto =  .Monto			lxMovcajaDescrip =  .Descripcion			lxMovcajaCotiz =  .Cotizacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxMovcajaIdmovi = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.MOVCAJA ( "Fecexpo","Faltafw","Fecimpo","Fectrans","Fmodifw","Fechacompr","Fecha","Idmovi","Tipovalor","Ptovta","Numcomp","Timestamp","Horaimpo","Horaexpo","Smodifw","Hmodifw","Valtafw","Vmodifw","Ualtafw","Umodifw","Saltafw","Zadsfw","Itemvalor","Haltafw","Esttrans","Tarea","Bdmodifw","Bdaltafw","Accion","Factsec","Idvendedor","Turno","Idcajaaudi","Fechacaja","Hora","Idvalor","Idcaja","Tipocomp","Monto","Descrip","Cotiz" ) values ( <<"'" + this.ConvertirDateSql( lxMovcajaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovcajaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovcajaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovcajaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovcajaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovcajaFechacompr ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovcajaFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaIdmovi ) + "'" >>, <<lxMovcajaTipovalor >>, <<lxMovcajaPtovta >>, <<lxMovcajaNumcomp >>, <<lxMovcajaTimestamp >>, <<"'" + this.FormatearTextoSql( lxMovcajaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaItemvalor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaTarea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaAccion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaFactsec ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaIdvendedor ) + "'" >>, <<lxMovcajaTurno >>, <<lxMovcajaIdcajaaudi >>, <<"'" + this.ConvertirDateSql( lxMovcajaFechacaja ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaHora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaIdvalor ) + "'" >>, <<lxMovcajaIdcaja >>, <<"'" + this.FormatearTextoSql( lxMovcajaTipocomp ) + "'" >>, <<lxMovcajaMonto >>, <<"'" + this.FormatearTextoSql( lxMovcajaDescrip ) + "'" >>, <<lxMovcajaCotiz >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ID
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
		this.oEntidad.Timestamp = lxMovcajaTimestamp
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
		return this.oEntidad.ID
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxMovcajaFecexpo, lxMovcajaFaltafw, lxMovcajaFecimpo, lxMovcajaFectrans, lxMovcajaFmodifw, lxMovcajaFechacompr, lxMovcajaFecha, lxMovcajaIdmovi, lxMovcajaTipovalor, lxMovcajaPtovta, lxMovcajaNumcomp, lxMovcajaTimestamp, lxMovcajaHoraimpo, lxMovcajaHoraexpo, lxMovcajaSmodifw, lxMovcajaHmodifw, lxMovcajaValtafw, lxMovcajaVmodifw, lxMovcajaUaltafw, lxMovcajaUmodifw, lxMovcajaSaltafw, lxMovcajaZadsfw, lxMovcajaItemvalor, lxMovcajaHaltafw, lxMovcajaEsttrans, lxMovcajaTarea, lxMovcajaBdmodifw, lxMovcajaBdaltafw, lxMovcajaAccion, lxMovcajaFactsec, lxMovcajaIdvendedor, lxMovcajaTurno, lxMovcajaIdcajaaudi, lxMovcajaFechacaja, lxMovcajaHora, lxMovcajaIdvalor, lxMovcajaIdcaja, lxMovcajaTipocomp, lxMovcajaMonto, lxMovcajaDescrip, lxMovcajaCotiz
				lxMovcajaFecexpo =  .Fechaexpo			lxMovcajaFaltafw =  .Fechaaltafw			lxMovcajaFecimpo =  .Fechaimpo			lxMovcajaFectrans =  .Fechatransferencia			lxMovcajaFmodifw =  .Fechamodificacionfw			lxMovcajaFechacompr =  .Fechacomprobante			lxMovcajaFecha =  .Fecha			lxMovcajaIdmovi =  .Id			lxMovcajaTipovalor =  .Tipovalor			lxMovcajaPtovta =  .Puntodeventa			lxMovcajaNumcomp =  .Numerocomprobante			lxMovcajaTimestamp = goLibrerias.ObtenerTimestamp()			lxMovcajaHoraimpo =  .Horaimpo			lxMovcajaHoraexpo =  .Horaexpo			lxMovcajaSmodifw =  .Seriemodificacionfw			lxMovcajaHmodifw =  .Horamodificacionfw			lxMovcajaValtafw =  .Versionaltafw			lxMovcajaVmodifw =  .Versionmodificacionfw			lxMovcajaUaltafw =  .Usuarioaltafw			lxMovcajaUmodifw =  .Usuariomodificacionfw			lxMovcajaSaltafw =  .Seriealtafw			lxMovcajaZadsfw =  .Zadsfw			lxMovcajaItemvalor =  .Itemvalor			lxMovcajaHaltafw =  .Horaaltafw			lxMovcajaEsttrans =  .Estadotransferencia			lxMovcajaTarea =  .Tarea			lxMovcajaBdmodifw =  .Basededatosmodificacionfw			lxMovcajaBdaltafw =  .Basededatosaltafw			lxMovcajaAccion =  .Accion			lxMovcajaFactsec =  .Secuencia			lxMovcajaIdvendedor =  upper( .Vendedor_PK ) 			lxMovcajaTurno =  .Turno			lxMovcajaIdcajaaudi =  .Cajaauditoria_PK 			lxMovcajaFechacaja =  .Fechacaja			lxMovcajaHora =  .Hora			lxMovcajaIdvalor =  upper( .Valor_PK ) 			lxMovcajaIdcaja =  .Cajaestado_PK 			lxMovcajaTipocomp =  .Tipocomprobante			lxMovcajaMonto =  .Monto			lxMovcajaDescrip =  .Descripcion			lxMovcajaCotiz =  .Cotizacion
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
			lxValorClavePrimaria = .oEntidad.ID
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.MOVCAJA set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxMovcajaFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxMovcajaFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxMovcajaFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxMovcajaFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxMovcajaFmodifw ) + "'">>,"Fechacompr" = <<"'" + this.ConvertirDateSql( lxMovcajaFechacompr ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxMovcajaFecha ) + "'">>,"Idmovi" = <<"'" + this.FormatearTextoSql( lxMovcajaIdmovi ) + "'">>,"Tipovalor" = <<lxMovcajaTipovalor>>,"Ptovta" = <<lxMovcajaPtovta>>,"Numcomp" = <<lxMovcajaNumcomp>>,"Timestamp" = <<lxMovcajaTimestamp>>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxMovcajaHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxMovcajaHoraexpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxMovcajaSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxMovcajaHmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxMovcajaValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxMovcajaVmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxMovcajaUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxMovcajaUmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxMovcajaSaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxMovcajaZadsfw ) + "'">>,"Itemvalor" = <<"'" + this.FormatearTextoSql( lxMovcajaItemvalor ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxMovcajaHaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxMovcajaEsttrans ) + "'">>,"Tarea" = <<"'" + this.FormatearTextoSql( lxMovcajaTarea ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxMovcajaBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxMovcajaBdaltafw ) + "'">>,"Accion" = <<"'" + this.FormatearTextoSql( lxMovcajaAccion ) + "'">>,"Factsec" = <<"'" + this.FormatearTextoSql( lxMovcajaFactsec ) + "'">>,"Idvendedor" = <<"'" + this.FormatearTextoSql( lxMovcajaIdvendedor ) + "'">>,"Turno" = <<lxMovcajaTurno>>,"Idcajaaudi" = <<lxMovcajaIdcajaaudi>>,"Fechacaja" = <<"'" + this.ConvertirDateSql( lxMovcajaFechacaja ) + "'">>,"Hora" = <<"'" + this.FormatearTextoSql( lxMovcajaHora ) + "'">>,"Idvalor" = <<"'" + this.FormatearTextoSql( lxMovcajaIdvalor ) + "'">>,"Idcaja" = <<lxMovcajaIdcaja>>,"Tipocomp" = <<"'" + this.FormatearTextoSql( lxMovcajaTipocomp ) + "'">>,"Monto" = <<lxMovcajaMonto>>,"Descrip" = <<"'" + this.FormatearTextoSql( lxMovcajaDescrip ) + "'">>,"Cotiz" = <<lxMovcajaCotiz>> where "Idmovi" = <<"'" + this.FormatearTextoSql( lxMovcajaIdmovi ) + "'">> and  MOVCAJA.IDMOVI != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxMovcajaTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 IdMovi from ZooLogic.MOVCAJA where " + this.ConvertirFuncionesSql( " MOVCAJA.IDMOVI != ''" ) )
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
			Local lxMovcajaIdmovi
			lxMovcajaIdmovi = .Id

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fechacompr" as "Fechacomprobante", "Fecha" as "Fecha", "Idmovi" as "Id", "Tipovalor" as "Tipovalor", "Ptovta" as "Puntodeventa", "Numcomp" as "Numerocomprobante", "Timestamp" as "Timestamp", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Itemvalor" as "Itemvalor", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Tarea" as "Tarea", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Accion" as "Accion", "Factsec" as "Secuencia", "Idvendedor" as "Vendedor", "Turno" as "Turno", "Idcajaaudi" as "Cajaauditoria", "Fechacaja" as "Fechacaja", "Hora" as "Hora", "Idvalor" as "Valor", "Idcaja" as "Cajaestado", "Tipocomp" as "Tipocomprobante", "Monto" as "Monto", "Descrip" as "Descripcion", "Cotiz" as "Cotizacion" from ZooLogic.MOVCAJA where "Idmovi" = <<"'" + this.FormatearTextoSql( lxMovcajaIdmovi ) + "'">> and  MOVCAJA.IDMOVI != ''
			endtext
			use in select('c_MOVIMIENTODECAJA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MOVIMIENTODECAJA', set( 'Datasession' ) )

			if reccount( 'c_MOVIMIENTODECAJA' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxMovcajaIdmovi as Variant
		llRetorno = .t.
		lxMovcajaIdmovi = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.MOVCAJA where "Idmovi" = <<"'" + this.FormatearTextoSql( lxMovcajaIdmovi ) + "'">> and  MOVCAJA.IDMOVI != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fechacompr" as "Fechacomprobante", "Fecha" as "Fecha", "Idmovi" as "Id", "Tipovalor" as "Tipovalor", "Ptovta" as "Puntodeventa", "Numcomp" as "Numerocomprobante", "Timestamp" as "Timestamp", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Itemvalor" as "Itemvalor", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Tarea" as "Tarea", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Accion" as "Accion", "Factsec" as "Secuencia", "Idvendedor" as "Vendedor", "Turno" as "Turno", "Idcajaaudi" as "Cajaauditoria", "Fechacaja" as "Fechacaja", "Hora" as "Hora", "Idvalor" as "Valor", "Idcaja" as "Cajaestado", "Tipocomp" as "Tipocomprobante", "Monto" as "Monto", "Descrip" as "Descripcion", "Cotiz" as "Cotizacion" from ZooLogic.MOVCAJA where  MOVCAJA.IDMOVI != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_MOVIMIENTODECAJA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MOVIMIENTODECAJA', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fechacompr" as "Fechacomprobante", "Fecha" as "Fecha", "Idmovi" as "Id", "Tipovalor" as "Tipovalor", "Ptovta" as "Puntodeventa", "Numcomp" as "Numerocomprobante", "Timestamp" as "Timestamp", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Itemvalor" as "Itemvalor", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Tarea" as "Tarea", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Accion" as "Accion", "Factsec" as "Secuencia", "Idvendedor" as "Vendedor", "Turno" as "Turno", "Idcajaaudi" as "Cajaauditoria", "Fechacaja" as "Fechacaja", "Hora" as "Hora", "Idvalor" as "Valor", "Idcaja" as "Cajaestado", "Tipocomp" as "Tipocomprobante", "Monto" as "Monto", "Descrip" as "Descripcion", "Cotiz" as "Cotizacion" from ZooLogic.MOVCAJA where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MOVCAJA.IDMOVI != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_MOVIMIENTODECAJA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MOVIMIENTODECAJA', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fechacompr" as "Fechacomprobante", "Fecha" as "Fecha", "Idmovi" as "Id", "Tipovalor" as "Tipovalor", "Ptovta" as "Puntodeventa", "Numcomp" as "Numerocomprobante", "Timestamp" as "Timestamp", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Itemvalor" as "Itemvalor", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Tarea" as "Tarea", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Accion" as "Accion", "Factsec" as "Secuencia", "Idvendedor" as "Vendedor", "Turno" as "Turno", "Idcajaaudi" as "Cajaauditoria", "Fechacaja" as "Fechacaja", "Hora" as "Hora", "Idvalor" as "Valor", "Idcaja" as "Cajaestado", "Tipocomp" as "Tipocomprobante", "Monto" as "Monto", "Descrip" as "Descripcion", "Cotiz" as "Cotizacion" from ZooLogic.MOVCAJA where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MOVCAJA.IDMOVI != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_MOVIMIENTODECAJA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MOVIMIENTODECAJA', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fechacompr" as "Fechacomprobante", "Fecha" as "Fecha", "Idmovi" as "Id", "Tipovalor" as "Tipovalor", "Ptovta" as "Puntodeventa", "Numcomp" as "Numerocomprobante", "Timestamp" as "Timestamp", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Itemvalor" as "Itemvalor", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Tarea" as "Tarea", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Accion" as "Accion", "Factsec" as "Secuencia", "Idvendedor" as "Vendedor", "Turno" as "Turno", "Idcajaaudi" as "Cajaauditoria", "Fechacaja" as "Fechacaja", "Hora" as "Hora", "Idvalor" as "Valor", "Idcaja" as "Cajaestado", "Tipocomp" as "Tipocomprobante", "Monto" as "Monto", "Descrip" as "Descripcion", "Cotiz" as "Cotizacion" from ZooLogic.MOVCAJA where  MOVCAJA.IDMOVI != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_MOVIMIENTODECAJA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MOVIMIENTODECAJA', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + "'" + this.FormatearTextoSql( .oEntidad.ID ) + "'"
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Faltafw,Fecimpo,Fectrans,Fmodifw,Fechacompr,Fecha,Idmovi,Tipovalor,Ptovta,Numcomp,Ti" + ;
"mestamp,Horaimpo,Horaexpo,Smodifw,Hmodifw,Valtafw,Vmodifw,Ualtafw,Umodifw,Saltafw,Zadsfw,Itemvalor,H" + ;
"altafw,Esttrans,Tarea,Bdmodifw,Bdaltafw,Accion,Factsec,Idvendedor,Turno,Idcajaaudi,Fechacaja,Hora,Id" + ;
"valor,Idcaja,Tipocomp,Monto,Descrip,Cotiz" + ;
" from ZooLogic.MOVCAJA where  MOVCAJA.IDMOVI != '' and " + lcFiltro )
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
			local  lxMovcajaFecexpo, lxMovcajaFaltafw, lxMovcajaFecimpo, lxMovcajaFectrans, lxMovcajaFmodifw, lxMovcajaFechacompr, lxMovcajaFecha, lxMovcajaIdmovi, lxMovcajaTipovalor, lxMovcajaPtovta, lxMovcajaNumcomp, lxMovcajaTimestamp, lxMovcajaHoraimpo, lxMovcajaHoraexpo, lxMovcajaSmodifw, lxMovcajaHmodifw, lxMovcajaValtafw, lxMovcajaVmodifw, lxMovcajaUaltafw, lxMovcajaUmodifw, lxMovcajaSaltafw, lxMovcajaZadsfw, lxMovcajaItemvalor, lxMovcajaHaltafw, lxMovcajaEsttrans, lxMovcajaTarea, lxMovcajaBdmodifw, lxMovcajaBdaltafw, lxMovcajaAccion, lxMovcajaFactsec, lxMovcajaIdvendedor, lxMovcajaTurno, lxMovcajaIdcajaaudi, lxMovcajaFechacaja, lxMovcajaHora, lxMovcajaIdvalor, lxMovcajaIdcaja, lxMovcajaTipocomp, lxMovcajaMonto, lxMovcajaDescrip, lxMovcajaCotiz
				lxMovcajaFecexpo = ctod( '  /  /    ' )			lxMovcajaFaltafw = ctod( '  /  /    ' )			lxMovcajaFecimpo = ctod( '  /  /    ' )			lxMovcajaFectrans = ctod( '  /  /    ' )			lxMovcajaFmodifw = ctod( '  /  /    ' )			lxMovcajaFechacompr = ctod( '  /  /    ' )			lxMovcajaFecha = ctod( '  /  /    ' )			lxMovcajaIdmovi = []			lxMovcajaTipovalor = 0			lxMovcajaPtovta = 0			lxMovcajaNumcomp = 0			lxMovcajaTimestamp = goLibrerias.ObtenerTimestamp()			lxMovcajaHoraimpo = []			lxMovcajaHoraexpo = []			lxMovcajaSmodifw = []			lxMovcajaHmodifw = []			lxMovcajaValtafw = []			lxMovcajaVmodifw = []			lxMovcajaUaltafw = []			lxMovcajaUmodifw = []			lxMovcajaSaltafw = []			lxMovcajaZadsfw = []			lxMovcajaItemvalor = []			lxMovcajaHaltafw = []			lxMovcajaEsttrans = []			lxMovcajaTarea = []			lxMovcajaBdmodifw = []			lxMovcajaBdaltafw = []			lxMovcajaAccion = []			lxMovcajaFactsec = []			lxMovcajaIdvendedor = []			lxMovcajaTurno = 0			lxMovcajaIdcajaaudi = 0			lxMovcajaFechacaja = ctod( '  /  /    ' )			lxMovcajaHora = []			lxMovcajaIdvalor = []			lxMovcajaIdcaja = 0			lxMovcajaTipocomp = []			lxMovcajaMonto = 0			lxMovcajaDescrip = []			lxMovcajaCotiz = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.MOVCAJA where "IdMovi" = ] + "'" + this.FormatearTextoSql( .oEntidad.ID ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'MOVCAJA' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where IdMovi = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(IdMovi, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  MOVCAJA.IDMOVI != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fechacompr" as "Fechacomprobante", "Fecha" as "Fecha", "Idmovi" as "Id", "Tipovalor" as "Tipovalor", "Ptovta" as "Puntodeventa", "Numcomp" as "Numerocomprobante", "Timestamp" as "Timestamp", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Itemvalor" as "Itemvalor", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Tarea" as "Tarea", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Accion" as "Accion", "Factsec" as "Secuencia", "Idvendedor" as "Vendedor", "Turno" as "Turno", "Idcajaaudi" as "Cajaauditoria", "Fechacaja" as "Fechacaja", "Hora" as "Hora", "Idvalor" as "Valor", "Idcaja" as "Cajaestado", "Tipocomp" as "Tipocomprobante", "Monto" as "Monto", "Descrip" as "Descripcion", "Cotiz" as "Cotizacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MOVCAJA', '', tnTope )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHACOMPR AS FECHACOMPROBANTE'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'ID'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDMOVI AS ID'
				Case lcAtributo == 'TIPOVALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOVALOR AS TIPOVALOR'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVTA AS PUNTODEVENTA'
				Case lcAtributo == 'NUMEROCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCOMP AS NUMEROCOMPROBANTE'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'ITEMVALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ITEMVALOR AS ITEMVALOR'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'TAREA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TAREA AS TAREA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ACCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACCION AS ACCION'
				Case lcAtributo == 'SECUENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTSEC AS SECUENCIA'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVENDEDOR AS VENDEDOR'
				Case lcAtributo == 'TURNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TURNO AS TURNO'
				Case lcAtributo == 'CAJAAUDITORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJAAUDI AS CAJAAUDITORIA'
				Case lcAtributo == 'FECHACAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHACAJA AS FECHACAJA'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORA AS HORA'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVALOR AS VALOR'
				Case lcAtributo == 'CAJAESTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJAESTADO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOCOMP AS TIPOCOMPROBANTE'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMPROBANTE'
				lcCampo = 'FECHACOMPR'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'ID'
				lcCampo = 'IDMOVI'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOVALOR'
				lcCampo = 'TIPOVALOR'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVTA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCOMPROBANTE'
				lcCampo = 'NUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'ITEMVALOR'
				lcCampo = 'ITEMVALOR'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'TAREA'
				lcCampo = 'TAREA'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ACCION'
				lcCampo = 'ACCION'
			Case upper( alltrim( tcAtributo ) ) == 'SECUENCIA'
				lcCampo = 'FACTSEC'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'IDVENDEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'TURNO'
				lcCampo = 'TURNO'
			Case upper( alltrim( tcAtributo ) ) == 'CAJAAUDITORIA'
				lcCampo = 'IDCAJAAUDI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACAJA'
				lcCampo = 'FECHACAJA'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'HORA'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'IDVALOR'
			Case upper( alltrim( tcAtributo ) ) == 'CAJAESTADO'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'TIPOCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
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
			local  lxMovcajaFecexpo, lxMovcajaFaltafw, lxMovcajaFecimpo, lxMovcajaFectrans, lxMovcajaFmodifw, lxMovcajaFechacompr, lxMovcajaFecha, lxMovcajaIdmovi, lxMovcajaTipovalor, lxMovcajaPtovta, lxMovcajaNumcomp, lxMovcajaTimestamp, lxMovcajaHoraimpo, lxMovcajaHoraexpo, lxMovcajaSmodifw, lxMovcajaHmodifw, lxMovcajaValtafw, lxMovcajaVmodifw, lxMovcajaUaltafw, lxMovcajaUmodifw, lxMovcajaSaltafw, lxMovcajaZadsfw, lxMovcajaItemvalor, lxMovcajaHaltafw, lxMovcajaEsttrans, lxMovcajaTarea, lxMovcajaBdmodifw, lxMovcajaBdaltafw, lxMovcajaAccion, lxMovcajaFactsec, lxMovcajaIdvendedor, lxMovcajaTurno, lxMovcajaIdcajaaudi, lxMovcajaFechacaja, lxMovcajaHora, lxMovcajaIdvalor, lxMovcajaIdcaja, lxMovcajaTipocomp, lxMovcajaMonto, lxMovcajaDescrip, lxMovcajaCotiz
				lxMovcajaFecexpo =  .Fechaexpo			lxMovcajaFaltafw =  .Fechaaltafw			lxMovcajaFecimpo =  .Fechaimpo			lxMovcajaFectrans =  .Fechatransferencia			lxMovcajaFmodifw =  .Fechamodificacionfw			lxMovcajaFechacompr =  .Fechacomprobante			lxMovcajaFecha =  .Fecha			lxMovcajaIdmovi =  .Id			lxMovcajaTipovalor =  .Tipovalor			lxMovcajaPtovta =  .Puntodeventa			lxMovcajaNumcomp =  .Numerocomprobante			lxMovcajaTimestamp = goLibrerias.ObtenerTimestamp()			lxMovcajaHoraimpo =  .Horaimpo			lxMovcajaHoraexpo =  .Horaexpo			lxMovcajaSmodifw =  .Seriemodificacionfw			lxMovcajaHmodifw =  .Horamodificacionfw			lxMovcajaValtafw =  .Versionaltafw			lxMovcajaVmodifw =  .Versionmodificacionfw			lxMovcajaUaltafw =  .Usuarioaltafw			lxMovcajaUmodifw =  .Usuariomodificacionfw			lxMovcajaSaltafw =  .Seriealtafw			lxMovcajaZadsfw =  .Zadsfw			lxMovcajaItemvalor =  .Itemvalor			lxMovcajaHaltafw =  .Horaaltafw			lxMovcajaEsttrans =  .Estadotransferencia			lxMovcajaTarea =  .Tarea			lxMovcajaBdmodifw =  .Basededatosmodificacionfw			lxMovcajaBdaltafw =  .Basededatosaltafw			lxMovcajaAccion =  .Accion			lxMovcajaFactsec =  .Secuencia			lxMovcajaIdvendedor =  upper( .Vendedor_PK ) 			lxMovcajaTurno =  .Turno			lxMovcajaIdcajaaudi =  .Cajaauditoria_PK 			lxMovcajaFechacaja =  .Fechacaja			lxMovcajaHora =  .Hora			lxMovcajaIdvalor =  upper( .Valor_PK ) 			lxMovcajaIdcaja =  .Cajaestado_PK 			lxMovcajaTipocomp =  .Tipocomprobante			lxMovcajaMonto =  .Monto			lxMovcajaDescrip =  .Descripcion			lxMovcajaCotiz =  .Cotizacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.MOVCAJA ( "Fecexpo","Faltafw","Fecimpo","Fectrans","Fmodifw","Fechacompr","Fecha","Idmovi","Tipovalor","Ptovta","Numcomp","Timestamp","Horaimpo","Horaexpo","Smodifw","Hmodifw","Valtafw","Vmodifw","Ualtafw","Umodifw","Saltafw","Zadsfw","Itemvalor","Haltafw","Esttrans","Tarea","Bdmodifw","Bdaltafw","Accion","Factsec","Idvendedor","Turno","Idcajaaudi","Fechacaja","Hora","Idvalor","Idcaja","Tipocomp","Monto","Descrip","Cotiz" ) values ( <<"'" + this.ConvertirDateSql( lxMovcajaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovcajaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovcajaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovcajaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovcajaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovcajaFechacompr ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovcajaFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaIdmovi ) + "'" >>, <<lxMovcajaTipovalor >>, <<lxMovcajaPtovta >>, <<lxMovcajaNumcomp >>, <<lxMovcajaTimestamp >>, <<"'" + this.FormatearTextoSql( lxMovcajaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaItemvalor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaTarea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaAccion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaFactsec ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaIdvendedor ) + "'" >>, <<lxMovcajaTurno >>, <<lxMovcajaIdcajaaudi >>, <<"'" + this.ConvertirDateSql( lxMovcajaFechacaja ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaHora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovcajaIdvalor ) + "'" >>, <<lxMovcajaIdcaja >>, <<"'" + this.FormatearTextoSql( lxMovcajaTipocomp ) + "'" >>, <<lxMovcajaMonto >>, <<"'" + this.FormatearTextoSql( lxMovcajaDescrip ) + "'" >>, <<lxMovcajaCotiz >> )
		endtext
		loColeccion.cTabla = 'MOVCAJA' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.ID + "'"
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxMovcajaFecexpo, lxMovcajaFaltafw, lxMovcajaFecimpo, lxMovcajaFectrans, lxMovcajaFmodifw, lxMovcajaFechacompr, lxMovcajaFecha, lxMovcajaIdmovi, lxMovcajaTipovalor, lxMovcajaPtovta, lxMovcajaNumcomp, lxMovcajaTimestamp, lxMovcajaHoraimpo, lxMovcajaHoraexpo, lxMovcajaSmodifw, lxMovcajaHmodifw, lxMovcajaValtafw, lxMovcajaVmodifw, lxMovcajaUaltafw, lxMovcajaUmodifw, lxMovcajaSaltafw, lxMovcajaZadsfw, lxMovcajaItemvalor, lxMovcajaHaltafw, lxMovcajaEsttrans, lxMovcajaTarea, lxMovcajaBdmodifw, lxMovcajaBdaltafw, lxMovcajaAccion, lxMovcajaFactsec, lxMovcajaIdvendedor, lxMovcajaTurno, lxMovcajaIdcajaaudi, lxMovcajaFechacaja, lxMovcajaHora, lxMovcajaIdvalor, lxMovcajaIdcaja, lxMovcajaTipocomp, lxMovcajaMonto, lxMovcajaDescrip, lxMovcajaCotiz
				lxMovcajaFecexpo =  .Fechaexpo			lxMovcajaFaltafw =  .Fechaaltafw			lxMovcajaFecimpo =  .Fechaimpo			lxMovcajaFectrans =  .Fechatransferencia			lxMovcajaFmodifw =  .Fechamodificacionfw			lxMovcajaFechacompr =  .Fechacomprobante			lxMovcajaFecha =  .Fecha			lxMovcajaIdmovi =  .Id			lxMovcajaTipovalor =  .Tipovalor			lxMovcajaPtovta =  .Puntodeventa			lxMovcajaNumcomp =  .Numerocomprobante			lxMovcajaTimestamp = goLibrerias.ObtenerTimestamp()			lxMovcajaHoraimpo =  .Horaimpo			lxMovcajaHoraexpo =  .Horaexpo			lxMovcajaSmodifw =  .Seriemodificacionfw			lxMovcajaHmodifw =  .Horamodificacionfw			lxMovcajaValtafw =  .Versionaltafw			lxMovcajaVmodifw =  .Versionmodificacionfw			lxMovcajaUaltafw =  .Usuarioaltafw			lxMovcajaUmodifw =  .Usuariomodificacionfw			lxMovcajaSaltafw =  .Seriealtafw			lxMovcajaZadsfw =  .Zadsfw			lxMovcajaItemvalor =  .Itemvalor			lxMovcajaHaltafw =  .Horaaltafw			lxMovcajaEsttrans =  .Estadotransferencia			lxMovcajaTarea =  .Tarea			lxMovcajaBdmodifw =  .Basededatosmodificacionfw			lxMovcajaBdaltafw =  .Basededatosaltafw			lxMovcajaAccion =  .Accion			lxMovcajaFactsec =  .Secuencia			lxMovcajaIdvendedor =  upper( .Vendedor_PK ) 			lxMovcajaTurno =  .Turno			lxMovcajaIdcajaaudi =  .Cajaauditoria_PK 			lxMovcajaFechacaja =  .Fechacaja			lxMovcajaHora =  .Hora			lxMovcajaIdvalor =  upper( .Valor_PK ) 			lxMovcajaIdcaja =  .Cajaestado_PK 			lxMovcajaTipocomp =  .Tipocomprobante			lxMovcajaMonto =  .Monto			lxMovcajaDescrip =  .Descripcion			lxMovcajaCotiz =  .Cotizacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ID
			lcValorClavePrimariaString = "'" + this.oEntidad.ID + "'"

			lcFiltro = ["Idmovi" = ] + lcValorClavePrimariaString  + [ and  MOVCAJA.IDMOVI != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.MOVCAJA set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxMovcajaFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxMovcajaFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxMovcajaFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxMovcajaFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxMovcajaFmodifw ) + "'">>, "Fechacompr" = <<"'" + this.ConvertirDateSql( lxMovcajaFechacompr ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxMovcajaFecha ) + "'">>, "Idmovi" = <<"'" + this.FormatearTextoSql( lxMovcajaIdmovi ) + "'">>, "Tipovalor" = <<lxMovcajaTipovalor>>, "Ptovta" = <<lxMovcajaPtovta>>, "Numcomp" = <<lxMovcajaNumcomp>>, "Timestamp" = <<lxMovcajaTimestamp>>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxMovcajaHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxMovcajaHoraexpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxMovcajaSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxMovcajaHmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxMovcajaValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxMovcajaVmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxMovcajaUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxMovcajaUmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxMovcajaSaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxMovcajaZadsfw ) + "'">>, "Itemvalor" = <<"'" + this.FormatearTextoSql( lxMovcajaItemvalor ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxMovcajaHaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxMovcajaEsttrans ) + "'">>, "Tarea" = <<"'" + this.FormatearTextoSql( lxMovcajaTarea ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxMovcajaBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxMovcajaBdaltafw ) + "'">>, "Accion" = <<"'" + this.FormatearTextoSql( lxMovcajaAccion ) + "'">>, "Factsec" = <<"'" + this.FormatearTextoSql( lxMovcajaFactsec ) + "'">>, "Idvendedor" = <<"'" + this.FormatearTextoSql( lxMovcajaIdvendedor ) + "'">>, "Turno" = <<lxMovcajaTurno>>, "Idcajaaudi" = <<lxMovcajaIdcajaaudi>>, "Fechacaja" = <<"'" + this.ConvertirDateSql( lxMovcajaFechacaja ) + "'">>, "Hora" = <<"'" + this.FormatearTextoSql( lxMovcajaHora ) + "'">>, "Idvalor" = <<"'" + this.FormatearTextoSql( lxMovcajaIdvalor ) + "'">>, "Idcaja" = <<lxMovcajaIdcaja>>, "Tipocomp" = <<"'" + this.FormatearTextoSql( lxMovcajaTipocomp ) + "'">>, "Monto" = <<lxMovcajaMonto>>, "Descrip" = <<"'" + this.FormatearTextoSql( lxMovcajaDescrip ) + "'">>, "Cotiz" = <<lxMovcajaCotiz>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'MOVCAJA' 
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
			lxValorClavePrimaria = this.oEntidad.ID
			lcValorClavePrimariaString = "'" + this.oEntidad.ID + "'"

			lcFiltro = ["Idmovi" = ] + lcValorClavePrimariaString  + [ and  MOVCAJA.IDMOVI != '']
		loColeccion.Agregar( 'delete from ZooLogic.MOVCAJA where ' + lcFiltro )
			loColeccion.cTabla = 'MOVCAJA' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.MOVCAJA where  MOVCAJA.IDMOVI != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.MOVCAJA where IdMovi = " + "'" + this.FormatearTextoSql( this.oEntidad.ID ) + "'"+ " and  MOVCAJA.IDMOVI != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MOVIMIENTODECAJA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.MOVCAJA Where IdMovi = ] + "'" + this.FormatearTextoSql( &lcCursor..IdMovi ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() 
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.MOVCAJA set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FechaCompr = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaCompr ) + "'"+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, IdMovi = ] + "'" + this.FormatearTextoSql( &lcCursor..IdMovi ) + "'"+ [, TipoValor = ] + transform( &lcCursor..TipoValor )+ [, PtoVta = ] + transform( &lcCursor..PtoVta )+ [, NumComp = ] + transform( &lcCursor..NumComp )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, ItemValor = ] + "'" + this.FormatearTextoSql( &lcCursor..ItemValor ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Tarea = ] + "'" + this.FormatearTextoSql( &lcCursor..Tarea ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Accion = ] + "'" + this.FormatearTextoSql( &lcCursor..Accion ) + "'"+ [, FactSec = ] + "'" + this.FormatearTextoSql( &lcCursor..FactSec ) + "'"+ [, IdVendedor = ] + "'" + this.FormatearTextoSql( &lcCursor..IdVendedor ) + "'"+ [, Turno = ] + transform( &lcCursor..Turno )+ [, IdCajaAudi = ] + transform( &lcCursor..IdCajaAudi )+ [, FechaCaja = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaCaja ) + "'"+ [, Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'"+ [, idValor = ] + "'" + this.FormatearTextoSql( &lcCursor..idValor ) + "'"+ [, IDCaja = ] + transform( &lcCursor..IDCaja )+ [, TipoComp = ] + "'" + this.FormatearTextoSql( &lcCursor..TipoComp ) + "'"+ [, Monto = ] + transform( &lcCursor..Monto )+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, Cotiz = ] + transform( &lcCursor..Cotiz ) + [ Where IdMovi = ] + "'" + this.FormatearTextoSql( &lcCursor..IdMovi ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FALTAFW, FECIMPO, FECTRANS, FMODIFW, FechaCompr, Fecha, IdMovi, TipoValor, PtoVta, NumComp, TIMESTAMP, HORAIMPO, HORAEXPO, SMODIFW, HMODIFW, VALTAFW, VMODIFW, UALTAFW, UMODIFW, SALTAFW, ZADSFW, ItemValor, HALTAFW, ESTTRANS, Tarea, BDMODIFW, BDALTAFW, Accion, FactSec, IdVendedor, Turno, IdCajaAudi, FechaCaja, Hora, idValor, IDCaja, TipoComp, Monto, Descrip, Cotiz
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaCompr ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdMovi ) + "'" + ',' + transform( &lcCursor..TipoValor ) + ',' + transform( &lcCursor..PtoVta ) + ',' + transform( &lcCursor..NumComp ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ItemValor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Tarea ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Accion ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FactSec ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdVendedor ) + "'" + ',' + transform( &lcCursor..Turno ) + ',' + transform( &lcCursor..IdCajaAudi ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaCaja ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..idValor ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..IDCaja ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipoComp ) + "'" + ',' + transform( &lcCursor..Monto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + ',' + transform( &lcCursor..Cotiz )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.MOVCAJA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MOVIMIENTODECAJA'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( IdMovi C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Nº Interno: ' + transform( &tcCursor..IdMovi     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'MOVIMIENTODECAJA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MOVIMIENTODECAJA_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_MovCaja')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'MOVIMIENTODECAJA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..IdMovi
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad MOVIMIENTODECAJA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MOVIMIENTODECAJA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,IdMovi as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( IdMovi, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MOVIMIENTODECAJA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FechaCompr
		* Validar ANTERIORES A 1/1/1753  Fecha     
		* Validar ANTERIORES A 1/1/1753  FechaCaja 
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MovCaja') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MovCaja
Create Table ZooLogic.TablaTrabajo_MovCaja ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fechacompr" datetime  null, 
"fecha" datetime  null, 
"idmovi" char( 38 )  null, 
"tipovalor" numeric( 2, 0 )  null, 
"ptovta" numeric( 4, 0 )  null, 
"numcomp" numeric( 9, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"itemvalor" char( 38 )  null, 
"haltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"tarea" char( 50 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"accion" char( 1 )  null, 
"factsec" char( 2 )  null, 
"idvendedor" char( 5 )  null, 
"turno" numeric( 1, 0 )  null, 
"idcajaaudi" numeric( 10, 0 )  null, 
"fechacaja" datetime  null, 
"hora" char( 8 )  null, 
"idvalor" char( 5 )  null, 
"idcaja" numeric( 2, 0 )  null, 
"tipocomp" char( 2 )  null, 
"monto" numeric( 16, 2 )  null, 
"descrip" char( 50 )  null, 
"cotiz" numeric( 16, 5 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_MovCaja' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_MovCaja' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MOVIMIENTODECAJA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fechacompr','fechacompr')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('idmovi','idmovi')
			.AgregarMapeo('tipovalor','tipovalor')
			.AgregarMapeo('ptovta','ptovta')
			.AgregarMapeo('numcomp','numcomp')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('itemvalor','itemvalor')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('tarea','tarea')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('accion','accion')
			.AgregarMapeo('factsec','factsec')
			.AgregarMapeo('idvendedor','idvendedor')
			.AgregarMapeo('turno','turno')
			.AgregarMapeo('idcajaaudi','idcajaaudi')
			.AgregarMapeo('fechacaja','fechacaja')
			.AgregarMapeo('hora','hora')
			.AgregarMapeo('idvalor','idvalor')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('tipocomp','tipocomp')
			.AgregarMapeo('monto','monto')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('cotiz','cotiz')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_MovCaja'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECHACOMPR = isnull( d.FECHACOMPR, t.FECHACOMPR ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.IDMOVI = isnull( d.IDMOVI, t.IDMOVI ),t.TIPOVALOR = isnull( d.TIPOVALOR, t.TIPOVALOR ),t.PTOVTA = isnull( d.PTOVTA, t.PTOVTA ),t.NUMCOMP = isnull( d.NUMCOMP, t.NUMCOMP ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.ITEMVALOR = isnull( d.ITEMVALOR, t.ITEMVALOR ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.TAREA = isnull( d.TAREA, t.TAREA ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ACCION = isnull( d.ACCION, t.ACCION ),t.FACTSEC = isnull( d.FACTSEC, t.FACTSEC ),t.IDVENDEDOR = isnull( d.IDVENDEDOR, t.IDVENDEDOR ),t.TURNO = isnull( d.TURNO, t.TURNO ),t.IDCAJAAUDI = isnull( d.IDCAJAAUDI, t.IDCAJAAUDI ),t.FECHACAJA = isnull( d.FECHACAJA, t.FECHACAJA ),t.HORA = isnull( d.HORA, t.HORA ),t.IDVALOR = isnull( d.IDVALOR, t.IDVALOR ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.TIPOCOMP = isnull( d.TIPOCOMP, t.TIPOCOMP ),t.MONTO = isnull( d.MONTO, t.MONTO ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.COTIZ = isnull( d.COTIZ, t.COTIZ )
					from ZooLogic.MOVCAJA t inner join deleted d 
							 on t.IdMovi = d.IdMovi
				-- Fin Updates
				insert into ZooLogic.MOVCAJA(Fecexpo,Faltafw,Fecimpo,Fectrans,Fmodifw,Fechacompr,Fecha,Idmovi,Tipovalor,Ptovta,Numcomp,Timestamp,Horaimpo,Horaexpo,Smodifw,Hmodifw,Valtafw,Vmodifw,Ualtafw,Umodifw,Saltafw,Zadsfw,Itemvalor,Haltafw,Esttrans,Tarea,Bdmodifw,Bdaltafw,Accion,Factsec,Idvendedor,Turno,Idcajaaudi,Fechacaja,Hora,Idvalor,Idcaja,Tipocomp,Monto,Descrip,Cotiz)
					Select isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECHACOMPR,''),isnull( d.FECHA,''),isnull( d.IDMOVI,''),isnull( d.TIPOVALOR,0),isnull( d.PTOVTA,0),isnull( d.NUMCOMP,0),isnull( d.TIMESTAMP,0),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SALTAFW,''),isnull( d.ZADSFW,''),isnull( d.ITEMVALOR,''),convert( char(8), getdate(), 108 ),isnull( d.ESTTRANS,''),isnull( d.TAREA,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ACCION,''),isnull( d.FACTSEC,''),isnull( d.IDVENDEDOR,''),isnull( d.TURNO,0),isnull( d.IDCAJAAUDI,0),isnull( d.FECHACAJA,''),isnull( d.HORA,''),isnull( d.IDVALOR,''),isnull( d.IDCAJA,0),isnull( d.TIPOCOMP,''),isnull( d.MONTO,0),isnull( d.DESCRIP,''),isnull( d.COTIZ,0)
						From deleted d left join ZooLogic.MOVCAJA pk 
							 on d.IdMovi = pk.IdMovi
						Where pk.IdMovi Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MovCaja') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MovCaja
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_MOVIMIENTODECAJA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MOVIMIENTODECAJA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MOVIMIENTODECAJA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MOVIMIENTODECAJA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_MOVIMIENTODECAJA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MOVIMIENTODECAJA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechacomprobante = GoLibrerias.ObtenerFechaFormateada( nvl( c_MOVIMIENTODECAJA.Fechacomprobante, ctod( '  /  /    ' ) ) )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_MOVIMIENTODECAJA.Fecha, ctod( '  /  /    ' ) ) )
					.Id = nvl( c_MOVIMIENTODECAJA.Id, [] )
					.Tipovalor = nvl( c_MOVIMIENTODECAJA.Tipovalor, 0 )
					.Puntodeventa = nvl( c_MOVIMIENTODECAJA.Puntodeventa, 0 )
					.Numerocomprobante = nvl( c_MOVIMIENTODECAJA.Numerocomprobante, 0 )
					.Timestamp = nvl( c_MOVIMIENTODECAJA.Timestamp, 0 )
					.Horaimpo = nvl( c_MOVIMIENTODECAJA.Horaimpo, [] )
					.Horaexpo = nvl( c_MOVIMIENTODECAJA.Horaexpo, [] )
					.Seriemodificacionfw = nvl( c_MOVIMIENTODECAJA.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_MOVIMIENTODECAJA.Horamodificacionfw, [] )
					.Versionaltafw = nvl( c_MOVIMIENTODECAJA.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_MOVIMIENTODECAJA.Versionmodificacionfw, [] )
					.Usuarioaltafw = nvl( c_MOVIMIENTODECAJA.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_MOVIMIENTODECAJA.Usuariomodificacionfw, [] )
					.Seriealtafw = nvl( c_MOVIMIENTODECAJA.Seriealtafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Itemvalor = nvl( c_MOVIMIENTODECAJA.Itemvalor, [] )
					.Horaaltafw = nvl( c_MOVIMIENTODECAJA.Horaaltafw, [] )
					.Estadotransferencia = nvl( c_MOVIMIENTODECAJA.Estadotransferencia, [] )
					.Tarea = nvl( c_MOVIMIENTODECAJA.Tarea, [] )
					.Basededatosmodificacionfw = nvl( c_MOVIMIENTODECAJA.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_MOVIMIENTODECAJA.Basededatosaltafw, [] )
					.Accion = nvl( c_MOVIMIENTODECAJA.Accion, [] )
					.Secuencia = nvl( c_MOVIMIENTODECAJA.Secuencia, [] )
					.Vendedor_PK =  nvl( c_MOVIMIENTODECAJA.Vendedor, [] )
					.Turno = nvl( c_MOVIMIENTODECAJA.Turno, 0 )
					.Cajaauditoria_PK =  nvl( c_MOVIMIENTODECAJA.Cajaauditoria, 0 )
					.Fechacaja = GoLibrerias.ObtenerFechaFormateada( nvl( c_MOVIMIENTODECAJA.Fechacaja, ctod( '  /  /    ' ) ) )
					.Hora = nvl( c_MOVIMIENTODECAJA.Hora, [] )
					.Valor_PK =  nvl( c_MOVIMIENTODECAJA.Valor, [] )
					.Cajaestado_PK =  nvl( c_MOVIMIENTODECAJA.Cajaestado, 0 )
					.Tipocomprobante = nvl( c_MOVIMIENTODECAJA.Tipocomprobante, [] )
					.Monto = nvl( c_MOVIMIENTODECAJA.Monto, 0 )
					.Descripcion = nvl( c_MOVIMIENTODECAJA.Descripcion, [] )
					.Cotizacion = nvl( c_MOVIMIENTODECAJA.Cotizacion, 0 )
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
		return c_MOVIMIENTODECAJA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.MOVCAJA' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "IdMovi"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,IdMovi as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    IdMovi from (
							select * 
								from ZooLogic.MOVCAJA 
								Where   MOVCAJA.IDMOVI != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "MOVCAJA", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "IdMovi"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fechacompr" as "Fechacomprobante", "Fecha" as "Fecha", "Idmovi" as "Id", "Tipovalor" as "Tipovalor", "Ptovta" as "Puntodeventa", "Numcomp" as "Numerocomprobante", "Timestamp" as "Timestamp", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Itemvalor" as "Itemvalor", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Tarea" as "Tarea", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Accion" as "Accion", "Factsec" as "Secuencia", "Idvendedor" as "Vendedor", "Turno" as "Turno", "Idcajaaudi" as "Cajaauditoria", "Fechacaja" as "Fechacaja", "Hora" as "Hora", "Idvalor" as "Valor", "Idcaja" as "Cajaestado", "Tipocomp" as "Tipocomprobante", "Monto" as "Monto", "Descrip" as "Descripcion", "Cotiz" as "Cotizacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.MOVCAJA 
								Where   MOVCAJA.IDMOVI != ''
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
	Tabla = 'MOVCAJA'
	Filtro = " MOVCAJA.IDMOVI != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " MOVCAJA.IDMOVI != ''"
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
	<row entidad="MOVIMIENTODECAJA                        " atributo="FECHAEXPO                               " tabla="MOVCAJA        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="FECHAALTAFW                             " tabla="MOVCAJA        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="FECHAIMPO                               " tabla="MOVCAJA        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="FECHATRANSFERENCIA                      " tabla="MOVCAJA        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="FECHAMODIFICACIONFW                     " tabla="MOVCAJA        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="FECHACOMPROBANTE                        " tabla="MOVCAJA        " campo="FECHACOMPR" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha Comprobante                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="FECHA                                   " tabla="MOVCAJA        " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="4" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="ID                                      " tabla="MOVCAJA        " campo="IDMOVI    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Nº Interno                                                                                                                                                      " dominio="CODIGONUMERICODESHABILITADO   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="TIPOVALOR                               " tabla="MOVCAJA        " campo="TIPOVALOR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="PUNTODEVENTA                            " tabla="MOVCAJA        " campo="PTOVTA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Punto de Venta                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="NUMEROCOMPROBANTE                       " tabla="MOVCAJA        " campo="NUMCOMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Numero Comprobante                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="TIMESTAMP                               " tabla="MOVCAJA        " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="HORAIMPO                                " tabla="MOVCAJA        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="HORAEXPO                                " tabla="MOVCAJA        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="SERIEMODIFICACIONFW                     " tabla="MOVCAJA        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="HORAMODIFICACIONFW                      " tabla="MOVCAJA        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="VERSIONALTAFW                           " tabla="MOVCAJA        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="VERSIONMODIFICACIONFW                   " tabla="MOVCAJA        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="USUARIOALTAFW                           " tabla="MOVCAJA        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="USUARIOMODIFICACIONFW                   " tabla="MOVCAJA        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="SERIEALTAFW                             " tabla="MOVCAJA        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="ZADSFW                                  " tabla="MOVCAJA        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="ITEMVALOR                               " tabla="MOVCAJA        " campo="ITEMVALOR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Item valor                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="HORAALTAFW                              " tabla="MOVCAJA        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="ESTADOTRANSFERENCIA                     " tabla="MOVCAJA        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="TAREA                                   " tabla="MOVCAJA        " campo="TAREA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tarea                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="MOVCAJA        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="BASEDEDATOSALTAFW                       " tabla="MOVCAJA        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="ACCION                                  " tabla="MOVCAJA        " campo="ACCION    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Accion                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="SECUENCIA                               " tabla="MOVCAJA        " campo="FACTSEC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Secuencia                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="VENDEDOR                                " tabla="MOVCAJA        " campo="IDVENDEDOR" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="TURNO                                   " tabla="MOVCAJA        " campo="TURNO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="@ObtenerTurno()                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="0" etiqueta="Turno                                                                                                                                                           " dominio="TURNO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="CAJAAUDITORIA                           " tabla="MOVCAJA        " campo="IDCAJAAUDI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAAUDITORIA                           " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Caja Auditoría                                                                                                                                                  " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="FECHACAJA                               " tabla="MOVCAJA        " campo="FECHACAJA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="402" etiqueta="Fecha de caja                                                                                                                                                   " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="HORA                                    " tabla="MOVCAJA        " campo="HORA      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="404" etiqueta="Hora                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="VALOR                                   " tabla="MOVCAJA        " campo="IDVALOR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="406" etiqueta="Valor                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="CAJAESTADO                              " tabla="MOVCAJA        " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Número de Caja                                                                                                                                                  " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="TIPOCOMPROBANTE                         " tabla="MOVCAJA        " campo="TIPOCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="410" etiqueta="Tipo Comprobante                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="MONTO                                   " tabla="MOVCAJA        " campo="MONTO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Monto                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="DESCRIPCION                             " tabla="MOVCAJA        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTODECAJA                        " atributo="COTIZACION                              " tabla="MOVCAJA        " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="416" etiqueta="Cotización                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On MOVCAJA.IDVENDEDOR = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCRIPCION                             " tabla="XVALORES       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Val.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join XVALORES On MOVCAJA.IDVALOR = XVALORES.CLCOD And  XVALORES.CLCOD != '' AND XVALORES.CLCOD != ''                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="DESCRIPCION                             " tabla="CAJAESTA       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Núm.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CAJAESTA On MOVCAJA.IDCAJA = CAJAESTA.NumCaja And  CAJAESTA.NUMCAJA != 0                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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