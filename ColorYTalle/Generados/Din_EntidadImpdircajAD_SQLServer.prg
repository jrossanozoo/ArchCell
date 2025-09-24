
define class Din_EntidadIMPDIRCAJAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_IMPDIRCAJ'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_IDJPK'
	cTablaPrincipal = 'IMPDIRCAJ'
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
			local  lxImpdircajFecimpo, lxImpdircajFectrans, lxImpdircajFmodifw, lxImpdircajFecexpo, lxImpdircajFaltafw, lxImpdircajBdaltafw, lxImpdircajBdmodifw, lxImpdircajHaltafw, lxImpdircajEsttrans, lxImpdircajHoraexpo, lxImpdircajValtafw, lxImpdircajZadsfw, lxImpdircajVmodifw, lxImpdircajUmodifw, lxImpdircajUaltafw, lxImpdircajHoraimpo, lxImpdircajHmodifw, lxImpdircajSaltafw, lxImpdircajSmodifw, lxImpdircajObs, lxImpdircajImpval, lxImpdircajNumero, lxImpdircajEstadcarte, lxImpdircajEstadentre, lxImpdircajDescripcio, lxImpdircajEstadcobra, lxImpdircajCondesde, lxImpdircajEstaddepos, lxImpdircajConhasta, lxImpdircajEstadrecha, lxImpdircajCladesde, lxImpdircajEstadbaja, lxImpdircajClahasta, lxImpdircajEstaddevol, lxImpdircajCbancdesde, lxImpdircajEstadprepa, lxImpdircajCbanchasta, lxImpdircajEstadenvia, lxImpdircajEstadenvre, lxImpdircajPcuenta, lxImpdircajImportanci, lxImpdircajEstadtrans, lxImpdircajEstadcusto, lxImpdircajSucdesde, lxImpdircajSuchasta, lxImpdircajTsucdesde, lxImpdircajTsuchasta, lxImpdircajBase
				lxImpdircajFecimpo =  .Fechaimpo			lxImpdircajFectrans =  .Fechatransferencia			lxImpdircajFmodifw =  .Fechamodificacionfw			lxImpdircajFecexpo =  .Fechaexpo			lxImpdircajFaltafw =  .Fechaaltafw			lxImpdircajBdaltafw =  .Basededatosaltafw			lxImpdircajBdmodifw =  .Basededatosmodificacionfw			lxImpdircajHaltafw =  .Horaaltafw			lxImpdircajEsttrans =  .Estadotransferencia			lxImpdircajHoraexpo =  .Horaexpo			lxImpdircajValtafw =  .Versionaltafw			lxImpdircajZadsfw =  .Zadsfw			lxImpdircajVmodifw =  .Versionmodificacionfw			lxImpdircajUmodifw =  .Usuariomodificacionfw			lxImpdircajUaltafw =  .Usuarioaltafw			lxImpdircajHoraimpo =  .Horaimpo			lxImpdircajHmodifw =  .Horamodificacionfw			lxImpdircajSaltafw =  .Seriealtafw			lxImpdircajSmodifw =  .Seriemodificacionfw			lxImpdircajObs =  .Observacion			lxImpdircajImpval =  .Imputacion_PK 			lxImpdircajNumero =  .Numero			lxImpdircajEstadcarte =  .Estadoencartera			lxImpdircajEstadentre =  .Estadoentregado			lxImpdircajDescripcio =  .Descripcion			lxImpdircajEstadcobra =  .Estadocobrado			lxImpdircajCondesde =  upper( .f_Concepto_Desde_PK ) 			lxImpdircajEstaddepos =  .Estadodepositado			lxImpdircajConhasta =  upper( .f_Concepto_Hasta_PK ) 			lxImpdircajEstadrecha =  .Estadorechazado			lxImpdircajCladesde =  upper( .f_Clasificacion_Desde_PK ) 			lxImpdircajEstadbaja =  .Estadobaja			lxImpdircajClahasta =  upper( .f_Clasificacion_Hasta_PK ) 			lxImpdircajEstaddevol =  .Estadodevuelto			lxImpdircajCbancdesde =  upper( .f_CuentaBancaria_Desde_PK ) 			lxImpdircajEstadprepa =  .Estadocomprometido			lxImpdircajCbanchasta =  upper( .f_CuentaBancaria_Hasta_PK ) 			lxImpdircajEstadenvia =  .Estadoenviado			lxImpdircajEstadenvre =  .Estadoenviorechazado			lxImpdircajPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdircajImportanci =  .Importancia			lxImpdircajEstadtrans =  .Estadoentransito			lxImpdircajEstadcusto =  .Estadoencustodia			lxImpdircajSucdesde =  upper( .f_Sucursal_Desde_PK ) 			lxImpdircajSuchasta =  upper( .f_Sucursal_Hasta_PK ) 			lxImpdircajTsucdesde =  upper( .f_TipoSucursal_Desde_PK ) 			lxImpdircajTsuchasta =  upper( .f_TipoSucursal_Hasta_PK ) 			lxImpdircajBase =  .Basededatos
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxImpdircajNumero = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.IMPDIRCAJ ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Bdaltafw","Bdmodifw","Haltafw","Esttrans","Horaexpo","Valtafw","Zadsfw","Vmodifw","Umodifw","Ualtafw","Horaimpo","Hmodifw","Saltafw","Smodifw","Obs","Impval","Numero","Estadcarte","Estadentre","Descripcio","Estadcobra","Condesde","Estaddepos","Conhasta","Estadrecha","Cladesde","Estadbaja","Clahasta","Estaddevol","Cbancdesde","Estadprepa","Cbanchasta","Estadenvia","Estadenvre","Pcuenta","Importanci","Estadtrans","Estadcusto","Sucdesde","Suchasta","Tsucdesde","Tsuchasta","Base" ) values ( <<"'" + this.ConvertirDateSql( lxImpdircajFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircajFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircajFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircajFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircajFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajObs ) + "'" >>, <<lxImpdircajImpval >>, <<lxImpdircajNumero >>, <<iif( lxImpdircajEstadcarte, 1, 0 ) >>, <<iif( lxImpdircajEstadentre, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpdircajDescripcio ) + "'" >>, <<iif( lxImpdircajEstadcobra, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpdircajCondesde ) + "'" >>, <<iif( lxImpdircajEstaddepos, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpdircajConhasta ) + "'" >>, <<iif( lxImpdircajEstadrecha, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpdircajCladesde ) + "'" >>, <<iif( lxImpdircajEstadbaja, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpdircajClahasta ) + "'" >>, <<iif( lxImpdircajEstaddevol, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpdircajCbancdesde ) + "'" >>, <<iif( lxImpdircajEstadprepa, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpdircajCbanchasta ) + "'" >>, <<iif( lxImpdircajEstadenvia, 1, 0 ) >>, <<iif( lxImpdircajEstadenvre, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpdircajPcuenta ) + "'" >>, <<lxImpdircajImportanci >>, <<iif( lxImpdircajEstadtrans, 1, 0 ) >>, <<iif( lxImpdircajEstadcusto, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpdircajSucdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajSuchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajTsucdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajTsuchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajBase ) + "'" >> )
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
			local  lxImpdircajFecimpo, lxImpdircajFectrans, lxImpdircajFmodifw, lxImpdircajFecexpo, lxImpdircajFaltafw, lxImpdircajBdaltafw, lxImpdircajBdmodifw, lxImpdircajHaltafw, lxImpdircajEsttrans, lxImpdircajHoraexpo, lxImpdircajValtafw, lxImpdircajZadsfw, lxImpdircajVmodifw, lxImpdircajUmodifw, lxImpdircajUaltafw, lxImpdircajHoraimpo, lxImpdircajHmodifw, lxImpdircajSaltafw, lxImpdircajSmodifw, lxImpdircajObs, lxImpdircajImpval, lxImpdircajNumero, lxImpdircajEstadcarte, lxImpdircajEstadentre, lxImpdircajDescripcio, lxImpdircajEstadcobra, lxImpdircajCondesde, lxImpdircajEstaddepos, lxImpdircajConhasta, lxImpdircajEstadrecha, lxImpdircajCladesde, lxImpdircajEstadbaja, lxImpdircajClahasta, lxImpdircajEstaddevol, lxImpdircajCbancdesde, lxImpdircajEstadprepa, lxImpdircajCbanchasta, lxImpdircajEstadenvia, lxImpdircajEstadenvre, lxImpdircajPcuenta, lxImpdircajImportanci, lxImpdircajEstadtrans, lxImpdircajEstadcusto, lxImpdircajSucdesde, lxImpdircajSuchasta, lxImpdircajTsucdesde, lxImpdircajTsuchasta, lxImpdircajBase
				lxImpdircajFecimpo =  .Fechaimpo			lxImpdircajFectrans =  .Fechatransferencia			lxImpdircajFmodifw =  .Fechamodificacionfw			lxImpdircajFecexpo =  .Fechaexpo			lxImpdircajFaltafw =  .Fechaaltafw			lxImpdircajBdaltafw =  .Basededatosaltafw			lxImpdircajBdmodifw =  .Basededatosmodificacionfw			lxImpdircajHaltafw =  .Horaaltafw			lxImpdircajEsttrans =  .Estadotransferencia			lxImpdircajHoraexpo =  .Horaexpo			lxImpdircajValtafw =  .Versionaltafw			lxImpdircajZadsfw =  .Zadsfw			lxImpdircajVmodifw =  .Versionmodificacionfw			lxImpdircajUmodifw =  .Usuariomodificacionfw			lxImpdircajUaltafw =  .Usuarioaltafw			lxImpdircajHoraimpo =  .Horaimpo			lxImpdircajHmodifw =  .Horamodificacionfw			lxImpdircajSaltafw =  .Seriealtafw			lxImpdircajSmodifw =  .Seriemodificacionfw			lxImpdircajObs =  .Observacion			lxImpdircajImpval =  .Imputacion_PK 			lxImpdircajNumero =  .Numero			lxImpdircajEstadcarte =  .Estadoencartera			lxImpdircajEstadentre =  .Estadoentregado			lxImpdircajDescripcio =  .Descripcion			lxImpdircajEstadcobra =  .Estadocobrado			lxImpdircajCondesde =  upper( .f_Concepto_Desde_PK ) 			lxImpdircajEstaddepos =  .Estadodepositado			lxImpdircajConhasta =  upper( .f_Concepto_Hasta_PK ) 			lxImpdircajEstadrecha =  .Estadorechazado			lxImpdircajCladesde =  upper( .f_Clasificacion_Desde_PK ) 			lxImpdircajEstadbaja =  .Estadobaja			lxImpdircajClahasta =  upper( .f_Clasificacion_Hasta_PK ) 			lxImpdircajEstaddevol =  .Estadodevuelto			lxImpdircajCbancdesde =  upper( .f_CuentaBancaria_Desde_PK ) 			lxImpdircajEstadprepa =  .Estadocomprometido			lxImpdircajCbanchasta =  upper( .f_CuentaBancaria_Hasta_PK ) 			lxImpdircajEstadenvia =  .Estadoenviado			lxImpdircajEstadenvre =  .Estadoenviorechazado			lxImpdircajPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdircajImportanci =  .Importancia			lxImpdircajEstadtrans =  .Estadoentransito			lxImpdircajEstadcusto =  .Estadoencustodia			lxImpdircajSucdesde =  upper( .f_Sucursal_Desde_PK ) 			lxImpdircajSuchasta =  upper( .f_Sucursal_Hasta_PK ) 			lxImpdircajTsucdesde =  upper( .f_TipoSucursal_Desde_PK ) 			lxImpdircajTsuchasta =  upper( .f_TipoSucursal_Hasta_PK ) 			lxImpdircajBase =  .Basededatos
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.NUMERO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.IMPDIRCAJ set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpdircajFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxImpdircajFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpdircajFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpdircajFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxImpdircajFaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpdircajBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpdircajBdmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxImpdircajHaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxImpdircajEsttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpdircajHoraexpo ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxImpdircajValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpdircajZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpdircajVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxImpdircajUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpdircajUaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpdircajHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpdircajHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxImpdircajSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxImpdircajSmodifw ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxImpdircajObs ) + "'">>,"Impval" = <<lxImpdircajImpval>>,"Numero" = <<lxImpdircajNumero>>,"Estadcarte" = <<iif( lxImpdircajEstadcarte, 1, 0 )>>,"Estadentre" = <<iif( lxImpdircajEstadentre, 1, 0 )>>,"Descripcio" = <<"'" + this.FormatearTextoSql( lxImpdircajDescripcio ) + "'">>,"Estadcobra" = <<iif( lxImpdircajEstadcobra, 1, 0 )>>,"Condesde" = <<"'" + this.FormatearTextoSql( lxImpdircajCondesde ) + "'">>,"Estaddepos" = <<iif( lxImpdircajEstaddepos, 1, 0 )>>,"Conhasta" = <<"'" + this.FormatearTextoSql( lxImpdircajConhasta ) + "'">>,"Estadrecha" = <<iif( lxImpdircajEstadrecha, 1, 0 )>>,"Cladesde" = <<"'" + this.FormatearTextoSql( lxImpdircajCladesde ) + "'">>,"Estadbaja" = <<iif( lxImpdircajEstadbaja, 1, 0 )>>,"Clahasta" = <<"'" + this.FormatearTextoSql( lxImpdircajClahasta ) + "'">>,"Estaddevol" = <<iif( lxImpdircajEstaddevol, 1, 0 )>>,"Cbancdesde" = <<"'" + this.FormatearTextoSql( lxImpdircajCbancdesde ) + "'">>,"Estadprepa" = <<iif( lxImpdircajEstadprepa, 1, 0 )>>,"Cbanchasta" = <<"'" + this.FormatearTextoSql( lxImpdircajCbanchasta ) + "'">>,"Estadenvia" = <<iif( lxImpdircajEstadenvia, 1, 0 )>>,"Estadenvre" = <<iif( lxImpdircajEstadenvre, 1, 0 )>>,"Pcuenta" = <<"'" + this.FormatearTextoSql( lxImpdircajPcuenta ) + "'">>,"Importanci" = <<lxImpdircajImportanci>>,"Estadtrans" = <<iif( lxImpdircajEstadtrans, 1, 0 )>>,"Estadcusto" = <<iif( lxImpdircajEstadcusto, 1, 0 )>>,"Sucdesde" = <<"'" + this.FormatearTextoSql( lxImpdircajSucdesde ) + "'">>,"Suchasta" = <<"'" + this.FormatearTextoSql( lxImpdircajSuchasta ) + "'">>,"Tsucdesde" = <<"'" + this.FormatearTextoSql( lxImpdircajTsucdesde ) + "'">>,"Tsuchasta" = <<"'" + this.FormatearTextoSql( lxImpdircajTsuchasta ) + "'">>,"Base" = <<"'" + this.FormatearTextoSql( lxImpdircajBase ) + "'">> where "Numero" = <<lxImpdircajNumero>> and  IMPDIRCAJ.NUMERO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 NUMERO from ZooLogic.IMPDIRCAJ where " + this.ConvertirFuncionesSql( " IMPDIRCAJ.NUMERO != 0" ) )
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
			Local lxImpdircajNumero
			lxImpdircajNumero = .Numero

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Obs" as "Observacion", "Impval" as "Imputacion", "Numero" as "Numero", "Estadcarte" as "Estadoencartera", "Estadentre" as "Estadoentregado", "Descripcio" as "Descripcion", "Estadcobra" as "Estadocobrado", "Condesde" as "F_concepto_desde", "Estaddepos" as "Estadodepositado", "Conhasta" as "F_concepto_hasta", "Estadrecha" as "Estadorechazado", "Cladesde" as "F_clasificacion_desde", "Estadbaja" as "Estadobaja", "Clahasta" as "F_clasificacion_hasta", "Estaddevol" as "Estadodevuelto", "Cbancdesde" as "F_cuentabancaria_desde", "Estadprepa" as "Estadocomprometido", "Cbanchasta" as "F_cuentabancaria_hasta", "Estadenvia" as "Estadoenviado", "Estadenvre" as "Estadoenviorechazado", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Estadtrans" as "Estadoentransito", "Estadcusto" as "Estadoencustodia", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos" from ZooLogic.IMPDIRCAJ where "Numero" = <<lxImpdircajNumero>> and  IMPDIRCAJ.NUMERO != 0
			endtext
			use in select('c_IMPDIRCAJ')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCAJ', set( 'Datasession' ) )

			if reccount( 'c_IMPDIRCAJ' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxImpdircajNumero as Variant
		llRetorno = .t.
		lxImpdircajNumero = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.IMPDIRCAJ where "Numero" = <<lxImpdircajNumero>> and  IMPDIRCAJ.NUMERO != 0
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Obs" as "Observacion", "Impval" as "Imputacion", "Numero" as "Numero", "Estadcarte" as "Estadoencartera", "Estadentre" as "Estadoentregado", "Descripcio" as "Descripcion", "Estadcobra" as "Estadocobrado", "Condesde" as "F_concepto_desde", "Estaddepos" as "Estadodepositado", "Conhasta" as "F_concepto_hasta", "Estadrecha" as "Estadorechazado", "Cladesde" as "F_clasificacion_desde", "Estadbaja" as "Estadobaja", "Clahasta" as "F_clasificacion_hasta", "Estaddevol" as "Estadodevuelto", "Cbancdesde" as "F_cuentabancaria_desde", "Estadprepa" as "Estadocomprometido", "Cbanchasta" as "F_cuentabancaria_hasta", "Estadenvia" as "Estadoenviado", "Estadenvre" as "Estadoenviorechazado", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Estadtrans" as "Estadoentransito", "Estadcusto" as "Estadoencustodia", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos" from ZooLogic.IMPDIRCAJ where  IMPDIRCAJ.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_IMPDIRCAJ')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCAJ', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Obs" as "Observacion", "Impval" as "Imputacion", "Numero" as "Numero", "Estadcarte" as "Estadoencartera", "Estadentre" as "Estadoentregado", "Descripcio" as "Descripcion", "Estadcobra" as "Estadocobrado", "Condesde" as "F_concepto_desde", "Estaddepos" as "Estadodepositado", "Conhasta" as "F_concepto_hasta", "Estadrecha" as "Estadorechazado", "Cladesde" as "F_clasificacion_desde", "Estadbaja" as "Estadobaja", "Clahasta" as "F_clasificacion_hasta", "Estaddevol" as "Estadodevuelto", "Cbancdesde" as "F_cuentabancaria_desde", "Estadprepa" as "Estadocomprometido", "Cbanchasta" as "F_cuentabancaria_hasta", "Estadenvia" as "Estadoenviado", "Estadenvre" as "Estadoenviorechazado", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Estadtrans" as "Estadoentransito", "Estadcusto" as "Estadoencustodia", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos" from ZooLogic.IMPDIRCAJ where  str( NUMERO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPDIRCAJ.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_IMPDIRCAJ')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCAJ', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Obs" as "Observacion", "Impval" as "Imputacion", "Numero" as "Numero", "Estadcarte" as "Estadoencartera", "Estadentre" as "Estadoentregado", "Descripcio" as "Descripcion", "Estadcobra" as "Estadocobrado", "Condesde" as "F_concepto_desde", "Estaddepos" as "Estadodepositado", "Conhasta" as "F_concepto_hasta", "Estadrecha" as "Estadorechazado", "Cladesde" as "F_clasificacion_desde", "Estadbaja" as "Estadobaja", "Clahasta" as "F_clasificacion_hasta", "Estaddevol" as "Estadodevuelto", "Cbancdesde" as "F_cuentabancaria_desde", "Estadprepa" as "Estadocomprometido", "Cbanchasta" as "F_cuentabancaria_hasta", "Estadenvia" as "Estadoenviado", "Estadenvre" as "Estadoenviorechazado", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Estadtrans" as "Estadoentransito", "Estadcusto" as "Estadoencustodia", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos" from ZooLogic.IMPDIRCAJ where  str( NUMERO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPDIRCAJ.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_IMPDIRCAJ')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCAJ', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Obs" as "Observacion", "Impval" as "Imputacion", "Numero" as "Numero", "Estadcarte" as "Estadoencartera", "Estadentre" as "Estadoentregado", "Descripcio" as "Descripcion", "Estadcobra" as "Estadocobrado", "Condesde" as "F_concepto_desde", "Estaddepos" as "Estadodepositado", "Conhasta" as "F_concepto_hasta", "Estadrecha" as "Estadorechazado", "Cladesde" as "F_clasificacion_desde", "Estadbaja" as "Estadobaja", "Clahasta" as "F_clasificacion_hasta", "Estaddevol" as "Estadodevuelto", "Cbancdesde" as "F_cuentabancaria_desde", "Estadprepa" as "Estadocomprometido", "Cbanchasta" as "F_cuentabancaria_hasta", "Estadenvia" as "Estadoenviado", "Estadenvre" as "Estadoenviorechazado", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Estadtrans" as "Estadoentransito", "Estadcusto" as "Estadoencustodia", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos" from ZooLogic.IMPDIRCAJ where  IMPDIRCAJ.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_IMPDIRCAJ')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCAJ', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Bdaltafw,Bdmodifw,Haltafw,Esttrans,Horaexpo,Valtafw" + ;
",Zadsfw,Vmodifw,Umodifw,Ualtafw,Horaimpo,Hmodifw,Saltafw,Smodifw,Obs,Impval,Numero,Estadcarte,Estade" + ;
"ntre,Descripcio,Estadcobra,Condesde,Estaddepos,Conhasta,Estadrecha,Cladesde,Estadbaja,Clahasta,Estad" + ;
"devol,Cbancdesde,Estadprepa,Cbanchasta,Estadenvia,Estadenvre,Pcuenta,Importanci,Estadtrans,Estadcust" + ;
"o,Sucdesde,Suchasta,Tsucdesde,Tsuchasta,Base" + ;
" from ZooLogic.IMPDIRCAJ where  IMPDIRCAJ.NUMERO != 0 and " + lcFiltro )
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
			local  lxImpdircajFecimpo, lxImpdircajFectrans, lxImpdircajFmodifw, lxImpdircajFecexpo, lxImpdircajFaltafw, lxImpdircajBdaltafw, lxImpdircajBdmodifw, lxImpdircajHaltafw, lxImpdircajEsttrans, lxImpdircajHoraexpo, lxImpdircajValtafw, lxImpdircajZadsfw, lxImpdircajVmodifw, lxImpdircajUmodifw, lxImpdircajUaltafw, lxImpdircajHoraimpo, lxImpdircajHmodifw, lxImpdircajSaltafw, lxImpdircajSmodifw, lxImpdircajObs, lxImpdircajImpval, lxImpdircajNumero, lxImpdircajEstadcarte, lxImpdircajEstadentre, lxImpdircajDescripcio, lxImpdircajEstadcobra, lxImpdircajCondesde, lxImpdircajEstaddepos, lxImpdircajConhasta, lxImpdircajEstadrecha, lxImpdircajCladesde, lxImpdircajEstadbaja, lxImpdircajClahasta, lxImpdircajEstaddevol, lxImpdircajCbancdesde, lxImpdircajEstadprepa, lxImpdircajCbanchasta, lxImpdircajEstadenvia, lxImpdircajEstadenvre, lxImpdircajPcuenta, lxImpdircajImportanci, lxImpdircajEstadtrans, lxImpdircajEstadcusto, lxImpdircajSucdesde, lxImpdircajSuchasta, lxImpdircajTsucdesde, lxImpdircajTsuchasta, lxImpdircajBase
				lxImpdircajFecimpo = ctod( '  /  /    ' )			lxImpdircajFectrans = ctod( '  /  /    ' )			lxImpdircajFmodifw = ctod( '  /  /    ' )			lxImpdircajFecexpo = ctod( '  /  /    ' )			lxImpdircajFaltafw = ctod( '  /  /    ' )			lxImpdircajBdaltafw = []			lxImpdircajBdmodifw = []			lxImpdircajHaltafw = []			lxImpdircajEsttrans = []			lxImpdircajHoraexpo = []			lxImpdircajValtafw = []			lxImpdircajZadsfw = []			lxImpdircajVmodifw = []			lxImpdircajUmodifw = []			lxImpdircajUaltafw = []			lxImpdircajHoraimpo = []			lxImpdircajHmodifw = []			lxImpdircajSaltafw = []			lxImpdircajSmodifw = []			lxImpdircajObs = []			lxImpdircajImpval = 0			lxImpdircajNumero = 0			lxImpdircajEstadcarte = .F.			lxImpdircajEstadentre = .F.			lxImpdircajDescripcio = []			lxImpdircajEstadcobra = .F.			lxImpdircajCondesde = []			lxImpdircajEstaddepos = .F.			lxImpdircajConhasta = []			lxImpdircajEstadrecha = .F.			lxImpdircajCladesde = []			lxImpdircajEstadbaja = .F.			lxImpdircajClahasta = []			lxImpdircajEstaddevol = .F.			lxImpdircajCbancdesde = []			lxImpdircajEstadprepa = .F.			lxImpdircajCbanchasta = []			lxImpdircajEstadenvia = .F.			lxImpdircajEstadenvre = .F.			lxImpdircajPcuenta = []			lxImpdircajImportanci = 0			lxImpdircajEstadtrans = .F.			lxImpdircajEstadcusto = .F.			lxImpdircajSucdesde = []			lxImpdircajSuchasta = []			lxImpdircajTsucdesde = []			lxImpdircajTsuchasta = []			lxImpdircajBase = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.IMPDIRCAJ where "NUMERO" = ] + transform( .oEntidad.NUMERO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'IMPDIRCAJ' + '_' + tcCampo
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
		lcWhere = " Where  IMPDIRCAJ.NUMERO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Obs" as "Observacion", "Impval" as "Imputacion", "Numero" as "Numero", "Estadcarte" as "Estadoencartera", "Estadentre" as "Estadoentregado", "Descripcio" as "Descripcion", "Estadcobra" as "Estadocobrado", "Condesde" as "F_concepto_desde", "Estaddepos" as "Estadodepositado", "Conhasta" as "F_concepto_hasta", "Estadrecha" as "Estadorechazado", "Cladesde" as "F_clasificacion_desde", "Estadbaja" as "Estadobaja", "Clahasta" as "F_clasificacion_hasta", "Estaddevol" as "Estadodevuelto", "Cbancdesde" as "F_cuentabancaria_desde", "Estadprepa" as "Estadocomprometido", "Cbanchasta" as "F_cuentabancaria_hasta", "Estadenvia" as "Estadoenviado", "Estadenvre" as "Estadoenviorechazado", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Estadtrans" as "Estadoentransito", "Estadcusto" as "Estadoencustodia", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'IMPDIRCAJ', '', tnTope )
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
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
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
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'IMPUTACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPVAL AS IMPUTACION'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'ESTADOENCARTERA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADCARTE AS ESTADOENCARTERA'
				Case lcAtributo == 'ESTADOENTREGADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADENTRE AS ESTADOENTREGADO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIPCIO AS DESCRIPCION'
				Case lcAtributo == 'ESTADOCOBRADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADCOBRA AS ESTADOCOBRADO'
				Case lcAtributo == 'F_CONCEPTO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDESDE AS F_CONCEPTO_DESDE'
				Case lcAtributo == 'ESTADODEPOSITADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADDEPOS AS ESTADODEPOSITADO'
				Case lcAtributo == 'F_CONCEPTO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONHASTA AS F_CONCEPTO_HASTA'
				Case lcAtributo == 'ESTADORECHAZADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADRECHA AS ESTADORECHAZADO'
				Case lcAtributo == 'F_CLASIFICACION_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLADESDE AS F_CLASIFICACION_DESDE'
				Case lcAtributo == 'ESTADOBAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADBAJA AS ESTADOBAJA'
				Case lcAtributo == 'F_CLASIFICACION_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLAHASTA AS F_CLASIFICACION_HASTA'
				Case lcAtributo == 'ESTADODEVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADDEVOL AS ESTADODEVUELTO'
				Case lcAtributo == 'F_CUENTABANCARIA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBANCDESDE AS F_CUENTABANCARIA_DESDE'
				Case lcAtributo == 'ESTADOCOMPROMETIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADPREPA AS ESTADOCOMPROMETIDO'
				Case lcAtributo == 'F_CUENTABANCARIA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBANCHASTA AS F_CUENTABANCARIA_HASTA'
				Case lcAtributo == 'ESTADOENVIADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADENVIA AS ESTADOENVIADO'
				Case lcAtributo == 'ESTADOENVIORECHAZADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADENVRE AS ESTADOENVIORECHAZADO'
				Case lcAtributo == 'PLANDECUENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PCUENTA AS PLANDECUENTAS'
				Case lcAtributo == 'IMPORTANCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPORTANCI AS IMPORTANCIA'
				Case lcAtributo == 'ESTADOENTRANSITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADTRANS AS ESTADOENTRANSITO'
				Case lcAtributo == 'ESTADOENCUSTODIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADCUSTO AS ESTADOENCUSTODIA'
				Case lcAtributo == 'F_SUCURSAL_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUCDESDE AS F_SUCURSAL_DESDE'
				Case lcAtributo == 'F_SUCURSAL_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUCHASTA AS F_SUCURSAL_HASTA'
				Case lcAtributo == 'F_TIPOSUCURSAL_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TSUCDESDE AS F_TIPOSUCURSAL_DESDE'
				Case lcAtributo == 'F_TIPOSUCURSAL_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TSUCHASTA AS F_TIPOSUCURSAL_HASTA'
				Case lcAtributo == 'BASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASE AS BASEDEDATOS'
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
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
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
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUTACION'
				lcCampo = 'IMPVAL'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOENCARTERA'
				lcCampo = 'ESTADCARTE'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOENTREGADO'
				lcCampo = 'ESTADENTRE'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIPCIO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOCOBRADO'
				lcCampo = 'ESTADCOBRA'
			Case upper( alltrim( tcAtributo ) ) == 'F_CONCEPTO_DESDE'
				lcCampo = 'CONDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADODEPOSITADO'
				lcCampo = 'ESTADDEPOS'
			Case upper( alltrim( tcAtributo ) ) == 'F_CONCEPTO_HASTA'
				lcCampo = 'CONHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADORECHAZADO'
				lcCampo = 'ESTADRECHA'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLASIFICACION_DESDE'
				lcCampo = 'CLADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOBAJA'
				lcCampo = 'ESTADBAJA'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLASIFICACION_HASTA'
				lcCampo = 'CLAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADODEVUELTO'
				lcCampo = 'ESTADDEVOL'
			Case upper( alltrim( tcAtributo ) ) == 'F_CUENTABANCARIA_DESDE'
				lcCampo = 'CBANCDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOCOMPROMETIDO'
				lcCampo = 'ESTADPREPA'
			Case upper( alltrim( tcAtributo ) ) == 'F_CUENTABANCARIA_HASTA'
				lcCampo = 'CBANCHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOENVIADO'
				lcCampo = 'ESTADENVIA'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOENVIORECHAZADO'
				lcCampo = 'ESTADENVRE'
			Case upper( alltrim( tcAtributo ) ) == 'PLANDECUENTAS'
				lcCampo = 'PCUENTA'
			Case upper( alltrim( tcAtributo ) ) == 'IMPORTANCIA'
				lcCampo = 'IMPORTANCI'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOENTRANSITO'
				lcCampo = 'ESTADTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOENCUSTODIA'
				lcCampo = 'ESTADCUSTO'
			Case upper( alltrim( tcAtributo ) ) == 'F_SUCURSAL_DESDE'
				lcCampo = 'SUCDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_SUCURSAL_HASTA'
				lcCampo = 'SUCHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_TIPOSUCURSAL_DESDE'
				lcCampo = 'TSUCDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_TIPOSUCURSAL_HASTA'
				lcCampo = 'TSUCHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOS'
				lcCampo = 'BASE'
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
			local  lxImpdircajFecimpo, lxImpdircajFectrans, lxImpdircajFmodifw, lxImpdircajFecexpo, lxImpdircajFaltafw, lxImpdircajBdaltafw, lxImpdircajBdmodifw, lxImpdircajHaltafw, lxImpdircajEsttrans, lxImpdircajHoraexpo, lxImpdircajValtafw, lxImpdircajZadsfw, lxImpdircajVmodifw, lxImpdircajUmodifw, lxImpdircajUaltafw, lxImpdircajHoraimpo, lxImpdircajHmodifw, lxImpdircajSaltafw, lxImpdircajSmodifw, lxImpdircajObs, lxImpdircajImpval, lxImpdircajNumero, lxImpdircajEstadcarte, lxImpdircajEstadentre, lxImpdircajDescripcio, lxImpdircajEstadcobra, lxImpdircajCondesde, lxImpdircajEstaddepos, lxImpdircajConhasta, lxImpdircajEstadrecha, lxImpdircajCladesde, lxImpdircajEstadbaja, lxImpdircajClahasta, lxImpdircajEstaddevol, lxImpdircajCbancdesde, lxImpdircajEstadprepa, lxImpdircajCbanchasta, lxImpdircajEstadenvia, lxImpdircajEstadenvre, lxImpdircajPcuenta, lxImpdircajImportanci, lxImpdircajEstadtrans, lxImpdircajEstadcusto, lxImpdircajSucdesde, lxImpdircajSuchasta, lxImpdircajTsucdesde, lxImpdircajTsuchasta, lxImpdircajBase
				lxImpdircajFecimpo =  .Fechaimpo			lxImpdircajFectrans =  .Fechatransferencia			lxImpdircajFmodifw =  .Fechamodificacionfw			lxImpdircajFecexpo =  .Fechaexpo			lxImpdircajFaltafw =  .Fechaaltafw			lxImpdircajBdaltafw =  .Basededatosaltafw			lxImpdircajBdmodifw =  .Basededatosmodificacionfw			lxImpdircajHaltafw =  .Horaaltafw			lxImpdircajEsttrans =  .Estadotransferencia			lxImpdircajHoraexpo =  .Horaexpo			lxImpdircajValtafw =  .Versionaltafw			lxImpdircajZadsfw =  .Zadsfw			lxImpdircajVmodifw =  .Versionmodificacionfw			lxImpdircajUmodifw =  .Usuariomodificacionfw			lxImpdircajUaltafw =  .Usuarioaltafw			lxImpdircajHoraimpo =  .Horaimpo			lxImpdircajHmodifw =  .Horamodificacionfw			lxImpdircajSaltafw =  .Seriealtafw			lxImpdircajSmodifw =  .Seriemodificacionfw			lxImpdircajObs =  .Observacion			lxImpdircajImpval =  .Imputacion_PK 			lxImpdircajNumero =  .Numero			lxImpdircajEstadcarte =  .Estadoencartera			lxImpdircajEstadentre =  .Estadoentregado			lxImpdircajDescripcio =  .Descripcion			lxImpdircajEstadcobra =  .Estadocobrado			lxImpdircajCondesde =  upper( .f_Concepto_Desde_PK ) 			lxImpdircajEstaddepos =  .Estadodepositado			lxImpdircajConhasta =  upper( .f_Concepto_Hasta_PK ) 			lxImpdircajEstadrecha =  .Estadorechazado			lxImpdircajCladesde =  upper( .f_Clasificacion_Desde_PK ) 			lxImpdircajEstadbaja =  .Estadobaja			lxImpdircajClahasta =  upper( .f_Clasificacion_Hasta_PK ) 			lxImpdircajEstaddevol =  .Estadodevuelto			lxImpdircajCbancdesde =  upper( .f_CuentaBancaria_Desde_PK ) 			lxImpdircajEstadprepa =  .Estadocomprometido			lxImpdircajCbanchasta =  upper( .f_CuentaBancaria_Hasta_PK ) 			lxImpdircajEstadenvia =  .Estadoenviado			lxImpdircajEstadenvre =  .Estadoenviorechazado			lxImpdircajPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdircajImportanci =  .Importancia			lxImpdircajEstadtrans =  .Estadoentransito			lxImpdircajEstadcusto =  .Estadoencustodia			lxImpdircajSucdesde =  upper( .f_Sucursal_Desde_PK ) 			lxImpdircajSuchasta =  upper( .f_Sucursal_Hasta_PK ) 			lxImpdircajTsucdesde =  upper( .f_TipoSucursal_Desde_PK ) 			lxImpdircajTsuchasta =  upper( .f_TipoSucursal_Hasta_PK ) 			lxImpdircajBase =  .Basededatos
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.IMPDIRCAJ ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Bdaltafw","Bdmodifw","Haltafw","Esttrans","Horaexpo","Valtafw","Zadsfw","Vmodifw","Umodifw","Ualtafw","Horaimpo","Hmodifw","Saltafw","Smodifw","Obs","Impval","Numero","Estadcarte","Estadentre","Descripcio","Estadcobra","Condesde","Estaddepos","Conhasta","Estadrecha","Cladesde","Estadbaja","Clahasta","Estaddevol","Cbancdesde","Estadprepa","Cbanchasta","Estadenvia","Estadenvre","Pcuenta","Importanci","Estadtrans","Estadcusto","Sucdesde","Suchasta","Tsucdesde","Tsuchasta","Base" ) values ( <<"'" + this.ConvertirDateSql( lxImpdircajFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircajFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircajFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircajFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircajFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajObs ) + "'" >>, <<lxImpdircajImpval >>, <<lxImpdircajNumero >>, <<iif( lxImpdircajEstadcarte, 1, 0 ) >>, <<iif( lxImpdircajEstadentre, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpdircajDescripcio ) + "'" >>, <<iif( lxImpdircajEstadcobra, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpdircajCondesde ) + "'" >>, <<iif( lxImpdircajEstaddepos, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpdircajConhasta ) + "'" >>, <<iif( lxImpdircajEstadrecha, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpdircajCladesde ) + "'" >>, <<iif( lxImpdircajEstadbaja, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpdircajClahasta ) + "'" >>, <<iif( lxImpdircajEstaddevol, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpdircajCbancdesde ) + "'" >>, <<iif( lxImpdircajEstadprepa, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpdircajCbanchasta ) + "'" >>, <<iif( lxImpdircajEstadenvia, 1, 0 ) >>, <<iif( lxImpdircajEstadenvre, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpdircajPcuenta ) + "'" >>, <<lxImpdircajImportanci >>, <<iif( lxImpdircajEstadtrans, 1, 0 ) >>, <<iif( lxImpdircajEstadcusto, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpdircajSucdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajSuchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajTsucdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajTsuchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircajBase ) + "'" >> )
		endtext
		loColeccion.cTabla = 'IMPDIRCAJ' 
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
			local  lxImpdircajFecimpo, lxImpdircajFectrans, lxImpdircajFmodifw, lxImpdircajFecexpo, lxImpdircajFaltafw, lxImpdircajBdaltafw, lxImpdircajBdmodifw, lxImpdircajHaltafw, lxImpdircajEsttrans, lxImpdircajHoraexpo, lxImpdircajValtafw, lxImpdircajZadsfw, lxImpdircajVmodifw, lxImpdircajUmodifw, lxImpdircajUaltafw, lxImpdircajHoraimpo, lxImpdircajHmodifw, lxImpdircajSaltafw, lxImpdircajSmodifw, lxImpdircajObs, lxImpdircajImpval, lxImpdircajNumero, lxImpdircajEstadcarte, lxImpdircajEstadentre, lxImpdircajDescripcio, lxImpdircajEstadcobra, lxImpdircajCondesde, lxImpdircajEstaddepos, lxImpdircajConhasta, lxImpdircajEstadrecha, lxImpdircajCladesde, lxImpdircajEstadbaja, lxImpdircajClahasta, lxImpdircajEstaddevol, lxImpdircajCbancdesde, lxImpdircajEstadprepa, lxImpdircajCbanchasta, lxImpdircajEstadenvia, lxImpdircajEstadenvre, lxImpdircajPcuenta, lxImpdircajImportanci, lxImpdircajEstadtrans, lxImpdircajEstadcusto, lxImpdircajSucdesde, lxImpdircajSuchasta, lxImpdircajTsucdesde, lxImpdircajTsuchasta, lxImpdircajBase
				lxImpdircajFecimpo =  .Fechaimpo			lxImpdircajFectrans =  .Fechatransferencia			lxImpdircajFmodifw =  .Fechamodificacionfw			lxImpdircajFecexpo =  .Fechaexpo			lxImpdircajFaltafw =  .Fechaaltafw			lxImpdircajBdaltafw =  .Basededatosaltafw			lxImpdircajBdmodifw =  .Basededatosmodificacionfw			lxImpdircajHaltafw =  .Horaaltafw			lxImpdircajEsttrans =  .Estadotransferencia			lxImpdircajHoraexpo =  .Horaexpo			lxImpdircajValtafw =  .Versionaltafw			lxImpdircajZadsfw =  .Zadsfw			lxImpdircajVmodifw =  .Versionmodificacionfw			lxImpdircajUmodifw =  .Usuariomodificacionfw			lxImpdircajUaltafw =  .Usuarioaltafw			lxImpdircajHoraimpo =  .Horaimpo			lxImpdircajHmodifw =  .Horamodificacionfw			lxImpdircajSaltafw =  .Seriealtafw			lxImpdircajSmodifw =  .Seriemodificacionfw			lxImpdircajObs =  .Observacion			lxImpdircajImpval =  .Imputacion_PK 			lxImpdircajNumero =  .Numero			lxImpdircajEstadcarte =  .Estadoencartera			lxImpdircajEstadentre =  .Estadoentregado			lxImpdircajDescripcio =  .Descripcion			lxImpdircajEstadcobra =  .Estadocobrado			lxImpdircajCondesde =  upper( .f_Concepto_Desde_PK ) 			lxImpdircajEstaddepos =  .Estadodepositado			lxImpdircajConhasta =  upper( .f_Concepto_Hasta_PK ) 			lxImpdircajEstadrecha =  .Estadorechazado			lxImpdircajCladesde =  upper( .f_Clasificacion_Desde_PK ) 			lxImpdircajEstadbaja =  .Estadobaja			lxImpdircajClahasta =  upper( .f_Clasificacion_Hasta_PK ) 			lxImpdircajEstaddevol =  .Estadodevuelto			lxImpdircajCbancdesde =  upper( .f_CuentaBancaria_Desde_PK ) 			lxImpdircajEstadprepa =  .Estadocomprometido			lxImpdircajCbanchasta =  upper( .f_CuentaBancaria_Hasta_PK ) 			lxImpdircajEstadenvia =  .Estadoenviado			lxImpdircajEstadenvre =  .Estadoenviorechazado			lxImpdircajPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdircajImportanci =  .Importancia			lxImpdircajEstadtrans =  .Estadoentransito			lxImpdircajEstadcusto =  .Estadoencustodia			lxImpdircajSucdesde =  upper( .f_Sucursal_Desde_PK ) 			lxImpdircajSuchasta =  upper( .f_Sucursal_Hasta_PK ) 			lxImpdircajTsucdesde =  upper( .f_TipoSucursal_Desde_PK ) 			lxImpdircajTsuchasta =  upper( .f_TipoSucursal_Hasta_PK ) 			lxImpdircajBase =  .Basededatos
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  IMPDIRCAJ.NUMERO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.IMPDIRCAJ set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpdircajFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxImpdircajFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpdircajFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpdircajFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxImpdircajFaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpdircajBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpdircajBdmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxImpdircajHaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxImpdircajEsttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpdircajHoraexpo ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxImpdircajValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpdircajZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpdircajVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxImpdircajUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpdircajUaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpdircajHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpdircajHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxImpdircajSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxImpdircajSmodifw ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxImpdircajObs ) + "'">>, "Impval" = <<lxImpdircajImpval>>, "Numero" = <<lxImpdircajNumero>>, "Estadcarte" = <<iif( lxImpdircajEstadcarte, 1, 0 )>>, "Estadentre" = <<iif( lxImpdircajEstadentre, 1, 0 )>>, "Descripcio" = <<"'" + this.FormatearTextoSql( lxImpdircajDescripcio ) + "'">>, "Estadcobra" = <<iif( lxImpdircajEstadcobra, 1, 0 )>>, "Condesde" = <<"'" + this.FormatearTextoSql( lxImpdircajCondesde ) + "'">>, "Estaddepos" = <<iif( lxImpdircajEstaddepos, 1, 0 )>>, "Conhasta" = <<"'" + this.FormatearTextoSql( lxImpdircajConhasta ) + "'">>, "Estadrecha" = <<iif( lxImpdircajEstadrecha, 1, 0 )>>, "Cladesde" = <<"'" + this.FormatearTextoSql( lxImpdircajCladesde ) + "'">>, "Estadbaja" = <<iif( lxImpdircajEstadbaja, 1, 0 )>>, "Clahasta" = <<"'" + this.FormatearTextoSql( lxImpdircajClahasta ) + "'">>, "Estaddevol" = <<iif( lxImpdircajEstaddevol, 1, 0 )>>, "Cbancdesde" = <<"'" + this.FormatearTextoSql( lxImpdircajCbancdesde ) + "'">>, "Estadprepa" = <<iif( lxImpdircajEstadprepa, 1, 0 )>>, "Cbanchasta" = <<"'" + this.FormatearTextoSql( lxImpdircajCbanchasta ) + "'">>, "Estadenvia" = <<iif( lxImpdircajEstadenvia, 1, 0 )>>, "Estadenvre" = <<iif( lxImpdircajEstadenvre, 1, 0 )>>, "Pcuenta" = <<"'" + this.FormatearTextoSql( lxImpdircajPcuenta ) + "'">>, "Importanci" = <<lxImpdircajImportanci>>, "Estadtrans" = <<iif( lxImpdircajEstadtrans, 1, 0 )>>, "Estadcusto" = <<iif( lxImpdircajEstadcusto, 1, 0 )>>, "Sucdesde" = <<"'" + this.FormatearTextoSql( lxImpdircajSucdesde ) + "'">>, "Suchasta" = <<"'" + this.FormatearTextoSql( lxImpdircajSuchasta ) + "'">>, "Tsucdesde" = <<"'" + this.FormatearTextoSql( lxImpdircajTsucdesde ) + "'">>, "Tsuchasta" = <<"'" + this.FormatearTextoSql( lxImpdircajTsuchasta ) + "'">>, "Base" = <<"'" + this.FormatearTextoSql( lxImpdircajBase ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'IMPDIRCAJ' 
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

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  IMPDIRCAJ.NUMERO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.IMPDIRCAJ where ' + lcFiltro )
			loColeccion.cTabla = 'IMPDIRCAJ' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.IMPDIRCAJ where  IMPDIRCAJ.NUMERO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.IMPDIRCAJ where NUMERO = " + transform( this.oEntidad.NUMERO )+ " and  IMPDIRCAJ.NUMERO != 0" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCAJ'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.IMPDIRCAJ Where NUMERO = ] + transform( &lcCursor..NUMERO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.IMPDIRCAJ set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, OBS = ] + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'"+ [, ImpVal = ] + transform( &lcCursor..ImpVal )+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, EstadCarte = ] + Transform( iif( &lcCursor..EstadCarte, 1, 0 ))+ [, EstadEntre = ] + Transform( iif( &lcCursor..EstadEntre, 1, 0 ))+ [, Descripcio = ] + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'"+ [, EstadCobra = ] + Transform( iif( &lcCursor..EstadCobra, 1, 0 ))+ [, ConDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ConDesde ) + "'"+ [, EstadDepos = ] + Transform( iif( &lcCursor..EstadDepos, 1, 0 ))+ [, ConHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ConHasta ) + "'"+ [, EstadRecha = ] + Transform( iif( &lcCursor..EstadRecha, 1, 0 ))+ [, ClaDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ClaDesde ) + "'"+ [, EstadBaja = ] + Transform( iif( &lcCursor..EstadBaja, 1, 0 ))+ [, ClaHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ClaHasta ) + "'"+ [, EstadDevol = ] + Transform( iif( &lcCursor..EstadDevol, 1, 0 ))+ [, CBancDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..CBancDesde ) + "'"+ [, EstadPrepa = ] + Transform( iif( &lcCursor..EstadPrepa, 1, 0 ))+ [, CBancHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..CBancHasta ) + "'"+ [, EstadEnvia = ] + Transform( iif( &lcCursor..EstadEnvia, 1, 0 ))+ [, EstadEnvre = ] + Transform( iif( &lcCursor..EstadEnvre, 1, 0 ))+ [, PCUENTA = ] + "'" + this.FormatearTextoSql( &lcCursor..PCUENTA ) + "'"+ [, Importanci = ] + transform( &lcCursor..Importanci )+ [, EstadTrans = ] + Transform( iif( &lcCursor..EstadTrans, 1, 0 ))+ [, EstadCusto = ] + Transform( iif( &lcCursor..EstadCusto, 1, 0 ))+ [, SucDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..SucDesde ) + "'"+ [, SucHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..SucHasta ) + "'"+ [, TSucDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TSucDesde ) + "'"+ [, TSucHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TSucHasta ) + "'"+ [, Base = ] + "'" + this.FormatearTextoSql( &lcCursor..Base ) + "'" + [ Where NUMERO = ] + transform( &lcCursor..NUMERO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, BDALTAFW, BDMODIFW, HALTAFW, ESTTRANS, HORAEXPO, VALTAFW, ZADSFW, VMODIFW, UMODIFW, UALTAFW, HORAIMPO, HMODIFW, SALTAFW, SMODIFW, OBS, ImpVal, NUMERO, EstadCarte, EstadEntre, Descripcio, EstadCobra, ConDesde, EstadDepos, ConHasta, EstadRecha, ClaDesde, EstadBaja, ClaHasta, EstadDevol, CBancDesde, EstadPrepa, CBancHasta, EstadEnvia, EstadEnvre, PCUENTA, Importanci, EstadTrans, EstadCusto, SucDesde, SucHasta, TSucDesde, TSucHasta, Base
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'" + ',' + transform( &lcCursor..ImpVal )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..NUMERO ) + ',' + Transform( iif( &lcCursor..EstadCarte, 1, 0 )) + ',' + Transform( iif( &lcCursor..EstadEntre, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'" + ',' + Transform( iif( &lcCursor..EstadCobra, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ConDesde ) + "'" + ',' + Transform( iif( &lcCursor..EstadDepos, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ConHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..EstadRecha, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClaDesde ) + "'" + ',' + Transform( iif( &lcCursor..EstadBaja, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClaHasta ) + "'" + ',' + Transform( iif( &lcCursor..EstadDevol, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CBancDesde ) + "'" + ',' + Transform( iif( &lcCursor..EstadPrepa, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CBancHasta ) + "'" + ',' + Transform( iif( &lcCursor..EstadEnvia, 1, 0 )) + ',' + Transform( iif( &lcCursor..EstadEnvre, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..PCUENTA ) + "'" + ',' + transform( &lcCursor..Importanci ) + ',' + Transform( iif( &lcCursor..EstadTrans, 1, 0 )) + ',' + Transform( iif( &lcCursor..EstadCusto, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SucDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SucHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TSucDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TSucHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Base ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.IMPDIRCAJ ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCAJ'
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
			Case  lcAlias == lcPrefijo + 'IMPDIRCAJ'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPDIRCAJ_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPDIRCAJ_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_IMPDIRCAJ')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'IMPDIRCAJ'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..NUMERO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad IMPDIRCAJ. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCAJ'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCAJ'
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IMPDIRCAJ') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IMPDIRCAJ
Create Table ZooLogic.TablaTrabajo_IMPDIRCAJ ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"obs" varchar(max)  null, 
"impval" numeric( 8, 0 )  null, 
"numero" numeric( 8, 0 )  null, 
"estadcarte" bit  null, 
"estadentre" bit  null, 
"descripcio" char( 50 )  null, 
"estadcobra" bit  null, 
"condesde" char( 10 )  null, 
"estaddepos" bit  null, 
"conhasta" char( 10 )  null, 
"estadrecha" bit  null, 
"cladesde" char( 10 )  null, 
"estadbaja" bit  null, 
"clahasta" char( 10 )  null, 
"estaddevol" bit  null, 
"cbancdesde" char( 5 )  null, 
"estadprepa" bit  null, 
"cbanchasta" char( 5 )  null, 
"estadenvia" bit  null, 
"estadenvre" bit  null, 
"pcuenta" char( 30 )  null, 
"importanci" numeric( 5, 0 )  null, 
"estadtrans" bit  null, 
"estadcusto" bit  null, 
"sucdesde" char( 10 )  null, 
"suchasta" char( 10 )  null, 
"tsucdesde" char( 10 )  null, 
"tsuchasta" char( 10 )  null, 
"base" char( 21 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_IMPDIRCAJ' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_IMPDIRCAJ' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCAJ'
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
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('impval','impval')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('estadcarte','estadcarte')
			.AgregarMapeo('estadentre','estadentre')
			.AgregarMapeo('descripcio','descripcio')
			.AgregarMapeo('estadcobra','estadcobra')
			.AgregarMapeo('condesde','condesde')
			.AgregarMapeo('estaddepos','estaddepos')
			.AgregarMapeo('conhasta','conhasta')
			.AgregarMapeo('estadrecha','estadrecha')
			.AgregarMapeo('cladesde','cladesde')
			.AgregarMapeo('estadbaja','estadbaja')
			.AgregarMapeo('clahasta','clahasta')
			.AgregarMapeo('estaddevol','estaddevol')
			.AgregarMapeo('cbancdesde','cbancdesde')
			.AgregarMapeo('estadprepa','estadprepa')
			.AgregarMapeo('cbanchasta','cbanchasta')
			.AgregarMapeo('estadenvia','estadenvia')
			.AgregarMapeo('estadenvre','estadenvre')
			.AgregarMapeo('pcuenta','pcuenta')
			.AgregarMapeo('importanci','importanci')
			.AgregarMapeo('estadtrans','estadtrans')
			.AgregarMapeo('estadcusto','estadcusto')
			.AgregarMapeo('sucdesde','sucdesde')
			.AgregarMapeo('suchasta','suchasta')
			.AgregarMapeo('tsucdesde','tsucdesde')
			.AgregarMapeo('tsuchasta','tsuchasta')
			.AgregarMapeo('base','base')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_IMPDIRCAJ'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.OBS = isnull( d.OBS, t.OBS ),t.IMPVAL = isnull( d.IMPVAL, t.IMPVAL ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.ESTADCARTE = isnull( d.ESTADCARTE, t.ESTADCARTE ),t.ESTADENTRE = isnull( d.ESTADENTRE, t.ESTADENTRE ),t.DESCRIPCIO = isnull( d.DESCRIPCIO, t.DESCRIPCIO ),t.ESTADCOBRA = isnull( d.ESTADCOBRA, t.ESTADCOBRA ),t.CONDESDE = isnull( d.CONDESDE, t.CONDESDE ),t.ESTADDEPOS = isnull( d.ESTADDEPOS, t.ESTADDEPOS ),t.CONHASTA = isnull( d.CONHASTA, t.CONHASTA ),t.ESTADRECHA = isnull( d.ESTADRECHA, t.ESTADRECHA ),t.CLADESDE = isnull( d.CLADESDE, t.CLADESDE ),t.ESTADBAJA = isnull( d.ESTADBAJA, t.ESTADBAJA ),t.CLAHASTA = isnull( d.CLAHASTA, t.CLAHASTA ),t.ESTADDEVOL = isnull( d.ESTADDEVOL, t.ESTADDEVOL ),t.CBANCDESDE = isnull( d.CBANCDESDE, t.CBANCDESDE ),t.ESTADPREPA = isnull( d.ESTADPREPA, t.ESTADPREPA ),t.CBANCHASTA = isnull( d.CBANCHASTA, t.CBANCHASTA ),t.ESTADENVIA = isnull( d.ESTADENVIA, t.ESTADENVIA ),t.ESTADENVRE = isnull( d.ESTADENVRE, t.ESTADENVRE ),t.PCUENTA = isnull( d.PCUENTA, t.PCUENTA ),t.IMPORTANCI = isnull( d.IMPORTANCI, t.IMPORTANCI ),t.ESTADTRANS = isnull( d.ESTADTRANS, t.ESTADTRANS ),t.ESTADCUSTO = isnull( d.ESTADCUSTO, t.ESTADCUSTO ),t.SUCDESDE = isnull( d.SUCDESDE, t.SUCDESDE ),t.SUCHASTA = isnull( d.SUCHASTA, t.SUCHASTA ),t.TSUCDESDE = isnull( d.TSUCDESDE, t.TSUCDESDE ),t.TSUCHASTA = isnull( d.TSUCHASTA, t.TSUCHASTA ),t.BASE = isnull( d.BASE, t.BASE )
					from ZooLogic.IMPDIRCAJ t inner join deleted d 
							 on t.NUMERO = d.NUMERO
				-- Fin Updates
				insert into ZooLogic.IMPDIRCAJ(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Bdaltafw,Bdmodifw,Haltafw,Esttrans,Horaexpo,Valtafw,Zadsfw,Vmodifw,Umodifw,Ualtafw,Horaimpo,Hmodifw,Saltafw,Smodifw,Obs,Impval,Numero,Estadcarte,Estadentre,Descripcio,Estadcobra,Condesde,Estaddepos,Conhasta,Estadrecha,Cladesde,Estadbaja,Clahasta,Estaddevol,Cbancdesde,Estadprepa,Cbanchasta,Estadenvia,Estadenvre,Pcuenta,Importanci,Estadtrans,Estadcusto,Sucdesde,Suchasta,Tsucdesde,Tsuchasta,Base)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.OBS,''),isnull( d.IMPVAL,0),isnull( d.NUMERO,0),isnull( d.ESTADCARTE,0),isnull( d.ESTADENTRE,0),isnull( d.DESCRIPCIO,''),isnull( d.ESTADCOBRA,0),isnull( d.CONDESDE,''),isnull( d.ESTADDEPOS,0),isnull( d.CONHASTA,''),isnull( d.ESTADRECHA,0),isnull( d.CLADESDE,''),isnull( d.ESTADBAJA,0),isnull( d.CLAHASTA,''),isnull( d.ESTADDEVOL,0),isnull( d.CBANCDESDE,''),isnull( d.ESTADPREPA,0),isnull( d.CBANCHASTA,''),isnull( d.ESTADENVIA,0),isnull( d.ESTADENVRE,0),isnull( d.PCUENTA,''),isnull( d.IMPORTANCI,0),isnull( d.ESTADTRANS,0),isnull( d.ESTADCUSTO,0),isnull( d.SUCDESDE,''),isnull( d.SUCHASTA,''),isnull( d.TSUCDESDE,''),isnull( d.TSUCHASTA,''),isnull( d.BASE,'')
						From deleted d left join ZooLogic.IMPDIRCAJ pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IMPDIRCAJ') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IMPDIRCAJ
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_IMPDIRCAJ' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCAJ.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCAJ.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCAJ.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCAJ.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCAJ.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Basededatosaltafw = nvl( c_IMPDIRCAJ.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_IMPDIRCAJ.Basededatosmodificacionfw, [] )
					.Horaaltafw = nvl( c_IMPDIRCAJ.Horaaltafw, [] )
					.Estadotransferencia = nvl( c_IMPDIRCAJ.Estadotransferencia, [] )
					.Horaexpo = nvl( c_IMPDIRCAJ.Horaexpo, [] )
					.Versionaltafw = nvl( c_IMPDIRCAJ.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_IMPDIRCAJ.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_IMPDIRCAJ.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_IMPDIRCAJ.Usuarioaltafw, [] )
					.Horaimpo = nvl( c_IMPDIRCAJ.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_IMPDIRCAJ.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_IMPDIRCAJ.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_IMPDIRCAJ.Seriemodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Imputacion_PK =  nvl( c_IMPDIRCAJ.Imputacion, 0 )
					.Numero = nvl( c_IMPDIRCAJ.Numero, 0 )
					.Estadoencartera = nvl( c_IMPDIRCAJ.Estadoencartera, .F. )
					.Estadoentregado = nvl( c_IMPDIRCAJ.Estadoentregado, .F. )
					.Descripcion = nvl( c_IMPDIRCAJ.Descripcion, [] )
					.Estadocobrado = nvl( c_IMPDIRCAJ.Estadocobrado, .F. )
					.F_concepto_desde_PK =  nvl( c_IMPDIRCAJ.F_concepto_desde, [] )
					.Estadodepositado = nvl( c_IMPDIRCAJ.Estadodepositado, .F. )
					.F_concepto_hasta_PK =  nvl( c_IMPDIRCAJ.F_concepto_hasta, [] )
					.Estadorechazado = nvl( c_IMPDIRCAJ.Estadorechazado, .F. )
					.F_clasificacion_desde_PK =  nvl( c_IMPDIRCAJ.F_clasificacion_desde, [] )
					.Estadobaja = nvl( c_IMPDIRCAJ.Estadobaja, .F. )
					.F_clasificacion_hasta_PK =  nvl( c_IMPDIRCAJ.F_clasificacion_hasta, [] )
					.Estadodevuelto = nvl( c_IMPDIRCAJ.Estadodevuelto, .F. )
					.F_cuentabancaria_desde_PK =  nvl( c_IMPDIRCAJ.F_cuentabancaria_desde, [] )
					.Estadocomprometido = nvl( c_IMPDIRCAJ.Estadocomprometido, .F. )
					.F_cuentabancaria_hasta_PK =  nvl( c_IMPDIRCAJ.F_cuentabancaria_hasta, [] )
					.Estadoenviado = nvl( c_IMPDIRCAJ.Estadoenviado, .F. )
					.Estadoenviorechazado = nvl( c_IMPDIRCAJ.Estadoenviorechazado, .F. )
					.Plandecuentas_PK =  nvl( c_IMPDIRCAJ.Plandecuentas, [] )
					.Importancia = nvl( c_IMPDIRCAJ.Importancia, 0 )
					.Estadoentransito = nvl( c_IMPDIRCAJ.Estadoentransito, .F. )
					.Estadoencustodia = nvl( c_IMPDIRCAJ.Estadoencustodia, .F. )
					.F_sucursal_desde_PK =  nvl( c_IMPDIRCAJ.F_sucursal_desde, [] )
					.F_sucursal_hasta_PK =  nvl( c_IMPDIRCAJ.F_sucursal_hasta, [] )
					.F_tiposucursal_desde_PK =  nvl( c_IMPDIRCAJ.F_tiposucursal_desde, [] )
					.F_tiposucursal_hasta_PK =  nvl( c_IMPDIRCAJ.F_tiposucursal_hasta, [] )
					.Basededatos = nvl( c_IMPDIRCAJ.Basededatos, [] )
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
		return c_IMPDIRCAJ.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.IMPDIRCAJ' )
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
								from ZooLogic.IMPDIRCAJ 
								Where   IMPDIRCAJ.NUMERO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "IMPDIRCAJ", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Obs" as "Observacion", "Impval" as "Imputacion", "Numero" as "Numero", "Estadcarte" as "Estadoencartera", "Estadentre" as "Estadoentregado", "Descripcio" as "Descripcion", "Estadcobra" as "Estadocobrado", "Condesde" as "F_concepto_desde", "Estaddepos" as "Estadodepositado", "Conhasta" as "F_concepto_hasta", "Estadrecha" as "Estadorechazado", "Cladesde" as "F_clasificacion_desde", "Estadbaja" as "Estadobaja", "Clahasta" as "F_clasificacion_hasta", "Estaddevol" as "Estadodevuelto", "Cbancdesde" as "F_cuentabancaria_desde", "Estadprepa" as "Estadocomprometido", "Cbanchasta" as "F_cuentabancaria_hasta", "Estadenvia" as "Estadoenviado", "Estadenvre" as "Estadoenviorechazado", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Estadtrans" as "Estadoentransito", "Estadcusto" as "Estadoencustodia", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.IMPDIRCAJ 
								Where   IMPDIRCAJ.NUMERO != 0
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
	Tabla = 'IMPDIRCAJ'
	Filtro = " IMPDIRCAJ.NUMERO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " IMPDIRCAJ.NUMERO != 0"
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
	<row entidad="IMPDIRCAJ                               " atributo="FECHAIMPO                               " tabla="IMPDIRCAJ      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="FECHATRANSFERENCIA                      " tabla="IMPDIRCAJ      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="FECHAMODIFICACIONFW                     " tabla="IMPDIRCAJ      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                                                                                                                        " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="FECHAEXPO                               " tabla="IMPDIRCAJ      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="FECHAALTAFW                             " tabla="IMPDIRCAJ      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="BASEDEDATOSALTAFW                       " tabla="IMPDIRCAJ      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="IMPDIRCAJ      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="HORAALTAFW                              " tabla="IMPDIRCAJ      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="ESTADOTRANSFERENCIA                     " tabla="IMPDIRCAJ      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="HORAEXPO                                " tabla="IMPDIRCAJ      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="VERSIONALTAFW                           " tabla="IMPDIRCAJ      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="ZADSFW                                  " tabla="IMPDIRCAJ      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="VERSIONMODIFICACIONFW                   " tabla="IMPDIRCAJ      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="USUARIOMODIFICACIONFW                   " tabla="IMPDIRCAJ      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="USUARIOALTAFW                           " tabla="IMPDIRCAJ      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="HORAIMPO                                " tabla="IMPDIRCAJ      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="HORAMODIFICACIONFW                      " tabla="IMPDIRCAJ      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="SERIEALTAFW                             " tabla="IMPDIRCAJ      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="SERIEMODIFICACIONFW                     " tabla="IMPDIRCAJ      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="OBSERVACION                             " tabla="IMPDIRCAJ      " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                                                                                                             " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="90" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="IMPUTACION                              " tabla="IMPDIRCAJ      " campo="IMPVAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="IMPDIRVAL                               " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Imputación                                                                                                                                                                                                                                                " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="20" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="NUMERO                                  " tabla="IMPDIRCAJ      " campo="NUMERO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Número                                                                                                                                                                                                                                                    " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="ESTADOENCARTERA                         " tabla="IMPDIRCAJ      " campo="ESTADCARTE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="En cartera                                                                                                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="ESTADOENTREGADO                         " tabla="IMPDIRCAJ      " campo="ESTADENTRE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Entregado                                                                                                                                                                                                                                                 " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="DESCRIPCION                             " tabla="IMPDIRCAJ      " campo="DESCRIPCIO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                                                                                                               " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="ESTADOCOBRADO                           " tabla="IMPDIRCAJ      " campo="ESTADCOBRA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Cobrado                                                                                                                                                                                                                                                   " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="F_CONCEPTO_DESDE                        " tabla="IMPDIRCAJ      " campo="CONDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONCEPTOCAJA                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Concepto desde                                                                                                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="ESTADODEPOSITADO                        " tabla="IMPDIRCAJ      " campo="ESTADDEPOS" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Depositado                                                                                                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="F_CONCEPTO_HASTA                        " tabla="IMPDIRCAJ      " campo="CONHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONCEPTOCAJA                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="412" etiqueta="Concepto hasta                                                                                                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="ESTADORECHAZADO                         " tabla="IMPDIRCAJ      " campo="ESTADRECHA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Rechazado                                                                                                                                                                                                                                                 " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="F_CLASIFICACION_DESDE                   " tabla="IMPDIRCAJ      " campo="CLADESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONCONCEPTOCAJA               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Clasificación desde                                                                                                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="ESTADOBAJA                              " tabla="IMPDIRCAJ      " campo="ESTADBAJA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Dado de baja                                                                                                                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="F_CLASIFICACION_HASTA                   " tabla="IMPDIRCAJ      " campo="CLAHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONCONCEPTOCAJA               " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="420" etiqueta="Clasificación hasta                                                                                                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="ESTADODEVUELTO                          " tabla="IMPDIRCAJ      " campo="ESTADDEVOL" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Devuelto                                                                                                                                                                                                                                                  " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="F_CUENTABANCARIA_DESDE                  " tabla="IMPDIRCAJ      " campo="CBANCDESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CUENTABANCARIA                          " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Cuenta bancaria desde                                                                                                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="ESTADOCOMPROMETIDO                      " tabla="IMPDIRCAJ      " campo="ESTADPREPA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Comprometido                                                                                                                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="F_CUENTABANCARIA_HASTA                  " tabla="IMPDIRCAJ      " campo="CBANCHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CUENTABANCARIA                          " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="428" etiqueta="Cuenta bancaria hasta                                                                                                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="ESTADOENVIADO                           " tabla="IMPDIRCAJ      " campo="ESTADENVIA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Enviado                                                                                                                                                                                                                                                   " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="ESTADOENVIORECHAZADO                    " tabla="IMPDIRCAJ      " campo="ESTADENVRE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Envío rechazado                                                                                                                                                                                                                                           " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="PLANDECUENTAS                           " tabla="IMPDIRCAJ      " campo="PCUENTA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PLANDECUENTAS                           " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="434" etiqueta="Cuenta                                                                                                                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot; plancuenta.CTAIMPUT = .t. &quot;                                                                                                                                                                           " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="IMPORTANCIA                             " tabla="IMPDIRCAJ      " campo="IMPORTANCI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Importancia                                                                                                                                                                                                                                               " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="ESTADOENTRANSITO                        " tabla="IMPDIRCAJ      " campo="ESTADTRANS" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="En tránsito                                                                                                                                                                                                                                               " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="ESTADOENCUSTODIA                        " tabla="IMPDIRCAJ      " campo="ESTADCUSTO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="En custodia                                                                                                                                                                                                                                               " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="F_SUCURSAL_DESDE                        " tabla="IMPDIRCAJ      " campo="SUCDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SUCURSAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Sucursal desde                                                                                                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="F_SUCURSAL_HASTA                        " tabla="IMPDIRCAJ      " campo="SUCHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SUCURSAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="442" etiqueta="Sucursal hasta                                                                                                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="21" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="F_TIPOSUCURSAL_DESDE                    " tabla="IMPDIRCAJ      " campo="TSUCDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOSUCURSAL                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Tipo sucursal desde                                                                                                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="22" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="F_TIPOSUCURSAL_HASTA                    " tabla="IMPDIRCAJ      " campo="TSUCHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOSUCURSAL                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="446" etiqueta="Tipo sucursal hasta                                                                                                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="23" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCAJ                               " atributo="BASEDEDATOS                             " tabla="IMPDIRCAJ      " campo="BASE      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="21" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="Base                                                                                                                                                                                                                                                      " dominio="COMBOSUCYAGRUCONVACIO         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="9" orden="24" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="DESCRIPCION                             " tabla="IMPDIRVAL      " campo="DESCRIPCIO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Imp.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join IMPDIRVAL On IMPDIRCAJ.IMPVAL = IMPDIRVAL.NUMERO And  IMPDIRVAL.NUMERO != 0                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONCEPTOCAJA                            " atributo="DESCRIPCION                             " tabla="CONCECAJA      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Con.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONCECAJA On IMPDIRCAJ.CONDESDE = CONCECAJA.Codigo And  CONCECAJA.CODIGO != ''                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONCEPTOCAJA                            " atributo="DESCRIPCION                             " tabla="CONCECAJA      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Con.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONCECAJA On IMPDIRCAJ.CONHASTA = CONCECAJA.Codigo And  CONCECAJA.CODIGO != ''                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONCONCEPTOCAJA               " atributo="DESCRIPCION                             " tabla="CLASIFCCAJA    " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="417" etiqueta="Detalle Cla.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIFCCAJA On IMPDIRCAJ.CLADESDE = CLASIFCCAJA.CODIGO And  CLASIFCCAJA.CODIGO != ''                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONCONCEPTOCAJA               " atributo="DESCRIPCION                             " tabla="CLASIFCCAJA    " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="421" etiqueta="Detalle Cla.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIFCCAJA On IMPDIRCAJ.CLAHASTA = CLASIFCCAJA.CODIGO And  CLASIFCCAJA.CODIGO != ''                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="DESCRIPCION                             " tabla="CTABAN         " campo="CBDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="425" etiqueta="Detalle Cue.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CTABAN On IMPDIRCAJ.CBANCDESDE = CTABAN.CBCod And  CTABAN.CBCOD != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="DESCRIPCION                             " tabla="CTABAN         " campo="CBDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="429" etiqueta="Detalle Cue.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CTABAN On IMPDIRCAJ.CBANCHASTA = CTABAN.CBCod And  CTABAN.CBCOD != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="DESCRIPCION                             " tabla="PLANCUENTA     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="435" etiqueta="Detalle Cue.                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PLANCUENTA On IMPDIRCAJ.PCUENTA = PLANCUENTA.ctacodigo And  PLANCUENTA.CTACODIGO != ''                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="DESCRIPCION                             " tabla="SUC            " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="441" etiqueta="Detalle Suc.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SUC On IMPDIRCAJ.SUCDESDE = SUC.codigo And  SUC.CODIGO != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="DESCRIPCION                             " tabla="SUC            " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="443" etiqueta="Detalle Suc.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SUC On IMPDIRCAJ.SUCHASTA = SUC.codigo And  SUC.CODIGO != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOSUCURSAL                            " atributo="DESCRIPCION                             " tabla="TSUCUR         " campo="TDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="445" etiqueta="Detalle Tip.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TSUCUR On IMPDIRCAJ.TSUCDESDE = TSUCUR.TCOD And  TSUCUR.TCOD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOSUCURSAL                            " atributo="DESCRIPCION                             " tabla="TSUCUR         " campo="TDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="447" etiqueta="Detalle Tip.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TSUCUR On IMPDIRCAJ.TSUCHASTA = TSUCUR.TCOD And  TSUCUR.TCOD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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