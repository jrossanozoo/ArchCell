
define class Din_EntidadIMPDIRPROAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_IMPDIRPRO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_IDPPK'
	cTablaPrincipal = 'IMPDIRPRO'
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
			local  lxImpdirproFectrans, lxImpdirproFaltafw, lxImpdirproFmodifw, lxImpdirproFecimpo, lxImpdirproFecexpo, lxImpdirproTimestamp, lxImpdirproHoraexpo, lxImpdirproHaltafw, lxImpdirproHoraimpo, lxImpdirproUaltafw, lxImpdirproVmodifw, lxImpdirproZadsfw, lxImpdirproValtafw, lxImpdirproUmodifw, lxImpdirproSaltafw, lxImpdirproSmodifw, lxImpdirproHmodifw, lxImpdirproBdaltafw, lxImpdirproEsttrans, lxImpdirproBdmodifw, lxImpdirproObs, lxImpdirproNumero, lxImpdirproSitfis, lxImpdirproDescripcio, lxImpdirproProdesde, lxImpdirproProhasta, lxImpdirproVendesde, lxImpdirproVenhasta, lxImpdirproLisdesde, lxImpdirproLishasta, lxImpdirproCladesde, lxImpdirproClahasta, lxImpdirproPrvdesde, lxImpdirproPrvhasta, lxImpdirproPaidesde, lxImpdirproPaihasta, lxImpdirproImpval, lxImpdirproPcuenta, lxImpdirproImportanci
				lxImpdirproFectrans =  .Fechatransferencia			lxImpdirproFaltafw =  .Fechaaltafw			lxImpdirproFmodifw =  .Fechamodificacionfw			lxImpdirproFecimpo =  .Fechaimpo			lxImpdirproFecexpo =  .Fechaexpo			lxImpdirproTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirproHoraexpo =  .Horaexpo			lxImpdirproHaltafw =  .Horaaltafw			lxImpdirproHoraimpo =  .Horaimpo			lxImpdirproUaltafw =  .Usuarioaltafw			lxImpdirproVmodifw =  .Versionmodificacionfw			lxImpdirproZadsfw =  .Zadsfw			lxImpdirproValtafw =  .Versionaltafw			lxImpdirproUmodifw =  .Usuariomodificacionfw			lxImpdirproSaltafw =  .Seriealtafw			lxImpdirproSmodifw =  .Seriemodificacionfw			lxImpdirproHmodifw =  .Horamodificacionfw			lxImpdirproBdaltafw =  .Basededatosaltafw			lxImpdirproEsttrans =  .Estadotransferencia			lxImpdirproBdmodifw =  .Basededatosmodificacionfw			lxImpdirproObs =  .Observacion			lxImpdirproNumero =  .Numero			lxImpdirproSitfis =  .Situacionfiscal			lxImpdirproDescripcio =  .Descripcion			lxImpdirproProdesde =  .F_proveedor_desde			lxImpdirproProhasta =  .F_proveedor_hasta			lxImpdirproVendesde =  .F_vendedor_desde			lxImpdirproVenhasta =  .F_vendedor_hasta			lxImpdirproLisdesde =  .F_lista_desde			lxImpdirproLishasta =  .F_lista_hasta			lxImpdirproCladesde =  .F_clasificacion_desde			lxImpdirproClahasta =  .F_clasificacion_hasta			lxImpdirproPrvdesde =  .F_provincia_desde			lxImpdirproPrvhasta =  .F_provincia_hasta			lxImpdirproPaidesde =  .F_pais_desde			lxImpdirproPaihasta =  .F_pais_hasta			lxImpdirproImpval =  .Imputacion_PK 			lxImpdirproPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirproImportanci =  .Importancia
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxImpdirproNumero = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.IMPDIRPRO ( "Fectrans","Faltafw","Fmodifw","Fecimpo","Fecexpo","Timestamp","Horaexpo","Haltafw","Horaimpo","Ualtafw","Vmodifw","Zadsfw","Valtafw","Umodifw","Saltafw","Smodifw","Hmodifw","Bdaltafw","Esttrans","Bdmodifw","Obs","Numero","Sitfis","Descripcio","Prodesde","Prohasta","Vendesde","Venhasta","Lisdesde","Lishasta","Cladesde","Clahasta","Prvdesde","Prvhasta","Paidesde","Paihasta","Impval","Pcuenta","Importanci" ) values ( <<"'" + this.ConvertirDateSql( lxImpdirproFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirproFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirproFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirproFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirproFecexpo ) + "'" >>, <<lxImpdirproTimestamp >>, <<"'" + this.FormatearTextoSql( lxImpdirproHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproObs ) + "'" >>, <<lxImpdirproNumero >>, <<lxImpdirproSitfis >>, <<"'" + this.FormatearTextoSql( lxImpdirproDescripcio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproProdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproProhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproVendesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproVenhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproLisdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproLishasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproCladesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproClahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproPrvdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproPrvhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproPaidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproPaihasta ) + "'" >>, <<lxImpdirproImpval >>, <<"'" + this.FormatearTextoSql( lxImpdirproPcuenta ) + "'" >>, <<lxImpdirproImportanci >> )
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
		this.oEntidad.Timestamp = lxImpdirproTimestamp
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
			local  lxImpdirproFectrans, lxImpdirproFaltafw, lxImpdirproFmodifw, lxImpdirproFecimpo, lxImpdirproFecexpo, lxImpdirproTimestamp, lxImpdirproHoraexpo, lxImpdirproHaltafw, lxImpdirproHoraimpo, lxImpdirproUaltafw, lxImpdirproVmodifw, lxImpdirproZadsfw, lxImpdirproValtafw, lxImpdirproUmodifw, lxImpdirproSaltafw, lxImpdirproSmodifw, lxImpdirproHmodifw, lxImpdirproBdaltafw, lxImpdirproEsttrans, lxImpdirproBdmodifw, lxImpdirproObs, lxImpdirproNumero, lxImpdirproSitfis, lxImpdirproDescripcio, lxImpdirproProdesde, lxImpdirproProhasta, lxImpdirproVendesde, lxImpdirproVenhasta, lxImpdirproLisdesde, lxImpdirproLishasta, lxImpdirproCladesde, lxImpdirproClahasta, lxImpdirproPrvdesde, lxImpdirproPrvhasta, lxImpdirproPaidesde, lxImpdirproPaihasta, lxImpdirproImpval, lxImpdirproPcuenta, lxImpdirproImportanci
				lxImpdirproFectrans =  .Fechatransferencia			lxImpdirproFaltafw =  .Fechaaltafw			lxImpdirproFmodifw =  .Fechamodificacionfw			lxImpdirproFecimpo =  .Fechaimpo			lxImpdirproFecexpo =  .Fechaexpo			lxImpdirproTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirproHoraexpo =  .Horaexpo			lxImpdirproHaltafw =  .Horaaltafw			lxImpdirproHoraimpo =  .Horaimpo			lxImpdirproUaltafw =  .Usuarioaltafw			lxImpdirproVmodifw =  .Versionmodificacionfw			lxImpdirproZadsfw =  .Zadsfw			lxImpdirproValtafw =  .Versionaltafw			lxImpdirproUmodifw =  .Usuariomodificacionfw			lxImpdirproSaltafw =  .Seriealtafw			lxImpdirproSmodifw =  .Seriemodificacionfw			lxImpdirproHmodifw =  .Horamodificacionfw			lxImpdirproBdaltafw =  .Basededatosaltafw			lxImpdirproEsttrans =  .Estadotransferencia			lxImpdirproBdmodifw =  .Basededatosmodificacionfw			lxImpdirproObs =  .Observacion			lxImpdirproNumero =  .Numero			lxImpdirproSitfis =  .Situacionfiscal			lxImpdirproDescripcio =  .Descripcion			lxImpdirproProdesde =  .F_proveedor_desde			lxImpdirproProhasta =  .F_proveedor_hasta			lxImpdirproVendesde =  .F_vendedor_desde			lxImpdirproVenhasta =  .F_vendedor_hasta			lxImpdirproLisdesde =  .F_lista_desde			lxImpdirproLishasta =  .F_lista_hasta			lxImpdirproCladesde =  .F_clasificacion_desde			lxImpdirproClahasta =  .F_clasificacion_hasta			lxImpdirproPrvdesde =  .F_provincia_desde			lxImpdirproPrvhasta =  .F_provincia_hasta			lxImpdirproPaidesde =  .F_pais_desde			lxImpdirproPaihasta =  .F_pais_hasta			lxImpdirproImpval =  .Imputacion_PK 			lxImpdirproPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirproImportanci =  .Importancia
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
			lxValorClavePrimaria = .oEntidad.NUMERO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.IMPDIRPRO set "Fectrans" = <<"'" + this.ConvertirDateSql( lxImpdirproFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxImpdirproFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpdirproFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpdirproFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpdirproFecexpo ) + "'">>,"Timestamp" = <<lxImpdirproTimestamp>>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpdirproHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxImpdirproHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpdirproHoraimpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpdirproUaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirproVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpdirproZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxImpdirproValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxImpdirproUmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxImpdirproSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxImpdirproSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirproHmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpdirproBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxImpdirproEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirproBdmodifw ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxImpdirproObs ) + "'">>,"Numero" = <<lxImpdirproNumero>>,"Sitfis" = <<lxImpdirproSitfis>>,"Descripcio" = <<"'" + this.FormatearTextoSql( lxImpdirproDescripcio ) + "'">>,"Prodesde" = <<"'" + this.FormatearTextoSql( lxImpdirproProdesde ) + "'">>,"Prohasta" = <<"'" + this.FormatearTextoSql( lxImpdirproProhasta ) + "'">>,"Vendesde" = <<"'" + this.FormatearTextoSql( lxImpdirproVendesde ) + "'">>,"Venhasta" = <<"'" + this.FormatearTextoSql( lxImpdirproVenhasta ) + "'">>,"Lisdesde" = <<"'" + this.FormatearTextoSql( lxImpdirproLisdesde ) + "'">>,"Lishasta" = <<"'" + this.FormatearTextoSql( lxImpdirproLishasta ) + "'">>,"Cladesde" = <<"'" + this.FormatearTextoSql( lxImpdirproCladesde ) + "'">>,"Clahasta" = <<"'" + this.FormatearTextoSql( lxImpdirproClahasta ) + "'">>,"Prvdesde" = <<"'" + this.FormatearTextoSql( lxImpdirproPrvdesde ) + "'">>,"Prvhasta" = <<"'" + this.FormatearTextoSql( lxImpdirproPrvhasta ) + "'">>,"Paidesde" = <<"'" + this.FormatearTextoSql( lxImpdirproPaidesde ) + "'">>,"Paihasta" = <<"'" + this.FormatearTextoSql( lxImpdirproPaihasta ) + "'">>,"Impval" = <<lxImpdirproImpval>>,"Pcuenta" = <<"'" + this.FormatearTextoSql( lxImpdirproPcuenta ) + "'">>,"Importanci" = <<lxImpdirproImportanci>> where "Numero" = <<lxImpdirproNumero>> and  IMPDIRPRO.NUMERO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxImpdirproTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 NUMERO from ZooLogic.IMPDIRPRO where " + this.ConvertirFuncionesSql( " IMPDIRPRO.NUMERO != 0" ) )
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
			Local lxImpdirproNumero
			lxImpdirproNumero = .Numero

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Sitfis" as "Situacionfiscal", "Descripcio" as "Descripcion", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Vendesde" as "F_vendedor_desde", "Venhasta" as "F_vendedor_hasta", "Lisdesde" as "F_lista_desde", "Lishasta" as "F_lista_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Prvdesde" as "F_provincia_desde", "Prvhasta" as "F_provincia_hasta", "Paidesde" as "F_pais_desde", "Paihasta" as "F_pais_hasta", "Impval" as "Imputacion", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia" from ZooLogic.IMPDIRPRO where "Numero" = <<lxImpdirproNumero>> and  IMPDIRPRO.NUMERO != 0
			endtext
			use in select('c_IMPDIRPRO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRPRO', set( 'Datasession' ) )

			if reccount( 'c_IMPDIRPRO' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxImpdirproNumero as Variant
		llRetorno = .t.
		lxImpdirproNumero = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.IMPDIRPRO where "Numero" = <<lxImpdirproNumero>> and  IMPDIRPRO.NUMERO != 0
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
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Sitfis" as "Situacionfiscal", "Descripcio" as "Descripcion", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Vendesde" as "F_vendedor_desde", "Venhasta" as "F_vendedor_hasta", "Lisdesde" as "F_lista_desde", "Lishasta" as "F_lista_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Prvdesde" as "F_provincia_desde", "Prvhasta" as "F_provincia_hasta", "Paidesde" as "F_pais_desde", "Paihasta" as "F_pais_hasta", "Impval" as "Imputacion", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia" from ZooLogic.IMPDIRPRO where  IMPDIRPRO.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_IMPDIRPRO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRPRO', set( 'Datasession' ) )
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
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Sitfis" as "Situacionfiscal", "Descripcio" as "Descripcion", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Vendesde" as "F_vendedor_desde", "Venhasta" as "F_vendedor_hasta", "Lisdesde" as "F_lista_desde", "Lishasta" as "F_lista_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Prvdesde" as "F_provincia_desde", "Prvhasta" as "F_provincia_hasta", "Paidesde" as "F_pais_desde", "Paihasta" as "F_pais_hasta", "Impval" as "Imputacion", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia" from ZooLogic.IMPDIRPRO where  str( NUMERO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPDIRPRO.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_IMPDIRPRO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRPRO', set( 'Datasession' ) )
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
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Sitfis" as "Situacionfiscal", "Descripcio" as "Descripcion", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Vendesde" as "F_vendedor_desde", "Venhasta" as "F_vendedor_hasta", "Lisdesde" as "F_lista_desde", "Lishasta" as "F_lista_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Prvdesde" as "F_provincia_desde", "Prvhasta" as "F_provincia_hasta", "Paidesde" as "F_pais_desde", "Paihasta" as "F_pais_hasta", "Impval" as "Imputacion", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia" from ZooLogic.IMPDIRPRO where  str( NUMERO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPDIRPRO.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_IMPDIRPRO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRPRO', set( 'Datasession' ) )
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
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Sitfis" as "Situacionfiscal", "Descripcio" as "Descripcion", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Vendesde" as "F_vendedor_desde", "Venhasta" as "F_vendedor_hasta", "Lisdesde" as "F_lista_desde", "Lishasta" as "F_lista_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Prvdesde" as "F_provincia_desde", "Prvhasta" as "F_provincia_hasta", "Paidesde" as "F_pais_desde", "Paihasta" as "F_pais_hasta", "Impval" as "Imputacion", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia" from ZooLogic.IMPDIRPRO where  IMPDIRPRO.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_IMPDIRPRO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRPRO', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Faltafw,Fmodifw,Fecimpo,Fecexpo,Timestamp,Horaexpo,Haltafw,Horaimpo,Ualtafw,Vmodifw" + ;
",Zadsfw,Valtafw,Umodifw,Saltafw,Smodifw,Hmodifw,Bdaltafw,Esttrans,Bdmodifw,Obs,Numero,Sitfis,Descrip" + ;
"cio,Prodesde,Prohasta,Vendesde,Venhasta,Lisdesde,Lishasta,Cladesde,Clahasta,Prvdesde,Prvhasta,Paides" + ;
"de,Paihasta,Impval,Pcuenta,Importanci" + ;
" from ZooLogic.IMPDIRPRO where  IMPDIRPRO.NUMERO != 0 and " + lcFiltro )
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
			local  lxImpdirproFectrans, lxImpdirproFaltafw, lxImpdirproFmodifw, lxImpdirproFecimpo, lxImpdirproFecexpo, lxImpdirproTimestamp, lxImpdirproHoraexpo, lxImpdirproHaltafw, lxImpdirproHoraimpo, lxImpdirproUaltafw, lxImpdirproVmodifw, lxImpdirproZadsfw, lxImpdirproValtafw, lxImpdirproUmodifw, lxImpdirproSaltafw, lxImpdirproSmodifw, lxImpdirproHmodifw, lxImpdirproBdaltafw, lxImpdirproEsttrans, lxImpdirproBdmodifw, lxImpdirproObs, lxImpdirproNumero, lxImpdirproSitfis, lxImpdirproDescripcio, lxImpdirproProdesde, lxImpdirproProhasta, lxImpdirproVendesde, lxImpdirproVenhasta, lxImpdirproLisdesde, lxImpdirproLishasta, lxImpdirproCladesde, lxImpdirproClahasta, lxImpdirproPrvdesde, lxImpdirproPrvhasta, lxImpdirproPaidesde, lxImpdirproPaihasta, lxImpdirproImpval, lxImpdirproPcuenta, lxImpdirproImportanci
				lxImpdirproFectrans = ctod( '  /  /    ' )			lxImpdirproFaltafw = ctod( '  /  /    ' )			lxImpdirproFmodifw = ctod( '  /  /    ' )			lxImpdirproFecimpo = ctod( '  /  /    ' )			lxImpdirproFecexpo = ctod( '  /  /    ' )			lxImpdirproTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirproHoraexpo = []			lxImpdirproHaltafw = []			lxImpdirproHoraimpo = []			lxImpdirproUaltafw = []			lxImpdirproVmodifw = []			lxImpdirproZadsfw = []			lxImpdirproValtafw = []			lxImpdirproUmodifw = []			lxImpdirproSaltafw = []			lxImpdirproSmodifw = []			lxImpdirproHmodifw = []			lxImpdirproBdaltafw = []			lxImpdirproEsttrans = []			lxImpdirproBdmodifw = []			lxImpdirproObs = []			lxImpdirproNumero = 0			lxImpdirproSitfis = 0			lxImpdirproDescripcio = []			lxImpdirproProdesde = []			lxImpdirproProhasta = []			lxImpdirproVendesde = []			lxImpdirproVenhasta = []			lxImpdirproLisdesde = []			lxImpdirproLishasta = []			lxImpdirproCladesde = []			lxImpdirproClahasta = []			lxImpdirproPrvdesde = []			lxImpdirproPrvhasta = []			lxImpdirproPaidesde = []			lxImpdirproPaihasta = []			lxImpdirproImpval = 0			lxImpdirproPcuenta = []			lxImpdirproImportanci = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.IMPDIRPRO where "NUMERO" = ] + transform( .oEntidad.NUMERO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'IMPDIRPRO' + '_' + tcCampo
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
		lcWhere = " Where  IMPDIRPRO.NUMERO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Sitfis" as "Situacionfiscal", "Descripcio" as "Descripcion", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Vendesde" as "F_vendedor_desde", "Venhasta" as "F_vendedor_hasta", "Lisdesde" as "F_lista_desde", "Lishasta" as "F_lista_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Prvdesde" as "F_provincia_desde", "Prvhasta" as "F_provincia_hasta", "Paidesde" as "F_pais_desde", "Paihasta" as "F_pais_hasta", "Impval" as "Imputacion", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'IMPDIRPRO', '', tnTope )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SITFIS AS SITUACIONFISCAL'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIPCIO AS DESCRIPCION'
				Case lcAtributo == 'F_PROVEEDOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRODESDE AS F_PROVEEDOR_DESDE'
				Case lcAtributo == 'F_PROVEEDOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROHASTA AS F_PROVEEDOR_HASTA'
				Case lcAtributo == 'F_VENDEDOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDESDE AS F_VENDEDOR_DESDE'
				Case lcAtributo == 'F_VENDEDOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENHASTA AS F_VENDEDOR_HASTA'
				Case lcAtributo == 'F_LISTA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LISDESDE AS F_LISTA_DESDE'
				Case lcAtributo == 'F_LISTA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LISHASTA AS F_LISTA_HASTA'
				Case lcAtributo == 'F_CLASIFICACION_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLADESDE AS F_CLASIFICACION_DESDE'
				Case lcAtributo == 'F_CLASIFICACION_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLAHASTA AS F_CLASIFICACION_HASTA'
				Case lcAtributo == 'F_PROVINCIA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRVDESDE AS F_PROVINCIA_DESDE'
				Case lcAtributo == 'F_PROVINCIA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRVHASTA AS F_PROVINCIA_HASTA'
				Case lcAtributo == 'F_PAIS_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PAIDESDE AS F_PAIS_DESDE'
				Case lcAtributo == 'F_PAIS_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PAIHASTA AS F_PAIS_HASTA'
				Case lcAtributo == 'IMPUTACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPVAL AS IMPUTACION'
				Case lcAtributo == 'PLANDECUENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PCUENTA AS PLANDECUENTAS'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'SITFIS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIPCIO'
			Case upper( alltrim( tcAtributo ) ) == 'F_PROVEEDOR_DESDE'
				lcCampo = 'PRODESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_PROVEEDOR_HASTA'
				lcCampo = 'PROHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_VENDEDOR_DESDE'
				lcCampo = 'VENDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_VENDEDOR_HASTA'
				lcCampo = 'VENHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_LISTA_DESDE'
				lcCampo = 'LISDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_LISTA_HASTA'
				lcCampo = 'LISHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLASIFICACION_DESDE'
				lcCampo = 'CLADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLASIFICACION_HASTA'
				lcCampo = 'CLAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_PROVINCIA_DESDE'
				lcCampo = 'PRVDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_PROVINCIA_HASTA'
				lcCampo = 'PRVHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_PAIS_DESDE'
				lcCampo = 'PAIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_PAIS_HASTA'
				lcCampo = 'PAIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUTACION'
				lcCampo = 'IMPVAL'
			Case upper( alltrim( tcAtributo ) ) == 'PLANDECUENTAS'
				lcCampo = 'PCUENTA'
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
			local  lxImpdirproFectrans, lxImpdirproFaltafw, lxImpdirproFmodifw, lxImpdirproFecimpo, lxImpdirproFecexpo, lxImpdirproTimestamp, lxImpdirproHoraexpo, lxImpdirproHaltafw, lxImpdirproHoraimpo, lxImpdirproUaltafw, lxImpdirproVmodifw, lxImpdirproZadsfw, lxImpdirproValtafw, lxImpdirproUmodifw, lxImpdirproSaltafw, lxImpdirproSmodifw, lxImpdirproHmodifw, lxImpdirproBdaltafw, lxImpdirproEsttrans, lxImpdirproBdmodifw, lxImpdirproObs, lxImpdirproNumero, lxImpdirproSitfis, lxImpdirproDescripcio, lxImpdirproProdesde, lxImpdirproProhasta, lxImpdirproVendesde, lxImpdirproVenhasta, lxImpdirproLisdesde, lxImpdirproLishasta, lxImpdirproCladesde, lxImpdirproClahasta, lxImpdirproPrvdesde, lxImpdirproPrvhasta, lxImpdirproPaidesde, lxImpdirproPaihasta, lxImpdirproImpval, lxImpdirproPcuenta, lxImpdirproImportanci
				lxImpdirproFectrans =  .Fechatransferencia			lxImpdirproFaltafw =  .Fechaaltafw			lxImpdirproFmodifw =  .Fechamodificacionfw			lxImpdirproFecimpo =  .Fechaimpo			lxImpdirproFecexpo =  .Fechaexpo			lxImpdirproTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirproHoraexpo =  .Horaexpo			lxImpdirproHaltafw =  .Horaaltafw			lxImpdirproHoraimpo =  .Horaimpo			lxImpdirproUaltafw =  .Usuarioaltafw			lxImpdirproVmodifw =  .Versionmodificacionfw			lxImpdirproZadsfw =  .Zadsfw			lxImpdirproValtafw =  .Versionaltafw			lxImpdirproUmodifw =  .Usuariomodificacionfw			lxImpdirproSaltafw =  .Seriealtafw			lxImpdirproSmodifw =  .Seriemodificacionfw			lxImpdirproHmodifw =  .Horamodificacionfw			lxImpdirproBdaltafw =  .Basededatosaltafw			lxImpdirproEsttrans =  .Estadotransferencia			lxImpdirproBdmodifw =  .Basededatosmodificacionfw			lxImpdirproObs =  .Observacion			lxImpdirproNumero =  .Numero			lxImpdirproSitfis =  .Situacionfiscal			lxImpdirproDescripcio =  .Descripcion			lxImpdirproProdesde =  .F_proveedor_desde			lxImpdirproProhasta =  .F_proveedor_hasta			lxImpdirproVendesde =  .F_vendedor_desde			lxImpdirproVenhasta =  .F_vendedor_hasta			lxImpdirproLisdesde =  .F_lista_desde			lxImpdirproLishasta =  .F_lista_hasta			lxImpdirproCladesde =  .F_clasificacion_desde			lxImpdirproClahasta =  .F_clasificacion_hasta			lxImpdirproPrvdesde =  .F_provincia_desde			lxImpdirproPrvhasta =  .F_provincia_hasta			lxImpdirproPaidesde =  .F_pais_desde			lxImpdirproPaihasta =  .F_pais_hasta			lxImpdirproImpval =  .Imputacion_PK 			lxImpdirproPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirproImportanci =  .Importancia
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.IMPDIRPRO ( "Fectrans","Faltafw","Fmodifw","Fecimpo","Fecexpo","Timestamp","Horaexpo","Haltafw","Horaimpo","Ualtafw","Vmodifw","Zadsfw","Valtafw","Umodifw","Saltafw","Smodifw","Hmodifw","Bdaltafw","Esttrans","Bdmodifw","Obs","Numero","Sitfis","Descripcio","Prodesde","Prohasta","Vendesde","Venhasta","Lisdesde","Lishasta","Cladesde","Clahasta","Prvdesde","Prvhasta","Paidesde","Paihasta","Impval","Pcuenta","Importanci" ) values ( <<"'" + this.ConvertirDateSql( lxImpdirproFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirproFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirproFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirproFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirproFecexpo ) + "'" >>, <<lxImpdirproTimestamp >>, <<"'" + this.FormatearTextoSql( lxImpdirproHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproObs ) + "'" >>, <<lxImpdirproNumero >>, <<lxImpdirproSitfis >>, <<"'" + this.FormatearTextoSql( lxImpdirproDescripcio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproProdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproProhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproVendesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproVenhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproLisdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproLishasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproCladesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproClahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproPrvdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproPrvhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproPaidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirproPaihasta ) + "'" >>, <<lxImpdirproImpval >>, <<"'" + this.FormatearTextoSql( lxImpdirproPcuenta ) + "'" >>, <<lxImpdirproImportanci >> )
		endtext
		loColeccion.cTabla = 'IMPDIRPRO' 
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
			local  lxImpdirproFectrans, lxImpdirproFaltafw, lxImpdirproFmodifw, lxImpdirproFecimpo, lxImpdirproFecexpo, lxImpdirproTimestamp, lxImpdirproHoraexpo, lxImpdirproHaltafw, lxImpdirproHoraimpo, lxImpdirproUaltafw, lxImpdirproVmodifw, lxImpdirproZadsfw, lxImpdirproValtafw, lxImpdirproUmodifw, lxImpdirproSaltafw, lxImpdirproSmodifw, lxImpdirproHmodifw, lxImpdirproBdaltafw, lxImpdirproEsttrans, lxImpdirproBdmodifw, lxImpdirproObs, lxImpdirproNumero, lxImpdirproSitfis, lxImpdirproDescripcio, lxImpdirproProdesde, lxImpdirproProhasta, lxImpdirproVendesde, lxImpdirproVenhasta, lxImpdirproLisdesde, lxImpdirproLishasta, lxImpdirproCladesde, lxImpdirproClahasta, lxImpdirproPrvdesde, lxImpdirproPrvhasta, lxImpdirproPaidesde, lxImpdirproPaihasta, lxImpdirproImpval, lxImpdirproPcuenta, lxImpdirproImportanci
				lxImpdirproFectrans =  .Fechatransferencia			lxImpdirproFaltafw =  .Fechaaltafw			lxImpdirproFmodifw =  .Fechamodificacionfw			lxImpdirproFecimpo =  .Fechaimpo			lxImpdirproFecexpo =  .Fechaexpo			lxImpdirproTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirproHoraexpo =  .Horaexpo			lxImpdirproHaltafw =  .Horaaltafw			lxImpdirproHoraimpo =  .Horaimpo			lxImpdirproUaltafw =  .Usuarioaltafw			lxImpdirproVmodifw =  .Versionmodificacionfw			lxImpdirproZadsfw =  .Zadsfw			lxImpdirproValtafw =  .Versionaltafw			lxImpdirproUmodifw =  .Usuariomodificacionfw			lxImpdirproSaltafw =  .Seriealtafw			lxImpdirproSmodifw =  .Seriemodificacionfw			lxImpdirproHmodifw =  .Horamodificacionfw			lxImpdirproBdaltafw =  .Basededatosaltafw			lxImpdirproEsttrans =  .Estadotransferencia			lxImpdirproBdmodifw =  .Basededatosmodificacionfw			lxImpdirproObs =  .Observacion			lxImpdirproNumero =  .Numero			lxImpdirproSitfis =  .Situacionfiscal			lxImpdirproDescripcio =  .Descripcion			lxImpdirproProdesde =  .F_proveedor_desde			lxImpdirproProhasta =  .F_proveedor_hasta			lxImpdirproVendesde =  .F_vendedor_desde			lxImpdirproVenhasta =  .F_vendedor_hasta			lxImpdirproLisdesde =  .F_lista_desde			lxImpdirproLishasta =  .F_lista_hasta			lxImpdirproCladesde =  .F_clasificacion_desde			lxImpdirproClahasta =  .F_clasificacion_hasta			lxImpdirproPrvdesde =  .F_provincia_desde			lxImpdirproPrvhasta =  .F_provincia_hasta			lxImpdirproPaidesde =  .F_pais_desde			lxImpdirproPaihasta =  .F_pais_hasta			lxImpdirproImpval =  .Imputacion_PK 			lxImpdirproPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirproImportanci =  .Importancia
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  IMPDIRPRO.NUMERO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.IMPDIRPRO set "Fectrans" = <<"'" + this.ConvertirDateSql( lxImpdirproFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxImpdirproFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpdirproFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpdirproFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpdirproFecexpo ) + "'">>, "Timestamp" = <<lxImpdirproTimestamp>>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpdirproHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxImpdirproHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpdirproHoraimpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpdirproUaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirproVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpdirproZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxImpdirproValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxImpdirproUmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxImpdirproSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxImpdirproSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirproHmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpdirproBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxImpdirproEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirproBdmodifw ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxImpdirproObs ) + "'">>, "Numero" = <<lxImpdirproNumero>>, "Sitfis" = <<lxImpdirproSitfis>>, "Descripcio" = <<"'" + this.FormatearTextoSql( lxImpdirproDescripcio ) + "'">>, "Prodesde" = <<"'" + this.FormatearTextoSql( lxImpdirproProdesde ) + "'">>, "Prohasta" = <<"'" + this.FormatearTextoSql( lxImpdirproProhasta ) + "'">>, "Vendesde" = <<"'" + this.FormatearTextoSql( lxImpdirproVendesde ) + "'">>, "Venhasta" = <<"'" + this.FormatearTextoSql( lxImpdirproVenhasta ) + "'">>, "Lisdesde" = <<"'" + this.FormatearTextoSql( lxImpdirproLisdesde ) + "'">>, "Lishasta" = <<"'" + this.FormatearTextoSql( lxImpdirproLishasta ) + "'">>, "Cladesde" = <<"'" + this.FormatearTextoSql( lxImpdirproCladesde ) + "'">>, "Clahasta" = <<"'" + this.FormatearTextoSql( lxImpdirproClahasta ) + "'">>, "Prvdesde" = <<"'" + this.FormatearTextoSql( lxImpdirproPrvdesde ) + "'">>, "Prvhasta" = <<"'" + this.FormatearTextoSql( lxImpdirproPrvhasta ) + "'">>, "Paidesde" = <<"'" + this.FormatearTextoSql( lxImpdirproPaidesde ) + "'">>, "Paihasta" = <<"'" + this.FormatearTextoSql( lxImpdirproPaihasta ) + "'">>, "Impval" = <<lxImpdirproImpval>>, "Pcuenta" = <<"'" + this.FormatearTextoSql( lxImpdirproPcuenta ) + "'">>, "Importanci" = <<lxImpdirproImportanci>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'IMPDIRPRO' 
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

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  IMPDIRPRO.NUMERO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.IMPDIRPRO where ' + lcFiltro )
			loColeccion.cTabla = 'IMPDIRPRO' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.IMPDIRPRO where  IMPDIRPRO.NUMERO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.IMPDIRPRO where NUMERO = " + transform( this.oEntidad.NUMERO )+ " and  IMPDIRPRO.NUMERO != 0" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxIMPDIRPROSitFis as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRPRO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.IMPDIRPRO Where NUMERO = ] + transform( &lcCursor..NUMERO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.IMPDIRPRO set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, OBS = ] + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'"+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, SitFis = ] + transform( &lcCursor..SitFis )+ [, Descripcio = ] + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'"+ [, ProDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ProDesde ) + "'"+ [, ProHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ProHasta ) + "'"+ [, VenDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..VenDesde ) + "'"+ [, VenHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..VenHasta ) + "'"+ [, LisDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..LisDesde ) + "'"+ [, LisHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..LisHasta ) + "'"+ [, ClaDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ClaDesde ) + "'"+ [, ClaHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ClaHasta ) + "'"+ [, PrvDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..PrvDesde ) + "'"+ [, PrvHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..PrvHasta ) + "'"+ [, PaiDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..PaiDesde ) + "'"+ [, PaiHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..PaiHasta ) + "'"+ [, ImpVal = ] + transform( &lcCursor..ImpVal )+ [, PCUENTA = ] + "'" + this.FormatearTextoSql( &lcCursor..PCUENTA ) + "'"+ [, Importanci = ] + transform( &lcCursor..Importanci ) + [ Where NUMERO = ] + transform( &lcCursor..NUMERO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECTRANS, FALTAFW, FMODIFW, FECIMPO, FECEXPO, TIMESTAMP, HORAEXPO, HALTAFW, HORAIMPO, UALTAFW, VMODIFW, ZADSFW, VALTAFW, UMODIFW, SALTAFW, SMODIFW, HMODIFW, BDALTAFW, ESTTRANS, BDMODIFW, OBS, NUMERO, SitFis, Descripcio, ProDesde, ProHasta, VenDesde, VenHasta, LisDesde, LisHasta, ClaDesde, ClaHasta, PrvDesde, PrvHasta, PaiDesde, PaiHasta, ImpVal, PCUENTA, Importanci
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..NUMERO ) + ',' + transform( &lcCursor..SitFis ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VenDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VenHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..LisDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LisHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClaDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClaHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PrvDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PrvHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PaiDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..PaiHasta ) + "'" + ',' + transform( &lcCursor..ImpVal ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..PCUENTA ) + "'" + ',' + transform( &lcCursor..Importanci )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.IMPDIRPRO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRPRO'
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
			Case  lcAlias == lcPrefijo + 'IMPDIRPRO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPDIRPRO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPDIRPRO_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_IMPDIRPRO')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'IMPDIRPRO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..NUMERO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad IMPDIRPRO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRPRO'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRPRO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IMPDIRPRO') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IMPDIRPRO
