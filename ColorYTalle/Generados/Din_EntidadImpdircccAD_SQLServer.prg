
define class Din_EntidadIMPDIRCCCAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_IMPDIRCCC'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_IDZPK'
	cTablaPrincipal = 'IMPDIRCCC'
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
			local  lxImpdircccFecimpo, lxImpdircccFectrans, lxImpdircccFmodifw, lxImpdircccFaltafw, lxImpdircccFecexpo, lxImpdircccUmodifw, lxImpdircccValtafw, lxImpdircccHaltafw, lxImpdircccHoraimpo, lxImpdircccHoraexpo, lxImpdircccVmodifw, lxImpdircccSaltafw, lxImpdircccUaltafw, lxImpdircccZadsfw, lxImpdircccSmodifw, lxImpdircccBdaltafw, lxImpdircccEsttrans, lxImpdircccBdmodifw, lxImpdircccHmodifw, lxImpdircccObs, lxImpdircccNumero, lxImpdircccDescripcio, lxImpdircccCondesde, lxImpdircccConhasta, lxImpdircccCladesde, lxImpdircccClahasta, lxImpdircccCcosto, lxImpdircccDccosto, lxImpdircccImportanci
				lxImpdircccFecimpo =  .Fechaimpo			lxImpdircccFectrans =  .Fechatransferencia			lxImpdircccFmodifw =  .Fechamodificacionfw			lxImpdircccFaltafw =  .Fechaaltafw			lxImpdircccFecexpo =  .Fechaexpo			lxImpdircccUmodifw =  .Usuariomodificacionfw			lxImpdircccValtafw =  .Versionaltafw			lxImpdircccHaltafw =  .Horaaltafw			lxImpdircccHoraimpo =  .Horaimpo			lxImpdircccHoraexpo =  .Horaexpo			lxImpdircccVmodifw =  .Versionmodificacionfw			lxImpdircccSaltafw =  .Seriealtafw			lxImpdircccUaltafw =  .Usuarioaltafw			lxImpdircccZadsfw =  .Zadsfw			lxImpdircccSmodifw =  .Seriemodificacionfw			lxImpdircccBdaltafw =  .Basededatosaltafw			lxImpdircccEsttrans =  .Estadotransferencia			lxImpdircccBdmodifw =  .Basededatosmodificacionfw			lxImpdircccHmodifw =  .Horamodificacionfw			lxImpdircccObs =  .Observacion			lxImpdircccNumero =  .Numero			lxImpdircccDescripcio =  .Descripcion			lxImpdircccCondesde =  upper( .f_Concepto_Desde_PK ) 			lxImpdircccConhasta =  upper( .f_Concepto_Hasta_PK ) 			lxImpdircccCladesde =  upper( .f_Clasificacion_Desde_PK ) 			lxImpdircccClahasta =  upper( .f_Clasificacion_Hasta_PK ) 			lxImpdircccCcosto =  upper( .CentroDeCosto_PK ) 			lxImpdircccDccosto =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxImpdircccImportanci =  .Importancia
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxImpdircccNumero = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.IMPDIRCCC ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Umodifw","Valtafw","Haltafw","Horaimpo","Horaexpo","Vmodifw","Saltafw","Ualtafw","Zadsfw","Smodifw","Bdaltafw","Esttrans","Bdmodifw","Hmodifw","Obs","Numero","Descripcio","Condesde","Conhasta","Cladesde","Clahasta","Ccosto","Dccosto","Importanci" ) values ( <<"'" + this.ConvertirDateSql( lxImpdircccFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircccFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircccFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircccFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircccFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccObs ) + "'" >>, <<lxImpdircccNumero >>, <<"'" + this.FormatearTextoSql( lxImpdircccDescripcio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccCondesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccConhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccCladesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccClahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccCcosto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccDccosto ) + "'" >>, <<lxImpdircccImportanci >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
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
		return this.oEntidad.NUMERO
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxImpdircccFecimpo, lxImpdircccFectrans, lxImpdircccFmodifw, lxImpdircccFaltafw, lxImpdircccFecexpo, lxImpdircccUmodifw, lxImpdircccValtafw, lxImpdircccHaltafw, lxImpdircccHoraimpo, lxImpdircccHoraexpo, lxImpdircccVmodifw, lxImpdircccSaltafw, lxImpdircccUaltafw, lxImpdircccZadsfw, lxImpdircccSmodifw, lxImpdircccBdaltafw, lxImpdircccEsttrans, lxImpdircccBdmodifw, lxImpdircccHmodifw, lxImpdircccObs, lxImpdircccNumero, lxImpdircccDescripcio, lxImpdircccCondesde, lxImpdircccConhasta, lxImpdircccCladesde, lxImpdircccClahasta, lxImpdircccCcosto, lxImpdircccDccosto, lxImpdircccImportanci
				lxImpdircccFecimpo =  .Fechaimpo			lxImpdircccFectrans =  .Fechatransferencia			lxImpdircccFmodifw =  .Fechamodificacionfw			lxImpdircccFaltafw =  .Fechaaltafw			lxImpdircccFecexpo =  .Fechaexpo			lxImpdircccUmodifw =  .Usuariomodificacionfw			lxImpdircccValtafw =  .Versionaltafw			lxImpdircccHaltafw =  .Horaaltafw			lxImpdircccHoraimpo =  .Horaimpo			lxImpdircccHoraexpo =  .Horaexpo			lxImpdircccVmodifw =  .Versionmodificacionfw			lxImpdircccSaltafw =  .Seriealtafw			lxImpdircccUaltafw =  .Usuarioaltafw			lxImpdircccZadsfw =  .Zadsfw			lxImpdircccSmodifw =  .Seriemodificacionfw			lxImpdircccBdaltafw =  .Basededatosaltafw			lxImpdircccEsttrans =  .Estadotransferencia			lxImpdircccBdmodifw =  .Basededatosmodificacionfw			lxImpdircccHmodifw =  .Horamodificacionfw			lxImpdircccObs =  .Observacion			lxImpdircccNumero =  .Numero			lxImpdircccDescripcio =  .Descripcion			lxImpdircccCondesde =  upper( .f_Concepto_Desde_PK ) 			lxImpdircccConhasta =  upper( .f_Concepto_Hasta_PK ) 			lxImpdircccCladesde =  upper( .f_Clasificacion_Desde_PK ) 			lxImpdircccClahasta =  upper( .f_Clasificacion_Hasta_PK ) 			lxImpdircccCcosto =  upper( .CentroDeCosto_PK ) 			lxImpdircccDccosto =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxImpdircccImportanci =  .Importancia
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.NUMERO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.IMPDIRCCC set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpdircccFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxImpdircccFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpdircccFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxImpdircccFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpdircccFecexpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxImpdircccUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxImpdircccValtafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxImpdircccHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpdircccHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpdircccHoraexpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpdircccVmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxImpdircccSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpdircccUaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpdircccZadsfw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxImpdircccSmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpdircccBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxImpdircccEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpdircccBdmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpdircccHmodifw ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxImpdircccObs ) + "'">>,"Numero" = <<lxImpdircccNumero>>,"Descripcio" = <<"'" + this.FormatearTextoSql( lxImpdircccDescripcio ) + "'">>,"Condesde" = <<"'" + this.FormatearTextoSql( lxImpdircccCondesde ) + "'">>,"Conhasta" = <<"'" + this.FormatearTextoSql( lxImpdircccConhasta ) + "'">>,"Cladesde" = <<"'" + this.FormatearTextoSql( lxImpdircccCladesde ) + "'">>,"Clahasta" = <<"'" + this.FormatearTextoSql( lxImpdircccClahasta ) + "'">>,"Ccosto" = <<"'" + this.FormatearTextoSql( lxImpdircccCcosto ) + "'">>,"Dccosto" = <<"'" + this.FormatearTextoSql( lxImpdircccDccosto ) + "'">>,"Importanci" = <<lxImpdircccImportanci>> where "Numero" = <<lxImpdircccNumero>> and  IMPDIRCCC.NUMERO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 NUMERO from ZooLogic.IMPDIRCCC where " + this.ConvertirFuncionesSql( " IMPDIRCCC.NUMERO != 0" ) )
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
			Local lxImpdircccNumero
			lxImpdircccNumero = .Numero

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Descripcio" as "Descripcion", "Condesde" as "F_concepto_desde", "Conhasta" as "F_concepto_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucionporcentrodecosto", "Importanci" as "Importancia" from ZooLogic.IMPDIRCCC where "Numero" = <<lxImpdircccNumero>> and  IMPDIRCCC.NUMERO != 0
			endtext
			use in select('c_IMPDIRCCC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCCC', set( 'Datasession' ) )

			if reccount( 'c_IMPDIRCCC' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxImpdircccNumero as Variant
		llRetorno = .t.
		lxImpdircccNumero = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.IMPDIRCCC where "Numero" = <<lxImpdircccNumero>> and  IMPDIRCCC.NUMERO != 0
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Descripcio" as "Descripcion", "Condesde" as "F_concepto_desde", "Conhasta" as "F_concepto_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucionporcentrodecosto", "Importanci" as "Importancia" from ZooLogic.IMPDIRCCC where  IMPDIRCCC.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_IMPDIRCCC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCCC', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Descripcio" as "Descripcion", "Condesde" as "F_concepto_desde", "Conhasta" as "F_concepto_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucionporcentrodecosto", "Importanci" as "Importancia" from ZooLogic.IMPDIRCCC where  str( NUMERO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPDIRCCC.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_IMPDIRCCC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCCC', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Descripcio" as "Descripcion", "Condesde" as "F_concepto_desde", "Conhasta" as "F_concepto_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucionporcentrodecosto", "Importanci" as "Importancia" from ZooLogic.IMPDIRCCC where  str( NUMERO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPDIRCCC.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_IMPDIRCCC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCCC', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Descripcio" as "Descripcion", "Condesde" as "F_concepto_desde", "Conhasta" as "F_concepto_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucionporcentrodecosto", "Importanci" as "Importancia" from ZooLogic.IMPDIRCCC where  IMPDIRCCC.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_IMPDIRCCC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCCC', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + transform( .oEntidad.NUMERO )
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Umodifw,Valtafw,Haltafw,Horaimpo,Horaexpo,Vmodifw,S" + ;
"altafw,Ualtafw,Zadsfw,Smodifw,Bdaltafw,Esttrans,Bdmodifw,Hmodifw,Obs,Numero,Descripcio,Condesde,Conh" + ;
"asta,Cladesde,Clahasta,Ccosto,Dccosto,Importanci" + ;
" from ZooLogic.IMPDIRCCC where  IMPDIRCCC.NUMERO != 0 and " + lcFiltro )
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
			local  lxImpdircccFecimpo, lxImpdircccFectrans, lxImpdircccFmodifw, lxImpdircccFaltafw, lxImpdircccFecexpo, lxImpdircccUmodifw, lxImpdircccValtafw, lxImpdircccHaltafw, lxImpdircccHoraimpo, lxImpdircccHoraexpo, lxImpdircccVmodifw, lxImpdircccSaltafw, lxImpdircccUaltafw, lxImpdircccZadsfw, lxImpdircccSmodifw, lxImpdircccBdaltafw, lxImpdircccEsttrans, lxImpdircccBdmodifw, lxImpdircccHmodifw, lxImpdircccObs, lxImpdircccNumero, lxImpdircccDescripcio, lxImpdircccCondesde, lxImpdircccConhasta, lxImpdircccCladesde, lxImpdircccClahasta, lxImpdircccCcosto, lxImpdircccDccosto, lxImpdircccImportanci
				lxImpdircccFecimpo = ctod( '  /  /    ' )			lxImpdircccFectrans = ctod( '  /  /    ' )			lxImpdircccFmodifw = ctod( '  /  /    ' )			lxImpdircccFaltafw = ctod( '  /  /    ' )			lxImpdircccFecexpo = ctod( '  /  /    ' )			lxImpdircccUmodifw = []			lxImpdircccValtafw = []			lxImpdircccHaltafw = []			lxImpdircccHoraimpo = []			lxImpdircccHoraexpo = []			lxImpdircccVmodifw = []			lxImpdircccSaltafw = []			lxImpdircccUaltafw = []			lxImpdircccZadsfw = []			lxImpdircccSmodifw = []			lxImpdircccBdaltafw = []			lxImpdircccEsttrans = []			lxImpdircccBdmodifw = []			lxImpdircccHmodifw = []			lxImpdircccObs = []			lxImpdircccNumero = 0			lxImpdircccDescripcio = []			lxImpdircccCondesde = []			lxImpdircccConhasta = []			lxImpdircccCladesde = []			lxImpdircccClahasta = []			lxImpdircccCcosto = []			lxImpdircccDccosto = []			lxImpdircccImportanci = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.IMPDIRCCC where "NUMERO" = ] + transform( .oEntidad.NUMERO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'IMPDIRCCC' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where NUMERO = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(NUMERO, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  IMPDIRCCC.NUMERO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Descripcio" as "Descripcion", "Condesde" as "F_concepto_desde", "Conhasta" as "F_concepto_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucionporcentrodecosto", "Importanci" as "Importancia"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'IMPDIRCCC', '', tnTope )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIPCIO AS DESCRIPCION'
				Case lcAtributo == 'F_CONCEPTO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDESDE AS F_CONCEPTO_DESDE'
				Case lcAtributo == 'F_CONCEPTO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONHASTA AS F_CONCEPTO_HASTA'
				Case lcAtributo == 'F_CLASIFICACION_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLADESDE AS F_CLASIFICACION_DESDE'
				Case lcAtributo == 'F_CLASIFICACION_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLAHASTA AS F_CLASIFICACION_HASTA'
				Case lcAtributo == 'CENTRODECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOSTO AS CENTRODECOSTO'
				Case lcAtributo == 'DISTRIBUCIONPORCENTRODECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DCCOSTO AS DISTRIBUCIONPORCENTRODECOSTO'
				Case lcAtributo == 'IMPORTANCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPORTANCI AS IMPORTANCIA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIPCIO'
			Case upper( alltrim( tcAtributo ) ) == 'F_CONCEPTO_DESDE'
				lcCampo = 'CONDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_CONCEPTO_HASTA'
				lcCampo = 'CONHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLASIFICACION_DESDE'
				lcCampo = 'CLADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLASIFICACION_HASTA'
				lcCampo = 'CLAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'CENTRODECOSTO'
				lcCampo = 'CCOSTO'
			Case upper( alltrim( tcAtributo ) ) == 'DISTRIBUCIONPORCENTRODECOSTO'
				lcCampo = 'DCCOSTO'
			Case upper( alltrim( tcAtributo ) ) == 'IMPORTANCIA'
				lcCampo = 'IMPORTANCI'
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
			local  lxImpdircccFecimpo, lxImpdircccFectrans, lxImpdircccFmodifw, lxImpdircccFaltafw, lxImpdircccFecexpo, lxImpdircccUmodifw, lxImpdircccValtafw, lxImpdircccHaltafw, lxImpdircccHoraimpo, lxImpdircccHoraexpo, lxImpdircccVmodifw, lxImpdircccSaltafw, lxImpdircccUaltafw, lxImpdircccZadsfw, lxImpdircccSmodifw, lxImpdircccBdaltafw, lxImpdircccEsttrans, lxImpdircccBdmodifw, lxImpdircccHmodifw, lxImpdircccObs, lxImpdircccNumero, lxImpdircccDescripcio, lxImpdircccCondesde, lxImpdircccConhasta, lxImpdircccCladesde, lxImpdircccClahasta, lxImpdircccCcosto, lxImpdircccDccosto, lxImpdircccImportanci
				lxImpdircccFecimpo =  .Fechaimpo			lxImpdircccFectrans =  .Fechatransferencia			lxImpdircccFmodifw =  .Fechamodificacionfw			lxImpdircccFaltafw =  .Fechaaltafw			lxImpdircccFecexpo =  .Fechaexpo			lxImpdircccUmodifw =  .Usuariomodificacionfw			lxImpdircccValtafw =  .Versionaltafw			lxImpdircccHaltafw =  .Horaaltafw			lxImpdircccHoraimpo =  .Horaimpo			lxImpdircccHoraexpo =  .Horaexpo			lxImpdircccVmodifw =  .Versionmodificacionfw			lxImpdircccSaltafw =  .Seriealtafw			lxImpdircccUaltafw =  .Usuarioaltafw			lxImpdircccZadsfw =  .Zadsfw			lxImpdircccSmodifw =  .Seriemodificacionfw			lxImpdircccBdaltafw =  .Basededatosaltafw			lxImpdircccEsttrans =  .Estadotransferencia			lxImpdircccBdmodifw =  .Basededatosmodificacionfw			lxImpdircccHmodifw =  .Horamodificacionfw			lxImpdircccObs =  .Observacion			lxImpdircccNumero =  .Numero			lxImpdircccDescripcio =  .Descripcion			lxImpdircccCondesde =  upper( .f_Concepto_Desde_PK ) 			lxImpdircccConhasta =  upper( .f_Concepto_Hasta_PK ) 			lxImpdircccCladesde =  upper( .f_Clasificacion_Desde_PK ) 			lxImpdircccClahasta =  upper( .f_Clasificacion_Hasta_PK ) 			lxImpdircccCcosto =  upper( .CentroDeCosto_PK ) 			lxImpdircccDccosto =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxImpdircccImportanci =  .Importancia
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.IMPDIRCCC ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Umodifw","Valtafw","Haltafw","Horaimpo","Horaexpo","Vmodifw","Saltafw","Ualtafw","Zadsfw","Smodifw","Bdaltafw","Esttrans","Bdmodifw","Hmodifw","Obs","Numero","Descripcio","Condesde","Conhasta","Cladesde","Clahasta","Ccosto","Dccosto","Importanci" ) values ( <<"'" + this.ConvertirDateSql( lxImpdircccFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircccFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircccFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircccFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircccFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccObs ) + "'" >>, <<lxImpdircccNumero >>, <<"'" + this.FormatearTextoSql( lxImpdircccDescripcio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccCondesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccConhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccCladesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccClahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccCcosto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircccDccosto ) + "'" >>, <<lxImpdircccImportanci >> )
		endtext
		loColeccion.cTabla = 'IMPDIRCCC' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxImpdircccFecimpo, lxImpdircccFectrans, lxImpdircccFmodifw, lxImpdircccFaltafw, lxImpdircccFecexpo, lxImpdircccUmodifw, lxImpdircccValtafw, lxImpdircccHaltafw, lxImpdircccHoraimpo, lxImpdircccHoraexpo, lxImpdircccVmodifw, lxImpdircccSaltafw, lxImpdircccUaltafw, lxImpdircccZadsfw, lxImpdircccSmodifw, lxImpdircccBdaltafw, lxImpdircccEsttrans, lxImpdircccBdmodifw, lxImpdircccHmodifw, lxImpdircccObs, lxImpdircccNumero, lxImpdircccDescripcio, lxImpdircccCondesde, lxImpdircccConhasta, lxImpdircccCladesde, lxImpdircccClahasta, lxImpdircccCcosto, lxImpdircccDccosto, lxImpdircccImportanci
				lxImpdircccFecimpo =  .Fechaimpo			lxImpdircccFectrans =  .Fechatransferencia			lxImpdircccFmodifw =  .Fechamodificacionfw			lxImpdircccFaltafw =  .Fechaaltafw			lxImpdircccFecexpo =  .Fechaexpo			lxImpdircccUmodifw =  .Usuariomodificacionfw			lxImpdircccValtafw =  .Versionaltafw			lxImpdircccHaltafw =  .Horaaltafw			lxImpdircccHoraimpo =  .Horaimpo			lxImpdircccHoraexpo =  .Horaexpo			lxImpdircccVmodifw =  .Versionmodificacionfw			lxImpdircccSaltafw =  .Seriealtafw			lxImpdircccUaltafw =  .Usuarioaltafw			lxImpdircccZadsfw =  .Zadsfw			lxImpdircccSmodifw =  .Seriemodificacionfw			lxImpdircccBdaltafw =  .Basededatosaltafw			lxImpdircccEsttrans =  .Estadotransferencia			lxImpdircccBdmodifw =  .Basededatosmodificacionfw			lxImpdircccHmodifw =  .Horamodificacionfw			lxImpdircccObs =  .Observacion			lxImpdircccNumero =  .Numero			lxImpdircccDescripcio =  .Descripcion			lxImpdircccCondesde =  upper( .f_Concepto_Desde_PK ) 			lxImpdircccConhasta =  upper( .f_Concepto_Hasta_PK ) 			lxImpdircccCladesde =  upper( .f_Clasificacion_Desde_PK ) 			lxImpdircccClahasta =  upper( .f_Clasificacion_Hasta_PK ) 			lxImpdircccCcosto =  upper( .CentroDeCosto_PK ) 			lxImpdircccDccosto =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxImpdircccImportanci =  .Importancia
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  IMPDIRCCC.NUMERO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.IMPDIRCCC set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpdircccFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxImpdircccFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpdircccFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxImpdircccFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpdircccFecexpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxImpdircccUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxImpdircccValtafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxImpdircccHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpdircccHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpdircccHoraexpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpdircccVmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxImpdircccSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpdircccUaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpdircccZadsfw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxImpdircccSmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpdircccBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxImpdircccEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpdircccBdmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpdircccHmodifw ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxImpdircccObs ) + "'">>, "Numero" = <<lxImpdircccNumero>>, "Descripcio" = <<"'" + this.FormatearTextoSql( lxImpdircccDescripcio ) + "'">>, "Condesde" = <<"'" + this.FormatearTextoSql( lxImpdircccCondesde ) + "'">>, "Conhasta" = <<"'" + this.FormatearTextoSql( lxImpdircccConhasta ) + "'">>, "Cladesde" = <<"'" + this.FormatearTextoSql( lxImpdircccCladesde ) + "'">>, "Clahasta" = <<"'" + this.FormatearTextoSql( lxImpdircccClahasta ) + "'">>, "Ccosto" = <<"'" + this.FormatearTextoSql( lxImpdircccCcosto ) + "'">>, "Dccosto" = <<"'" + this.FormatearTextoSql( lxImpdircccDccosto ) + "'">>, "Importanci" = <<lxImpdircccImportanci>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'IMPDIRCCC' 
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
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  IMPDIRCCC.NUMERO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.IMPDIRCCC where ' + lcFiltro )
			loColeccion.cTabla = 'IMPDIRCCC' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.IMPDIRCCC where  IMPDIRCCC.NUMERO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.IMPDIRCCC where NUMERO = " + transform( this.oEntidad.NUMERO )+ " and  IMPDIRCCC.NUMERO != 0" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCCC'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.IMPDIRCCC Where NUMERO = ] + transform( &lcCursor..NUMERO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.IMPDIRCCC set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, OBS = ] + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'"+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, Descripcio = ] + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'"+ [, ConDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ConDesde ) + "'"+ [, ConHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ConHasta ) + "'"+ [, ClaDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ClaDesde ) + "'"+ [, ClaHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ClaHasta ) + "'"+ [, CCosto = ] + "'" + this.FormatearTextoSql( &lcCursor..CCosto ) + "'"+ [, Dccosto = ] + "'" + this.FormatearTextoSql( &lcCursor..Dccosto ) + "'"+ [, Importanci = ] + transform( &lcCursor..Importanci ) + [ Where NUMERO = ] + transform( &lcCursor..NUMERO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FALTAFW, FECEXPO, UMODIFW, VALTAFW, HALTAFW, HORAIMPO, HORAEXPO, VMODIFW, SALTAFW, UALTAFW, ZADSFW, SMODIFW, BDALTAFW, ESTTRANS, BDMODIFW, HMODIFW, OBS, NUMERO, Descripcio, ConDesde, ConHasta, ClaDesde, ClaHasta, CCosto, Dccosto, Importanci
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'" + ',' + transform( &lcCursor..NUMERO )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ConDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ConHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClaDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClaHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CCosto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Dccosto ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Importanci )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.IMPDIRCCC ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCCC'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( NUMERO N (8) , Orden N(16), texto C(80))
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
			Case  lcAlias == lcPrefijo + 'IMPDIRCCC'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPDIRCCC_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPDIRCCC_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_IMPDIRCCC')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'IMPDIRCCC'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..NUMERO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad IMPDIRCCC. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCCC'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,NUMERO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( NUMERO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCCC'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IMPDIRCCC') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IMPDIRCCC
