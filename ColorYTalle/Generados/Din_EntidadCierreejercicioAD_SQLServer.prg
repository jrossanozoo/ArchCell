
define class Din_EntidadCIERREEJERCICIOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CIERREEJERCICIO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_CEJPK'
	cTablaPrincipal = 'CIERREEJ'
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
			local  lxCierreejFecimpo, lxCierreejFectrans, lxCierreejFmodifw, lxCierreejFecexpo, lxCierreejFaltafw, lxCierreejHaltafw, lxCierreejUaltafw, lxCierreejHoraexpo, lxCierreejHoraimpo, lxCierreejSaltafw, lxCierreejHmodifw, lxCierreejUmodifw, lxCierreejValtafw, lxCierreejSmodifw, lxCierreejVmodifw, lxCierreejZadsfw, lxCierreejBdaltafw, lxCierreejBdmodifw, lxCierreejEsttrans, lxCierreejEobs, lxCierreejNumero, lxCierreejDescrip, lxCierreejEjercicio, lxCierreejAsieninclu, lxCierreejAjuinfla, lxCierreejIndiceinf, lxCierreejCuentaajus, lxCierreejResultado, lxCierreejPatrimonia, lxCierreejPcuenta, lxCierreejFechaas
				lxCierreejFecimpo =  .Fechaimpo			lxCierreejFectrans =  .Fechatransferencia			lxCierreejFmodifw =  .Fechamodificacionfw			lxCierreejFecexpo =  .Fechaexpo			lxCierreejFaltafw =  .Fechaaltafw			lxCierreejHaltafw =  .Horaaltafw			lxCierreejUaltafw =  .Usuarioaltafw			lxCierreejHoraexpo =  .Horaexpo			lxCierreejHoraimpo =  .Horaimpo			lxCierreejSaltafw =  .Seriealtafw			lxCierreejHmodifw =  .Horamodificacionfw			lxCierreejUmodifw =  .Usuariomodificacionfw			lxCierreejValtafw =  .Versionaltafw			lxCierreejSmodifw =  .Seriemodificacionfw			lxCierreejVmodifw =  .Versionmodificacionfw			lxCierreejZadsfw =  .Zadsfw			lxCierreejBdaltafw =  .Basededatosaltafw			lxCierreejBdmodifw =  .Basededatosmodificacionfw			lxCierreejEsttrans =  .Estadotransferencia			lxCierreejEobs =  .Observacion			lxCierreejNumero =  .Numero			lxCierreejDescrip =  .Descripcion			lxCierreejEjercicio =  .Ejercicio_PK 			lxCierreejAsieninclu =  .Tiposdeasientosincluidos			lxCierreejAjuinfla =  .Asientoajusteporinflacion			lxCierreejIndiceinf =  upper( .Indice_PK ) 			lxCierreejCuentaajus =  upper( .CuentaBancaria_PK ) 			lxCierreejResultado =  .Resultado			lxCierreejPatrimonia =  .Patrimonial			lxCierreejPcuenta =  upper( .PlanDeCuentas_PK ) 			lxCierreejFechaas =  .Fecha
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCierreejNumero = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CIERREEJ ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Haltafw","Ualtafw","Horaexpo","Horaimpo","Saltafw","Hmodifw","Umodifw","Valtafw","Smodifw","Vmodifw","Zadsfw","Bdaltafw","Bdmodifw","Esttrans","Eobs","Numero","Descrip","Ejercicio","Asieninclu","Ajuinfla","Indiceinf","Cuentaajus","Resultado","Patrimonia","Pcuenta","Fechaas" ) values ( <<"'" + this.ConvertirDateSql( lxCierreejFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCierreejFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCierreejFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCierreejFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCierreejFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejEobs ) + "'" >>, <<lxCierreejNumero >>, <<"'" + this.FormatearTextoSql( lxCierreejDescrip ) + "'" >>, <<lxCierreejEjercicio >>, <<lxCierreejAsieninclu >>, <<iif( lxCierreejAjuinfla, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCierreejIndiceinf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejCuentaajus ) + "'" >>, <<iif( lxCierreejResultado, 1, 0 ) >>, <<iif( lxCierreejPatrimonia, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCierreejPcuenta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCierreejFechaas ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = lxValorClavePrimaria

			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
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
			this.GenerarSentenciasComponentes()
			local  lxCierreejFecimpo, lxCierreejFectrans, lxCierreejFmodifw, lxCierreejFecexpo, lxCierreejFaltafw, lxCierreejHaltafw, lxCierreejUaltafw, lxCierreejHoraexpo, lxCierreejHoraimpo, lxCierreejSaltafw, lxCierreejHmodifw, lxCierreejUmodifw, lxCierreejValtafw, lxCierreejSmodifw, lxCierreejVmodifw, lxCierreejZadsfw, lxCierreejBdaltafw, lxCierreejBdmodifw, lxCierreejEsttrans, lxCierreejEobs, lxCierreejNumero, lxCierreejDescrip, lxCierreejEjercicio, lxCierreejAsieninclu, lxCierreejAjuinfla, lxCierreejIndiceinf, lxCierreejCuentaajus, lxCierreejResultado, lxCierreejPatrimonia, lxCierreejPcuenta, lxCierreejFechaas
				lxCierreejFecimpo =  .Fechaimpo			lxCierreejFectrans =  .Fechatransferencia			lxCierreejFmodifw =  .Fechamodificacionfw			lxCierreejFecexpo =  .Fechaexpo			lxCierreejFaltafw =  .Fechaaltafw			lxCierreejHaltafw =  .Horaaltafw			lxCierreejUaltafw =  .Usuarioaltafw			lxCierreejHoraexpo =  .Horaexpo			lxCierreejHoraimpo =  .Horaimpo			lxCierreejSaltafw =  .Seriealtafw			lxCierreejHmodifw =  .Horamodificacionfw			lxCierreejUmodifw =  .Usuariomodificacionfw			lxCierreejValtafw =  .Versionaltafw			lxCierreejSmodifw =  .Seriemodificacionfw			lxCierreejVmodifw =  .Versionmodificacionfw			lxCierreejZadsfw =  .Zadsfw			lxCierreejBdaltafw =  .Basededatosaltafw			lxCierreejBdmodifw =  .Basededatosmodificacionfw			lxCierreejEsttrans =  .Estadotransferencia			lxCierreejEobs =  .Observacion			lxCierreejNumero =  .Numero			lxCierreejDescrip =  .Descripcion			lxCierreejEjercicio =  .Ejercicio_PK 			lxCierreejAsieninclu =  .Tiposdeasientosincluidos			lxCierreejAjuinfla =  .Asientoajusteporinflacion			lxCierreejIndiceinf =  upper( .Indice_PK ) 			lxCierreejCuentaajus =  upper( .CuentaBancaria_PK ) 			lxCierreejResultado =  .Resultado			lxCierreejPatrimonia =  .Patrimonial			lxCierreejPcuenta =  upper( .PlanDeCuentas_PK ) 			lxCierreejFechaas =  .Fecha
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.NUMERO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CIERREEJ set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCierreejFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCierreejFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCierreejFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCierreejFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCierreejFaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCierreejHaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCierreejUaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCierreejHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCierreejHoraimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCierreejSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCierreejHmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCierreejUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCierreejValtafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCierreejSmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCierreejVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCierreejZadsfw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCierreejBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCierreejBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCierreejEsttrans ) + "'">>,"Eobs" = <<"'" + this.FormatearTextoSql( lxCierreejEobs ) + "'">>,"Numero" = <<lxCierreejNumero>>,"Descrip" = <<"'" + this.FormatearTextoSql( lxCierreejDescrip ) + "'">>,"Ejercicio" = <<lxCierreejEjercicio>>,"Asieninclu" = <<lxCierreejAsieninclu>>,"Ajuinfla" = <<iif( lxCierreejAjuinfla, 1, 0 )>>,"Indiceinf" = <<"'" + this.FormatearTextoSql( lxCierreejIndiceinf ) + "'">>,"Cuentaajus" = <<"'" + this.FormatearTextoSql( lxCierreejCuentaajus ) + "'">>,"Resultado" = <<iif( lxCierreejResultado, 1, 0 )>>,"Patrimonia" = <<iif( lxCierreejPatrimonia, 1, 0 )>>,"Pcuenta" = <<"'" + this.FormatearTextoSql( lxCierreejPcuenta ) + "'">>,"Fechaas" = <<"'" + this.ConvertirDateSql( lxCierreejFechaas ) + "'">> where "Numero" = <<lxCierreejNumero>> and  CIERREEJ.NUMERO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 NUMERO from ZooLogic.CIERREEJ where " + this.ConvertirFuncionesSql( " CIERREEJ.NUMERO != 0" ) )
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
			Local lxCierreejNumero
			lxCierreejNumero = .Numero

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Eobs" as "Observacion", "Numero" as "Numero", "Descrip" as "Descripcion", "Ejercicio" as "Ejercicio", "Asieninclu" as "Tiposdeasientosincluidos", "Ajuinfla" as "Asientoajusteporinflacion", "Indiceinf" as "Indice", "Cuentaajus" as "Cuentabancaria", "Resultado" as "Resultado", "Patrimonia" as "Patrimonial", "Pcuenta" as "Plandecuentas", "Fechaas" as "Fecha" from ZooLogic.CIERREEJ where "Numero" = <<lxCierreejNumero>> and  CIERREEJ.NUMERO != 0
			endtext
			use in select('c_CIERREEJERCICIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CIERREEJERCICIO', set( 'Datasession' ) )

			if reccount( 'c_CIERREEJERCICIO' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCierreejNumero as Variant
		llRetorno = .t.
		lxCierreejNumero = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CIERREEJ where "Numero" = <<lxCierreejNumero>> and  CIERREEJ.NUMERO != 0
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Eobs" as "Observacion", "Numero" as "Numero", "Descrip" as "Descripcion", "Ejercicio" as "Ejercicio", "Asieninclu" as "Tiposdeasientosincluidos", "Ajuinfla" as "Asientoajusteporinflacion", "Indiceinf" as "Indice", "Cuentaajus" as "Cuentabancaria", "Resultado" as "Resultado", "Patrimonia" as "Patrimonial", "Pcuenta" as "Plandecuentas", "Fechaas" as "Fecha" from ZooLogic.CIERREEJ where  CIERREEJ.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_CIERREEJERCICIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CIERREEJERCICIO', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Eobs" as "Observacion", "Numero" as "Numero", "Descrip" as "Descripcion", "Ejercicio" as "Ejercicio", "Asieninclu" as "Tiposdeasientosincluidos", "Ajuinfla" as "Asientoajusteporinflacion", "Indiceinf" as "Indice", "Cuentaajus" as "Cuentabancaria", "Resultado" as "Resultado", "Patrimonia" as "Patrimonial", "Pcuenta" as "Plandecuentas", "Fechaas" as "Fecha" from ZooLogic.CIERREEJ where  str( NUMERO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CIERREEJ.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_CIERREEJERCICIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CIERREEJERCICIO', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Eobs" as "Observacion", "Numero" as "Numero", "Descrip" as "Descripcion", "Ejercicio" as "Ejercicio", "Asieninclu" as "Tiposdeasientosincluidos", "Ajuinfla" as "Asientoajusteporinflacion", "Indiceinf" as "Indice", "Cuentaajus" as "Cuentabancaria", "Resultado" as "Resultado", "Patrimonia" as "Patrimonial", "Pcuenta" as "Plandecuentas", "Fechaas" as "Fecha" from ZooLogic.CIERREEJ where  str( NUMERO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CIERREEJ.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_CIERREEJERCICIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CIERREEJERCICIO', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Eobs" as "Observacion", "Numero" as "Numero", "Descrip" as "Descripcion", "Ejercicio" as "Ejercicio", "Asieninclu" as "Tiposdeasientosincluidos", "Ajuinfla" as "Asientoajusteporinflacion", "Indiceinf" as "Indice", "Cuentaajus" as "Cuentabancaria", "Resultado" as "Resultado", "Patrimonia" as "Patrimonial", "Pcuenta" as "Plandecuentas", "Fechaas" as "Fecha" from ZooLogic.CIERREEJ where  CIERREEJ.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_CIERREEJERCICIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CIERREEJERCICIO', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Haltafw,Ualtafw,Horaexpo,Horaimpo,Saltafw,Hmodifw,U" + ;
"modifw,Valtafw,Smodifw,Vmodifw,Zadsfw,Bdaltafw,Bdmodifw,Esttrans,Eobs,Numero,Descrip,Ejercicio,Asien" + ;
"inclu,Ajuinfla,Indiceinf,Cuentaajus,Resultado,Patrimonia,Pcuenta,Fechaas" + ;
" from ZooLogic.CIERREEJ where  CIERREEJ.NUMERO != 0 and " + lcFiltro )
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
			local  lxCierreejFecimpo, lxCierreejFectrans, lxCierreejFmodifw, lxCierreejFecexpo, lxCierreejFaltafw, lxCierreejHaltafw, lxCierreejUaltafw, lxCierreejHoraexpo, lxCierreejHoraimpo, lxCierreejSaltafw, lxCierreejHmodifw, lxCierreejUmodifw, lxCierreejValtafw, lxCierreejSmodifw, lxCierreejVmodifw, lxCierreejZadsfw, lxCierreejBdaltafw, lxCierreejBdmodifw, lxCierreejEsttrans, lxCierreejEobs, lxCierreejNumero, lxCierreejDescrip, lxCierreejEjercicio, lxCierreejAsieninclu, lxCierreejAjuinfla, lxCierreejIndiceinf, lxCierreejCuentaajus, lxCierreejResultado, lxCierreejPatrimonia, lxCierreejPcuenta, lxCierreejFechaas
				lxCierreejFecimpo = ctod( '  /  /    ' )			lxCierreejFectrans = ctod( '  /  /    ' )			lxCierreejFmodifw = ctod( '  /  /    ' )			lxCierreejFecexpo = ctod( '  /  /    ' )			lxCierreejFaltafw = ctod( '  /  /    ' )			lxCierreejHaltafw = []			lxCierreejUaltafw = []			lxCierreejHoraexpo = []			lxCierreejHoraimpo = []			lxCierreejSaltafw = []			lxCierreejHmodifw = []			lxCierreejUmodifw = []			lxCierreejValtafw = []			lxCierreejSmodifw = []			lxCierreejVmodifw = []			lxCierreejZadsfw = []			lxCierreejBdaltafw = []			lxCierreejBdmodifw = []			lxCierreejEsttrans = []			lxCierreejEobs = []			lxCierreejNumero = 0			lxCierreejDescrip = []			lxCierreejEjercicio = 0			lxCierreejAsieninclu = 0			lxCierreejAjuinfla = .F.			lxCierreejIndiceinf = []			lxCierreejCuentaajus = []			lxCierreejResultado = .F.			lxCierreejPatrimonia = .F.			lxCierreejPcuenta = []			lxCierreejFechaas = ctod( '  /  /    ' )
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CIERREEJ where "NUMERO" = ] + transform( .oEntidad.NUMERO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CIERREEJ' + '_' + tcCampo
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
		lcWhere = " Where  CIERREEJ.NUMERO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Eobs" as "Observacion", "Numero" as "Numero", "Descrip" as "Descripcion", "Ejercicio" as "Ejercicio", "Asieninclu" as "Tiposdeasientosincluidos", "Ajuinfla" as "Asientoajusteporinflacion", "Indiceinf" as "Indice", "Cuentaajus" as "Cuentabancaria", "Resultado" as "Resultado", "Patrimonia" as "Patrimonial", "Pcuenta" as "Plandecuentas", "Fechaas" as "Fecha"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CIERREEJ', '', tnTope )
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
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EOBS AS OBSERVACION'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'EJERCICIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EJERCICIO AS EJERCICIO'
				Case lcAtributo == 'TIPOSDEASIENTOSINCLUIDOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ASIENINCLU AS TIPOSDEASIENTOSINCLUIDOS'
				Case lcAtributo == 'ASIENTOAJUSTEPORINFLACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUINFLA AS ASIENTOAJUSTEPORINFLACION'
				Case lcAtributo == 'INDICE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INDICEINF AS INDICE'
				Case lcAtributo == 'CUENTABANCARIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUENTAAJUS AS CUENTABANCARIA'
				Case lcAtributo == 'RESULTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RESULTADO AS RESULTADO'
				Case lcAtributo == 'PATRIMONIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PATRIMONIA AS PATRIMONIAL'
				Case lcAtributo == 'PLANDECUENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PCUENTA AS PLANDECUENTAS'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAAS AS FECHA'
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
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'EOBS'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'EJERCICIO'
				lcCampo = 'EJERCICIO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOSDEASIENTOSINCLUIDOS'
				lcCampo = 'ASIENINCLU'
			Case upper( alltrim( tcAtributo ) ) == 'ASIENTOAJUSTEPORINFLACION'
				lcCampo = 'AJUINFLA'
			Case upper( alltrim( tcAtributo ) ) == 'INDICE'
				lcCampo = 'INDICEINF'
			Case upper( alltrim( tcAtributo ) ) == 'CUENTABANCARIA'
				lcCampo = 'CUENTAAJUS'
			Case upper( alltrim( tcAtributo ) ) == 'RESULTADO'
				lcCampo = 'RESULTADO'
			Case upper( alltrim( tcAtributo ) ) == 'PATRIMONIAL'
				lcCampo = 'PATRIMONIA'
			Case upper( alltrim( tcAtributo ) ) == 'PLANDECUENTAS'
				lcCampo = 'PCUENTA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHAAS'
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
			local  lxCierreejFecimpo, lxCierreejFectrans, lxCierreejFmodifw, lxCierreejFecexpo, lxCierreejFaltafw, lxCierreejHaltafw, lxCierreejUaltafw, lxCierreejHoraexpo, lxCierreejHoraimpo, lxCierreejSaltafw, lxCierreejHmodifw, lxCierreejUmodifw, lxCierreejValtafw, lxCierreejSmodifw, lxCierreejVmodifw, lxCierreejZadsfw, lxCierreejBdaltafw, lxCierreejBdmodifw, lxCierreejEsttrans, lxCierreejEobs, lxCierreejNumero, lxCierreejDescrip, lxCierreejEjercicio, lxCierreejAsieninclu, lxCierreejAjuinfla, lxCierreejIndiceinf, lxCierreejCuentaajus, lxCierreejResultado, lxCierreejPatrimonia, lxCierreejPcuenta, lxCierreejFechaas
				lxCierreejFecimpo =  .Fechaimpo			lxCierreejFectrans =  .Fechatransferencia			lxCierreejFmodifw =  .Fechamodificacionfw			lxCierreejFecexpo =  .Fechaexpo			lxCierreejFaltafw =  .Fechaaltafw			lxCierreejHaltafw =  .Horaaltafw			lxCierreejUaltafw =  .Usuarioaltafw			lxCierreejHoraexpo =  .Horaexpo			lxCierreejHoraimpo =  .Horaimpo			lxCierreejSaltafw =  .Seriealtafw			lxCierreejHmodifw =  .Horamodificacionfw			lxCierreejUmodifw =  .Usuariomodificacionfw			lxCierreejValtafw =  .Versionaltafw			lxCierreejSmodifw =  .Seriemodificacionfw			lxCierreejVmodifw =  .Versionmodificacionfw			lxCierreejZadsfw =  .Zadsfw			lxCierreejBdaltafw =  .Basededatosaltafw			lxCierreejBdmodifw =  .Basededatosmodificacionfw			lxCierreejEsttrans =  .Estadotransferencia			lxCierreejEobs =  .Observacion			lxCierreejNumero =  .Numero			lxCierreejDescrip =  .Descripcion			lxCierreejEjercicio =  .Ejercicio_PK 			lxCierreejAsieninclu =  .Tiposdeasientosincluidos			lxCierreejAjuinfla =  .Asientoajusteporinflacion			lxCierreejIndiceinf =  upper( .Indice_PK ) 			lxCierreejCuentaajus =  upper( .CuentaBancaria_PK ) 			lxCierreejResultado =  .Resultado			lxCierreejPatrimonia =  .Patrimonial			lxCierreejPcuenta =  upper( .PlanDeCuentas_PK ) 			lxCierreejFechaas =  .Fecha
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CIERREEJ ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Haltafw","Ualtafw","Horaexpo","Horaimpo","Saltafw","Hmodifw","Umodifw","Valtafw","Smodifw","Vmodifw","Zadsfw","Bdaltafw","Bdmodifw","Esttrans","Eobs","Numero","Descrip","Ejercicio","Asieninclu","Ajuinfla","Indiceinf","Cuentaajus","Resultado","Patrimonia","Pcuenta","Fechaas" ) values ( <<"'" + this.ConvertirDateSql( lxCierreejFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCierreejFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCierreejFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCierreejFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCierreejFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejEobs ) + "'" >>, <<lxCierreejNumero >>, <<"'" + this.FormatearTextoSql( lxCierreejDescrip ) + "'" >>, <<lxCierreejEjercicio >>, <<lxCierreejAsieninclu >>, <<iif( lxCierreejAjuinfla, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCierreejIndiceinf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCierreejCuentaajus ) + "'" >>, <<iif( lxCierreejResultado, 1, 0 ) >>, <<iif( lxCierreejPatrimonia, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCierreejPcuenta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCierreejFechaas ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CIERREEJ' 
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
			local  lxCierreejFecimpo, lxCierreejFectrans, lxCierreejFmodifw, lxCierreejFecexpo, lxCierreejFaltafw, lxCierreejHaltafw, lxCierreejUaltafw, lxCierreejHoraexpo, lxCierreejHoraimpo, lxCierreejSaltafw, lxCierreejHmodifw, lxCierreejUmodifw, lxCierreejValtafw, lxCierreejSmodifw, lxCierreejVmodifw, lxCierreejZadsfw, lxCierreejBdaltafw, lxCierreejBdmodifw, lxCierreejEsttrans, lxCierreejEobs, lxCierreejNumero, lxCierreejDescrip, lxCierreejEjercicio, lxCierreejAsieninclu, lxCierreejAjuinfla, lxCierreejIndiceinf, lxCierreejCuentaajus, lxCierreejResultado, lxCierreejPatrimonia, lxCierreejPcuenta, lxCierreejFechaas
				lxCierreejFecimpo =  .Fechaimpo			lxCierreejFectrans =  .Fechatransferencia			lxCierreejFmodifw =  .Fechamodificacionfw			lxCierreejFecexpo =  .Fechaexpo			lxCierreejFaltafw =  .Fechaaltafw			lxCierreejHaltafw =  .Horaaltafw			lxCierreejUaltafw =  .Usuarioaltafw			lxCierreejHoraexpo =  .Horaexpo			lxCierreejHoraimpo =  .Horaimpo			lxCierreejSaltafw =  .Seriealtafw			lxCierreejHmodifw =  .Horamodificacionfw			lxCierreejUmodifw =  .Usuariomodificacionfw			lxCierreejValtafw =  .Versionaltafw			lxCierreejSmodifw =  .Seriemodificacionfw			lxCierreejVmodifw =  .Versionmodificacionfw			lxCierreejZadsfw =  .Zadsfw			lxCierreejBdaltafw =  .Basededatosaltafw			lxCierreejBdmodifw =  .Basededatosmodificacionfw			lxCierreejEsttrans =  .Estadotransferencia			lxCierreejEobs =  .Observacion			lxCierreejNumero =  .Numero			lxCierreejDescrip =  .Descripcion			lxCierreejEjercicio =  .Ejercicio_PK 			lxCierreejAsieninclu =  .Tiposdeasientosincluidos			lxCierreejAjuinfla =  .Asientoajusteporinflacion			lxCierreejIndiceinf =  upper( .Indice_PK ) 			lxCierreejCuentaajus =  upper( .CuentaBancaria_PK ) 			lxCierreejResultado =  .Resultado			lxCierreejPatrimonia =  .Patrimonial			lxCierreejPcuenta =  upper( .PlanDeCuentas_PK ) 			lxCierreejFechaas =  .Fecha
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  CIERREEJ.NUMERO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.CIERREEJ set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCierreejFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCierreejFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCierreejFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCierreejFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCierreejFaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCierreejHaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCierreejUaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCierreejHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCierreejHoraimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCierreejSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCierreejHmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCierreejUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCierreejValtafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCierreejSmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCierreejVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCierreejZadsfw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCierreejBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCierreejBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCierreejEsttrans ) + "'">>, "Eobs" = <<"'" + this.FormatearTextoSql( lxCierreejEobs ) + "'">>, "Numero" = <<lxCierreejNumero>>, "Descrip" = <<"'" + this.FormatearTextoSql( lxCierreejDescrip ) + "'">>, "Ejercicio" = <<lxCierreejEjercicio>>, "Asieninclu" = <<lxCierreejAsieninclu>>, "Ajuinfla" = <<iif( lxCierreejAjuinfla, 1, 0 )>>, "Indiceinf" = <<"'" + this.FormatearTextoSql( lxCierreejIndiceinf ) + "'">>, "Cuentaajus" = <<"'" + this.FormatearTextoSql( lxCierreejCuentaajus ) + "'">>, "Resultado" = <<iif( lxCierreejResultado, 1, 0 )>>, "Patrimonia" = <<iif( lxCierreejPatrimonia, 1, 0 )>>, "Pcuenta" = <<"'" + this.FormatearTextoSql( lxCierreejPcuenta ) + "'">>, "Fechaas" = <<"'" + this.ConvertirDateSql( lxCierreejFechaas ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CIERREEJ' 
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

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  CIERREEJ.NUMERO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.CIERREEJ where ' + lcFiltro )
			loColeccion.cTabla = 'CIERREEJ' 
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
		
			.oCompAsientos.lNuevo = .EsNuevo()
			.oCompAsientos.lEdicion = .EsEdicion()
			.oCompAsientos.lEliminar = .lEliminar
			.oCompAsientos.lAnular = .lAnular
			loColSentencias = .oCompAsientos.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
			.oCompCostomercaderiavendida.lNuevo = .EsNuevo()
			.oCompCostomercaderiavendida.lEdicion = .EsEdicion()
			.oCompCostomercaderiavendida.lEliminar = .lEliminar
			.oCompCostomercaderiavendida.lAnular = .lAnular
			loColSentencias = .oCompCostomercaderiavendida.grabar()
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
			lcRetorno = [update ZooLogic.CIERREEJ set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where NUMERO = ] + transform( .Numero ) + [ and  CIERREEJ.NUMERO != 0] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CIERREEJ where  CIERREEJ.NUMERO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CIERREEJ where NUMERO = " + transform( this.oEntidad.NUMERO )+ " and  CIERREEJ.NUMERO != 0" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CIERREEJERCICIO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CIERREEJ Where NUMERO = ] + transform( &lcCursor..NUMERO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() 
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CIERREEJ set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, EOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..EOBS ) + "'"+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, DESCRIP = ] + "'" + this.FormatearTextoSql( &lcCursor..DESCRIP ) + "'"+ [, EJERCICIO = ] + transform( &lcCursor..EJERCICIO )+ [, AsienInclu = ] + transform( &lcCursor..AsienInclu )+ [, AjuInfla = ] + Transform( iif( &lcCursor..AjuInfla, 1, 0 ))+ [, IndiceInf = ] + "'" + this.FormatearTextoSql( &lcCursor..IndiceInf ) + "'"+ [, CuentaAjus = ] + "'" + this.FormatearTextoSql( &lcCursor..CuentaAjus ) + "'"+ [, Resultado = ] + Transform( iif( &lcCursor..Resultado, 1, 0 ))+ [, Patrimonia = ] + Transform( iif( &lcCursor..Patrimonia, 1, 0 ))+ [, PCUENTA = ] + "'" + this.FormatearTextoSql( &lcCursor..PCUENTA ) + "'"+ [, FECHAAS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAAS ) + "'" + [ Where NUMERO = ] + transform( &lcCursor..NUMERO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, HALTAFW, UALTAFW, HORAEXPO, HORAIMPO, SALTAFW, HMODIFW, UMODIFW, VALTAFW, SMODIFW, VMODIFW, ZADSFW, BDALTAFW, BDMODIFW, ESTTRANS, EOBS, NUMERO, DESCRIP, EJERCICIO, AsienInclu, AjuInfla, IndiceInf, CuentaAjus, Resultado, Patrimonia, PCUENTA, FECHAAS
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..EOBS ) + "'" + ',' + transform( &lcCursor..NUMERO )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..DESCRIP ) + "'" + ',' + transform( &lcCursor..EJERCICIO ) + ',' + transform( &lcCursor..AsienInclu ) + ',' + Transform( iif( &lcCursor..AjuInfla, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..IndiceInf ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CuentaAjus ) + "'" + ',' + Transform( iif( &lcCursor..Resultado, 1, 0 )) + ',' + Transform( iif( &lcCursor..Patrimonia, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..PCUENTA ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAAS ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CIERREEJ ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CIERREEJERCICIO'
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
			Case  lcAlias == lcPrefijo + 'CIERREEJERCICIO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CIERREEJERCICIO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CIERREEJERCICIO_EOBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CIERREEJ')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CIERREEJERCICIO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..NUMERO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CIERREEJERCICIO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CIERREEJERCICIO'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CIERREEJERCICIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECHAAS   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CIERREEJ') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CIERREEJ
Create Table ZooLogic.TablaTrabajo_CIERREEJ ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"haltafw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"eobs" varchar(max)  null, 
"numero" numeric( 8, 0 )  null, 
"descrip" char( 50 )  null, 
"ejercicio" numeric( 8, 0 )  null, 
"asieninclu" numeric( 1, 0 )  null, 
"ajuinfla" bit  null, 
"indiceinf" char( 10 )  null, 
"cuentaajus" char( 30 )  null, 
"resultado" bit  null, 
"patrimonia" bit  null, 
"pcuenta" char( 30 )  null, 
"fechaas" datetime  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CIERREEJ' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CIERREEJ' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CIERREEJERCICIO'
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
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('eobs','eobs')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('ejercicio','ejercicio')
			.AgregarMapeo('asieninclu','asieninclu')
			.AgregarMapeo('ajuinfla','ajuinfla')
			.AgregarMapeo('indiceinf','indiceinf')
			.AgregarMapeo('cuentaajus','cuentaajus')
			.AgregarMapeo('resultado','resultado')
			.AgregarMapeo('patrimonia','patrimonia')
			.AgregarMapeo('pcuenta','pcuenta')
			.AgregarMapeo('fechaas','fechaas')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CIERREEJ'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.EOBS = isnull( d.EOBS, t.EOBS ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.EJERCICIO = isnull( d.EJERCICIO, t.EJERCICIO ),t.ASIENINCLU = isnull( d.ASIENINCLU, t.ASIENINCLU ),t.AJUINFLA = isnull( d.AJUINFLA, t.AJUINFLA ),t.INDICEINF = isnull( d.INDICEINF, t.INDICEINF ),t.CUENTAAJUS = isnull( d.CUENTAAJUS, t.CUENTAAJUS ),t.RESULTADO = isnull( d.RESULTADO, t.RESULTADO ),t.PATRIMONIA = isnull( d.PATRIMONIA, t.PATRIMONIA ),t.PCUENTA = isnull( d.PCUENTA, t.PCUENTA ),t.FECHAAS = isnull( d.FECHAAS, t.FECHAAS )
					from ZooLogic.CIERREEJ t inner join deleted d 
							 on t.NUMERO = d.NUMERO
				-- Fin Updates
				insert into ZooLogic.CIERREEJ(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Haltafw,Ualtafw,Horaexpo,Horaimpo,Saltafw,Hmodifw,Umodifw,Valtafw,Smodifw,Vmodifw,Zadsfw,Bdaltafw,Bdmodifw,Esttrans,Eobs,Numero,Descrip,Ejercicio,Asieninclu,Ajuinfla,Indiceinf,Cuentaajus,Resultado,Patrimonia,Pcuenta,Fechaas)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),convert( char(8), getdate(), 108 ),isnull( d.UALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.SMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.EOBS,''),isnull( d.NUMERO,0),isnull( d.DESCRIP,''),isnull( d.EJERCICIO,0),isnull( d.ASIENINCLU,0),isnull( d.AJUINFLA,0),isnull( d.INDICEINF,''),isnull( d.CUENTAAJUS,''),isnull( d.RESULTADO,0),isnull( d.PATRIMONIA,0),isnull( d.PCUENTA,''),isnull( d.FECHAAS,'')
						From deleted d left join ZooLogic.CIERREEJ pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CIERREEJ') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CIERREEJ
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CIERREEJERCICIO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CIERREEJERCICIO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CIERREEJERCICIO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CIERREEJERCICIO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CIERREEJERCICIO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CIERREEJERCICIO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_CIERREEJERCICIO.Horaaltafw, [] )
					.Usuarioaltafw = nvl( c_CIERREEJERCICIO.Usuarioaltafw, [] )
					.Horaexpo = nvl( c_CIERREEJERCICIO.Horaexpo, [] )
					.Horaimpo = nvl( c_CIERREEJERCICIO.Horaimpo, [] )
					.Seriealtafw = nvl( c_CIERREEJERCICIO.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_CIERREEJERCICIO.Horamodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_CIERREEJERCICIO.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_CIERREEJERCICIO.Versionaltafw, [] )
					.Seriemodificacionfw = nvl( c_CIERREEJERCICIO.Seriemodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_CIERREEJERCICIO.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Basededatosaltafw = nvl( c_CIERREEJERCICIO.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_CIERREEJERCICIO.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_CIERREEJERCICIO.Estadotransferencia, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Numero = nvl( c_CIERREEJERCICIO.Numero, 0 )
					.Descripcion = nvl( c_CIERREEJERCICIO.Descripcion, [] )
					.Ejercicio_PK =  nvl( c_CIERREEJERCICIO.Ejercicio, 0 )
					.Tiposdeasientosincluidos = nvl( c_CIERREEJERCICIO.Tiposdeasientosincluidos, 0 )
					.Asientoajusteporinflacion = nvl( c_CIERREEJERCICIO.Asientoajusteporinflacion, .F. )
					.Indice_PK =  nvl( c_CIERREEJERCICIO.Indice, [] )
					.Cuentabancaria_PK =  nvl( c_CIERREEJERCICIO.Cuentabancaria, [] )
					.Resultado = nvl( c_CIERREEJERCICIO.Resultado, .F. )
					.Patrimonial = nvl( c_CIERREEJERCICIO.Patrimonial, .F. )
					.Plandecuentas_PK =  nvl( c_CIERREEJERCICIO.Plandecuentas, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_CIERREEJERCICIO.Fecha, ctod( '  /  /    ' ) ) )
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
		return c_CIERREEJERCICIO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CIERREEJ' )
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
								from ZooLogic.CIERREEJ 
								Where   CIERREEJ.NUMERO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CIERREEJ", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Eobs" as "Observacion", "Numero" as "Numero", "Descrip" as "Descripcion", "Ejercicio" as "Ejercicio", "Asieninclu" as "Tiposdeasientosincluidos", "Ajuinfla" as "Asientoajusteporinflacion", "Indiceinf" as "Indice", "Cuentaajus" as "Cuentabancaria", "Resultado" as "Resultado", "Patrimonia" as "Patrimonial", "Pcuenta" as "Plandecuentas", "Fechaas" as "Fecha"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CIERREEJ 
								Where   CIERREEJ.NUMERO != 0
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
	Tabla = 'CIERREEJ'
	Filtro = " CIERREEJ.NUMERO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CIERREEJ.NUMERO != 0"
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
	<row entidad="CIERREEJERCICIO                         " atributo="FECHAIMPO                               " tabla="CIERREEJ       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="FECHATRANSFERENCIA                      " tabla="CIERREEJ       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="FECHAMODIFICACIONFW                     " tabla="CIERREEJ       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="FECHAEXPO                               " tabla="CIERREEJ       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="FECHAALTAFW                             " tabla="CIERREEJ       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="HORAALTAFW                              " tabla="CIERREEJ       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="USUARIOALTAFW                           " tabla="CIERREEJ       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="HORAEXPO                                " tabla="CIERREEJ       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="HORAIMPO                                " tabla="CIERREEJ       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="SERIEALTAFW                             " tabla="CIERREEJ       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="HORAMODIFICACIONFW                      " tabla="CIERREEJ       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="USUARIOMODIFICACIONFW                   " tabla="CIERREEJ       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="VERSIONALTAFW                           " tabla="CIERREEJ       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="SERIEMODIFICACIONFW                     " tabla="CIERREEJ       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="VERSIONMODIFICACIONFW                   " tabla="CIERREEJ       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="ZADSFW                                  " tabla="CIERREEJ       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="BASEDEDATOSALTAFW                       " tabla="CIERREEJ       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CIERREEJ       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="ESTADOTRANSFERENCIA                     " tabla="CIERREEJ       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="OBSERVACION                             " tabla="CIERREEJ       " campo="EOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="NUMERO                                  " tabla="CIERREEJ       " campo="NUMERO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="DESCRIPCION                             " tabla="CIERREEJ       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="EJERCICIO                               " tabla="CIERREEJ       " campo="EJERCICIO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="EJERCICIO                               " tipodato="N         " longitud="8" decimales="0" valorsugerido="=this.ObtenerEjercicio()                                                                                                                                                                                                                                      " obligatorio="true" admitebusqueda="402" etiqueta="Ejercicio a cerrar                                                                                                                                              " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="TIPOSDEASIENTOSINCLUIDOS                " tabla="CIERREEJ       " campo="ASIENINCLU" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Incluir tipos de asientos                                                                                                                                       " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="ASIENTOAJUSTEPORINFLACION               " tabla="CIERREEJ       " campo="AJUINFLA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Asiento de ajuste por inflación                                                                                                                                 " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="INDICE                                  " tabla="CIERREEJ       " campo="INDICEINF " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="INDICESINFLACION                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Código de índice                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="CUENTABANCARIA                          " tabla="CIERREEJ       " campo="CUENTAAJUS" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PLANDECUENTAS                           " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Cuenta de ajuste por inflación (RECPAM)                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="RESULTADO                               " tabla="CIERREEJ       " campo="RESULTADO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Asiento de refundición de resultados                                                                                                                            " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="PATRIMONIAL                             " tabla="CIERREEJ       " campo="PATRIMONIA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Asiento de cierre de cuentas patrimoniales                                                                                                                      " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="PLANDECUENTAS                           " tabla="CIERREEJ       " campo="PCUENTA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PLANDECUENTAS                           " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Cuenta de refundición                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot; plancuenta.CTAIMPUT = .t. and plancuenta.DEREFUND = 3 &quot;                                                                                                                                               " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREEJERCICIO                         " atributo="FECHA                                   " tabla="CIERREEJ       " campo="FECHAAS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="418" etiqueta="Fecha de asiento                                                                                                                                                " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EJERCICIO                               " atributo="DESCRIPCION                             " tabla="EJERCICIO      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="403" etiqueta="Detalle Eje.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join EJERCICIO On CIERREEJ.EJERCICIO = EJERCICIO.NUMERO And  EJERCICIO.NUMERO != 0                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INDICESINFLACION                        " atributo="DESCRIPCION                             " tabla="INDICES        " campo="DESCIP    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join INDICES On CIERREEJ.INDICEINF = INDICES.Codigo And  INDICES.CODIGO != ''                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="DESCRIPCION                             " tabla="PLANCUENTA     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Cue.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PLANCUENTA On CIERREEJ.CUENTAAJUS = PLANCUENTA.ctacodigo And  PLANCUENTA.CTACODIGO != ''                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="DESCRIPCION                             " tabla="PLANCUENTA     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="417" etiqueta="Detalle Cue.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PLANCUENTA On CIERREEJ.PCUENTA = PLANCUENTA.ctacodigo And  PLANCUENTA.CTACODIGO != ''                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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