Create Table ZooLogic.TablaTrabajo_IMPDIRPRO ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"obs" varchar(max)  null, 
"numero" numeric( 8, 0 )  null, 
"sitfis" numeric( 2, 0 )  null, 
"descripcio" char( 50 )  null, 
"prodesde" char( 10 )  null, 
"prohasta" char( 10 )  null, 
"vendesde" char( 10 )  null, 
"venhasta" char( 10 )  null, 
"lisdesde" char( 5 )  null, 
"lishasta" char( 5 )  null, 
"cladesde" char( 6 )  null, 
"clahasta" char( 6 )  null, 
"prvdesde" char( 2 )  null, 
"prvhasta" char( 2 )  null, 
"paidesde" char( 3 )  null, 
"paihasta" char( 3 )  null, 
"impval" numeric( 8, 0 )  null, 
"pcuenta" char( 30 )  null, 
"importanci" numeric( 5, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_IMPDIRPRO' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_IMPDIRPRO' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRPRO'
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
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('sitfis','sitfis')
			.AgregarMapeo('descripcio','descripcio')
			.AgregarMapeo('prodesde','prodesde')
			.AgregarMapeo('prohasta','prohasta')
			.AgregarMapeo('vendesde','vendesde')
			.AgregarMapeo('venhasta','venhasta')
			.AgregarMapeo('lisdesde','lisdesde')
			.AgregarMapeo('lishasta','lishasta')
			.AgregarMapeo('cladesde','cladesde')
			.AgregarMapeo('clahasta','clahasta')
			.AgregarMapeo('prvdesde','prvdesde')
			.AgregarMapeo('prvhasta','prvhasta')
			.AgregarMapeo('paidesde','paidesde')
			.AgregarMapeo('paihasta','paihasta')
			.AgregarMapeo('impval','impval')
			.AgregarMapeo('pcuenta','pcuenta')
			.AgregarMapeo('importanci','importanci')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_IMPDIRPRO'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.OBS = isnull( d.OBS, t.OBS ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.SITFIS = isnull( d.SITFIS, t.SITFIS ),t.DESCRIPCIO = isnull( d.DESCRIPCIO, t.DESCRIPCIO ),t.PRODESDE = isnull( d.PRODESDE, t.PRODESDE ),t.PROHASTA = isnull( d.PROHASTA, t.PROHASTA ),t.VENDESDE = isnull( d.VENDESDE, t.VENDESDE ),t.VENHASTA = isnull( d.VENHASTA, t.VENHASTA ),t.LISDESDE = isnull( d.LISDESDE, t.LISDESDE ),t.LISHASTA = isnull( d.LISHASTA, t.LISHASTA ),t.CLADESDE = isnull( d.CLADESDE, t.CLADESDE ),t.CLAHASTA = isnull( d.CLAHASTA, t.CLAHASTA ),t.PRVDESDE = isnull( d.PRVDESDE, t.PRVDESDE ),t.PRVHASTA = isnull( d.PRVHASTA, t.PRVHASTA ),t.PAIDESDE = isnull( d.PAIDESDE, t.PAIDESDE ),t.PAIHASTA = isnull( d.PAIHASTA, t.PAIHASTA ),t.IMPVAL = isnull( d.IMPVAL, t.IMPVAL ),t.PCUENTA = isnull( d.PCUENTA, t.PCUENTA ),t.IMPORTANCI = isnull( d.IMPORTANCI, t.IMPORTANCI )
					from ZooLogic.IMPDIRPRO t inner join deleted d 
							 on t.NUMERO = d.NUMERO
				-- Fin Updates
				insert into ZooLogic.IMPDIRPRO(Fectrans,Faltafw,Fmodifw,Fecimpo,Fecexpo,Timestamp,Horaexpo,Haltafw,Horaimpo,Ualtafw,Vmodifw,Zadsfw,Valtafw,Umodifw,Saltafw,Smodifw,Hmodifw,Bdaltafw,Esttrans,Bdmodifw,Obs,Numero,Sitfis,Descripcio,Prodesde,Prohasta,Vendesde,Venhasta,Lisdesde,Lishasta,Cladesde,Clahasta,Prvdesde,Prvhasta,Paidesde,Paihasta,Impval,Pcuenta,Importanci)
					Select isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.TIMESTAMP,0),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.UALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.OBS,''),isnull( d.NUMERO,0),isnull( d.SITFIS,0),isnull( d.DESCRIPCIO,''),isnull( d.PRODESDE,''),isnull( d.PROHASTA,''),isnull( d.VENDESDE,''),isnull( d.VENHASTA,''),isnull( d.LISDESDE,''),isnull( d.LISHASTA,''),isnull( d.CLADESDE,''),isnull( d.CLAHASTA,''),isnull( d.PRVDESDE,''),isnull( d.PRVHASTA,''),isnull( d.PAIDESDE,''),isnull( d.PAIHASTA,''),isnull( d.IMPVAL,0),isnull( d.PCUENTA,''),isnull( d.IMPORTANCI,0)
						From deleted d left join ZooLogic.IMPDIRPRO pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IMPDIRPRO') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IMPDIRPRO
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_IMPDIRPRO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRPRO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRPRO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRPRO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRPRO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRPRO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_IMPDIRPRO.Timestamp, 0 )
					.Horaexpo = nvl( c_IMPDIRPRO.Horaexpo, [] )
					.Horaaltafw = nvl( c_IMPDIRPRO.Horaaltafw, [] )
					.Horaimpo = nvl( c_IMPDIRPRO.Horaimpo, [] )
					.Usuarioaltafw = nvl( c_IMPDIRPRO.Usuarioaltafw, [] )
					.Versionmodificacionfw = nvl( c_IMPDIRPRO.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_IMPDIRPRO.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_IMPDIRPRO.Usuariomodificacionfw, [] )
					.Seriealtafw = nvl( c_IMPDIRPRO.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_IMPDIRPRO.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_IMPDIRPRO.Horamodificacionfw, [] )
					.Basededatosaltafw = nvl( c_IMPDIRPRO.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_IMPDIRPRO.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_IMPDIRPRO.Basededatosmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Numero = nvl( c_IMPDIRPRO.Numero, 0 )
					.Situacionfiscal = nvl( c_IMPDIRPRO.Situacionfiscal, 0 )
					.Descripcion = nvl( c_IMPDIRPRO.Descripcion, [] )
					.F_proveedor_desde = nvl( c_IMPDIRPRO.F_proveedor_desde, [] )
					.F_proveedor_hasta = nvl( c_IMPDIRPRO.F_proveedor_hasta, [] )
					.F_vendedor_desde = nvl( c_IMPDIRPRO.F_vendedor_desde, [] )
					.F_vendedor_hasta = nvl( c_IMPDIRPRO.F_vendedor_hasta, [] )
					.F_lista_desde = nvl( c_IMPDIRPRO.F_lista_desde, [] )
					.F_lista_hasta = nvl( c_IMPDIRPRO.F_lista_hasta, [] )
					.F_clasificacion_desde = nvl( c_IMPDIRPRO.F_clasificacion_desde, [] )
					.F_clasificacion_hasta = nvl( c_IMPDIRPRO.F_clasificacion_hasta, [] )
					.F_provincia_desde = nvl( c_IMPDIRPRO.F_provincia_desde, [] )
					.F_provincia_hasta = nvl( c_IMPDIRPRO.F_provincia_hasta, [] )
					.F_pais_desde = nvl( c_IMPDIRPRO.F_pais_desde, [] )
					.F_pais_hasta = nvl( c_IMPDIRPRO.F_pais_hasta, [] )
					.Imputacion_PK =  nvl( c_IMPDIRPRO.Imputacion, 0 )
					.Plandecuentas_PK =  nvl( c_IMPDIRPRO.Plandecuentas, [] )
					.Importancia = nvl( c_IMPDIRPRO.Importancia, 0 )
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
		return c_IMPDIRPRO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.IMPDIRPRO' )
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
								from ZooLogic.IMPDIRPRO 
								Where   IMPDIRPRO.NUMERO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "IMPDIRPRO", "", lcCursor, set("Datasession") )
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
			"Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Sitfis" as "Situacionfiscal", "Descripcio" as "Descripcion", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Vendesde" as "F_vendedor_desde", "Venhasta" as "F_vendedor_hasta", "Lisdesde" as "F_lista_desde", "Lishasta" as "F_lista_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Prvdesde" as "F_provincia_desde", "Prvhasta" as "F_provincia_hasta", "Paidesde" as "F_pais_desde", "Paihasta" as "F_pais_hasta", "Impval" as "Imputacion", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.IMPDIRPRO 
								Where   IMPDIRPRO.NUMERO != 0
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
	Tabla = 'IMPDIRPRO'
	Filtro = " IMPDIRPRO.NUMERO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " IMPDIRPRO.NUMERO != 0"
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
	<row entidad="IMPDIRPRO                               " atributo="FECHATRANSFERENCIA                      " tabla="IMPDIRPRO      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="FECHAALTAFW                             " tabla="IMPDIRPRO      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="FECHAMODIFICACIONFW                     " tabla="IMPDIRPRO      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="FECHAIMPO                               " tabla="IMPDIRPRO      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="FECHAEXPO                               " tabla="IMPDIRPRO      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="TIMESTAMP                               " tabla="IMPDIRPRO      " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="HORAEXPO                                " tabla="IMPDIRPRO      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="HORAALTAFW                              " tabla="IMPDIRPRO      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="HORAIMPO                                " tabla="IMPDIRPRO      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="USUARIOALTAFW                           " tabla="IMPDIRPRO      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="VERSIONMODIFICACIONFW                   " tabla="IMPDIRPRO      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="ZADSFW                                  " tabla="IMPDIRPRO      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="VERSIONALTAFW                           " tabla="IMPDIRPRO      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="USUARIOMODIFICACIONFW                   " tabla="IMPDIRPRO      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="SERIEALTAFW                             " tabla="IMPDIRPRO      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="SERIEMODIFICACIONFW                     " tabla="IMPDIRPRO      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="HORAMODIFICACIONFW                      " tabla="IMPDIRPRO      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="BASEDEDATOSALTAFW                       " tabla="IMPDIRPRO      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="ESTADOTRANSFERENCIA                     " tabla="IMPDIRPRO      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="IMPDIRPRO      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="OBSERVACION                             " tabla="IMPDIRPRO      " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="NUMERO                                  " tabla="IMPDIRPRO      " campo="NUMERO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="SITUACIONFISCAL                         " tabla="IMPDIRPRO      " campo="SITFIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Situación fiscal                                                                                                                                                " dominio="COMBOSITUACIONFISCALCONVACIO  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="DESCRIPCION                             " tabla="IMPDIRPRO      " campo="DESCRIPCIO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="F_PROVEEDOR_DESDE                       " tabla="IMPDIRPRO      " campo="PRODESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Proveedor                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="F_PROVEEDOR_HASTA                       " tabla="IMPDIRPRO      " campo="PROHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="406" etiqueta="Proveedor                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="F_VENDEDOR_DESDE                        " tabla="IMPDIRPRO      " campo="VENDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Vendedor                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="F_VENDEDOR_HASTA                        " tabla="IMPDIRPRO      " campo="VENHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="410" etiqueta="Vendedor                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="F_LISTA_DESDE                           " tabla="IMPDIRPRO      " campo="LISDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Lista de precio                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="F_LISTA_HASTA                           " tabla="IMPDIRPRO      " campo="LISHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="414" etiqueta="Lista de precio                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="F_CLASIFICACION_DESDE                   " tabla="IMPDIRPRO      " campo="CLADESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Clasificación                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="F_CLASIFICACION_HASTA                   " tabla="IMPDIRPRO      " campo="CLAHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="6" decimales="0" valorsugerido="ZZZZZZ                                                                                                                                                                                                                                                        " obligatorio="false" admitebusqueda="418" etiqueta="Clasificación                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="F_PROVINCIA_DESDE                       " tabla="IMPDIRPRO      " campo="PRVDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Provincia                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="F_PROVINCIA_HASTA                       " tabla="IMPDIRPRO      " campo="PRVHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="ZZ                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="422" etiqueta="Provincia                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="F_PAIS_DESDE                            " tabla="IMPDIRPRO      " campo="PAIDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="País                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="F_PAIS_HASTA                            " tabla="IMPDIRPRO      " campo="PAIHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="ZZZ                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="426" etiqueta="País                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="IMPUTACION                              " tabla="IMPDIRPRO      " campo="IMPVAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="IMPDIRVAL                               " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Imputación                                                                                                                                                      " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="35" orden="45" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="PLANDECUENTAS                           " tabla="IMPDIRPRO      " campo="PCUENTA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PLANDECUENTAS                           " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="428" etiqueta="Cuenta                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot; plancuenta.CTAIMPUT = .t. &quot;                                                                                                                                                                           " grupo="0" subgrupo="1" orden="46" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRPRO                               " atributo="IMPORTANCIA                             " tabla="IMPDIRPRO      " campo="IMPORTANCI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Importancia                                                                                                                                                     " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="47" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="DESCRIPCION                             " tabla="IMPDIRVAL      " campo="DESCRIPCIO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Imp.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join IMPDIRVAL On IMPDIRPRO.IMPVAL = IMPDIRVAL.NUMERO And  IMPDIRVAL.NUMERO != 0                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="DESCRIPCION                             " tabla="PLANCUENTA     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="429" etiqueta="Detalle Cue.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PLANCUENTA On IMPDIRPRO.PCUENTA = PLANCUENTA.ctacodigo And  PLANCUENTA.CTACODIGO != ''                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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