Create Table ZooLogic.TablaTrabajo_IMPDIRCCC ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"smodifw" char( 7 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"obs" varchar(max)  null, 
"numero" numeric( 8, 0 )  null, 
"descripcio" char( 50 )  null, 
"condesde" char( 15 )  null, 
"conhasta" char( 15 )  null, 
"cladesde" char( 15 )  null, 
"clahasta" char( 15 )  null, 
"ccosto" char( 20 )  null, 
"dccosto" char( 20 )  null, 
"importanci" numeric( 5, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_IMPDIRCCC' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_IMPDIRCCC' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCCC'
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
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('descripcio','descripcio')
			.AgregarMapeo('condesde','condesde')
			.AgregarMapeo('conhasta','conhasta')
			.AgregarMapeo('cladesde','cladesde')
			.AgregarMapeo('clahasta','clahasta')
			.AgregarMapeo('ccosto','ccosto')
			.AgregarMapeo('dccosto','dccosto')
			.AgregarMapeo('importanci','importanci')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_IMPDIRCCC'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.OBS = isnull( d.OBS, t.OBS ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.DESCRIPCIO = isnull( d.DESCRIPCIO, t.DESCRIPCIO ),t.CONDESDE = isnull( d.CONDESDE, t.CONDESDE ),t.CONHASTA = isnull( d.CONHASTA, t.CONHASTA ),t.CLADESDE = isnull( d.CLADESDE, t.CLADESDE ),t.CLAHASTA = isnull( d.CLAHASTA, t.CLAHASTA ),t.CCOSTO = isnull( d.CCOSTO, t.CCOSTO ),t.DCCOSTO = isnull( d.DCCOSTO, t.DCCOSTO ),t.IMPORTANCI = isnull( d.IMPORTANCI, t.IMPORTANCI )
					from ZooLogic.IMPDIRCCC t inner join deleted d 
							 on t.NUMERO = d.NUMERO
				-- Fin Updates
				insert into ZooLogic.IMPDIRCCC(Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Umodifw,Valtafw,Haltafw,Horaimpo,Horaexpo,Vmodifw,Saltafw,Ualtafw,Zadsfw,Smodifw,Bdaltafw,Esttrans,Bdmodifw,Hmodifw,Obs,Numero,Descripcio,Condesde,Conhasta,Cladesde,Clahasta,Ccosto,Dccosto,Importanci)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.VMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.ZADSFW,''),isnull( d.SMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.HMODIFW,''),isnull( d.OBS,''),isnull( d.NUMERO,0),isnull( d.DESCRIPCIO,''),isnull( d.CONDESDE,''),isnull( d.CONHASTA,''),isnull( d.CLADESDE,''),isnull( d.CLAHASTA,''),isnull( d.CCOSTO,''),isnull( d.DCCOSTO,''),isnull( d.IMPORTANCI,0)
						From deleted d left join ZooLogic.IMPDIRCCC pk 
							 on d.NUMERO = pk.NUMERO
						Where pk.NUMERO Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IMPDIRCCC') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IMPDIRCCC
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_IMPDIRCCC' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCCC.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCCC.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCCC.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCCC.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCCC.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Usuariomodificacionfw = nvl( c_IMPDIRCCC.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_IMPDIRCCC.Versionaltafw, [] )
					.Horaaltafw = nvl( c_IMPDIRCCC.Horaaltafw, [] )
					.Horaimpo = nvl( c_IMPDIRCCC.Horaimpo, [] )
					.Horaexpo = nvl( c_IMPDIRCCC.Horaexpo, [] )
					.Versionmodificacionfw = nvl( c_IMPDIRCCC.Versionmodificacionfw, [] )
					.Seriealtafw = nvl( c_IMPDIRCCC.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_IMPDIRCCC.Usuarioaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Seriemodificacionfw = nvl( c_IMPDIRCCC.Seriemodificacionfw, [] )
					.Basededatosaltafw = nvl( c_IMPDIRCCC.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_IMPDIRCCC.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_IMPDIRCCC.Basededatosmodificacionfw, [] )
					.Horamodificacionfw = nvl( c_IMPDIRCCC.Horamodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Numero = nvl( c_IMPDIRCCC.Numero, 0 )
					.Descripcion = nvl( c_IMPDIRCCC.Descripcion, [] )
					.F_concepto_desde_PK =  nvl( c_IMPDIRCCC.F_concepto_desde, [] )
					.F_concepto_hasta_PK =  nvl( c_IMPDIRCCC.F_concepto_hasta, [] )
					.F_clasificacion_desde_PK =  nvl( c_IMPDIRCCC.F_clasificacion_desde, [] )
					.F_clasificacion_hasta_PK =  nvl( c_IMPDIRCCC.F_clasificacion_hasta, [] )
					.Centrodecosto_PK =  nvl( c_IMPDIRCCC.Centrodecosto, [] )
					.Distribucionporcentrodecosto_PK =  nvl( c_IMPDIRCCC.Distribucionporcentrodecosto, [] )
					.Importancia = nvl( c_IMPDIRCCC.Importancia, 0 )
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
		return c_IMPDIRCCC.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.IMPDIRCCC' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "NUMERO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,NUMERO as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    NUMERO from (
							select * 
								from ZooLogic.IMPDIRCCC 
								Where   IMPDIRCCC.NUMERO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "IMPDIRCCC", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "NUMERO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Descripcio" as "Descripcion", "Condesde" as "F_concepto_desde", "Conhasta" as "F_concepto_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucionporcentrodecosto", "Importanci" as "Importancia"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.IMPDIRCCC 
								Where   IMPDIRCCC.NUMERO != 0
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
	Tabla = 'IMPDIRCCC'
	Filtro = " IMPDIRCCC.NUMERO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " IMPDIRCCC.NUMERO != 0"
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
										<xsd:maxLength value="250"/>
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
	<row entidad="IMPDIRCCC                               " atributo="FECHAIMPO                               " tabla="IMPDIRCCC      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="FECHATRANSFERENCIA                      " tabla="IMPDIRCCC      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="FECHAMODIFICACIONFW                     " tabla="IMPDIRCCC      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                                                                                                                        " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="FECHAALTAFW                             " tabla="IMPDIRCCC      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="FECHAEXPO                               " tabla="IMPDIRCCC      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="USUARIOMODIFICACIONFW                   " tabla="IMPDIRCCC      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="VERSIONALTAFW                           " tabla="IMPDIRCCC      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="HORAALTAFW                              " tabla="IMPDIRCCC      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="HORAIMPO                                " tabla="IMPDIRCCC      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="HORAEXPO                                " tabla="IMPDIRCCC      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="VERSIONMODIFICACIONFW                   " tabla="IMPDIRCCC      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="SERIEALTAFW                             " tabla="IMPDIRCCC      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="USUARIOALTAFW                           " tabla="IMPDIRCCC      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="ZADSFW                                  " tabla="IMPDIRCCC      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="SERIEMODIFICACIONFW                     " tabla="IMPDIRCCC      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="BASEDEDATOSALTAFW                       " tabla="IMPDIRCCC      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="ESTADOTRANSFERENCIA                     " tabla="IMPDIRCCC      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="IMPDIRCCC      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="HORAMODIFICACIONFW                      " tabla="IMPDIRCCC      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="OBSERVACION                             " tabla="IMPDIRCCC      " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                                                                                                             " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="NUMERO                                  " tabla="IMPDIRCCC      " campo="NUMERO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Número                                                                                                                                                                                                                                                    " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="DESCRIPCION                             " tabla="IMPDIRCCC      " campo="DESCRIPCIO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                                                                                                               " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="F_CONCEPTO_DESDE                        " tabla="IMPDIRCCC      " campo="CONDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONCEPTOPAGO                            " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Concepto desde                                                                                                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="F_CONCEPTO_HASTA                        " tabla="IMPDIRCCC      " campo="CONHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONCEPTOPAGO                            " tipodato="C         " longitud="15" decimales="0" valorsugerido="ZZZZZZZZZZZZZZZ                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="404" etiqueta="Concepto hasta                                                                                                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="F_CLASIFICACION_DESDE                   " tabla="IMPDIRCCC      " campo="CLADESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONCONCEPTOPAGO               " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Clasificación desde                                                                                                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="F_CLASIFICACION_HASTA                   " tabla="IMPDIRCCC      " campo="CLAHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONCONCEPTOPAGO               " tipodato="C         " longitud="15" decimales="0" valorsugerido="ZZZZZZZZZZZZZZZ                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="408" etiqueta="Clasificación hasta                                                                                                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="CENTRODECOSTO                           " tabla="IMPDIRCCC      " campo="CCOSTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CENTRODECOSTO                           " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Centro de costo                                                                                                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="DISTRIBUCIONPORCENTRODECOSTO            " tabla="IMPDIRCCC      " campo="DCCOSTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DISTRIBUCIONCENTRODECOSTO               " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Distribución por c. costo                                                                                                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="19" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCC                               " atributo="IMPORTANCIA                             " tabla="IMPDIRCCC      " campo="IMPORTANCI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Importancia                                                                                                                                                                                                                                               " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONCEPTOPAGO                            " atributo="DESCRIPCION                             " tabla="CONCEPAGO      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="403" etiqueta="Detalle Con.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONCEPAGO On IMPDIRCCC.CONDESDE = CONCEPAGO.Codigo And  CONCEPAGO.CODIGO != ''                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONCEPTOPAGO                            " atributo="DESCRIPCION                             " tabla="CONCEPAGO      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Con.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONCEPAGO On IMPDIRCCC.CONHASTA = CONCEPAGO.Codigo And  CONCEPAGO.CODIGO != ''                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONCONCEPTOPAGO               " atributo="DESCRIPCION                             " tabla="CLASCONCEPAGO  " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Cla.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASCONCEPAGO On IMPDIRCCC.CLADESDE = CLASCONCEPAGO.Codigo And  CLASCONCEPAGO.CODIGO != ''                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONCONCEPTOPAGO               " atributo="DESCRIPCION                             " tabla="CLASCONCEPAGO  " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Cla.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASCONCEPAGO On IMPDIRCCC.CLAHASTA = CLASCONCEPAGO.Codigo And  CLASCONCEPAGO.CODIGO != ''                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CENTRODECOSTO                           " atributo="DESCRIPCION                             " tabla="CCOSTO         " campo="COSDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Cen.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CCOSTO On IMPDIRCCC.CCOSTO = CCOSTO.COSCOD And  CCOSTO.COSCOD != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISTRIBUCIONCENTRODECOSTO               " atributo="DESCRIPCION                             " tabla="DCCOSTO        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Dis.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DCCOSTO On IMPDIRCCC.DCCOSTO = DCCOSTO.Codigo And  DCCOSTO.CODIGO != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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