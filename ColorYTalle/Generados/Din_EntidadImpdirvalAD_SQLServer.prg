
define class Din_EntidadIMPDIRVALAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_IMPDIRVAL'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_IDVPK'
	cTablaPrincipal = 'IMPDIRVAL'
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
			local  lxImpdirvalFectrans, lxImpdirvalFecexpo, lxImpdirvalFaltafw, lxImpdirvalFecimpo, lxImpdirvalFmodifw, lxImpdirvalEsttrans, lxImpdirvalHoraexpo, lxImpdirvalHaltafw, lxImpdirvalBdmodifw, lxImpdirvalHoraimpo, lxImpdirvalZadsfw, lxImpdirvalBdaltafw, lxImpdirvalSmodifw, lxImpdirvalValtafw, lxImpdirvalVmodifw, lxImpdirvalUmodifw, lxImpdirvalHmodifw, lxImpdirvalSaltafw, lxImpdirvalUaltafw, lxImpdirvalTipoval, lxImpdirvalNumero, lxImpdirvalDescripcio, lxImpdirvalValdesde, lxImpdirvalValhasta, lxImpdirvalMondesde, lxImpdirvalTipotarj, lxImpdirvalMonhasta, lxImpdirvalOpedesde, lxImpdirvalPcuenta, lxImpdirvalOpehasta, lxImpdirvalImportanci, lxImpdirvalSucdesde, lxImpdirvalSuchasta, lxImpdirvalTsucdesde, lxImpdirvalTsuchasta, lxImpdirvalBase, lxImpdirvalTipoasi, lxImpdirvalObs
				lxImpdirvalFectrans =  .Fechatransferencia			lxImpdirvalFecexpo =  .Fechaexpo			lxImpdirvalFaltafw =  .Fechaaltafw			lxImpdirvalFecimpo =  .Fechaimpo			lxImpdirvalFmodifw =  .Fechamodificacionfw			lxImpdirvalEsttrans =  .Estadotransferencia			lxImpdirvalHoraexpo =  .Horaexpo			lxImpdirvalHaltafw =  .Horaaltafw			lxImpdirvalBdmodifw =  .Basededatosmodificacionfw			lxImpdirvalHoraimpo =  .Horaimpo			lxImpdirvalZadsfw =  .Zadsfw			lxImpdirvalBdaltafw =  .Basededatosaltafw			lxImpdirvalSmodifw =  .Seriemodificacionfw			lxImpdirvalValtafw =  .Versionaltafw			lxImpdirvalVmodifw =  .Versionmodificacionfw			lxImpdirvalUmodifw =  .Usuariomodificacionfw			lxImpdirvalHmodifw =  .Horamodificacionfw			lxImpdirvalSaltafw =  .Seriealtafw			lxImpdirvalUaltafw =  .Usuarioaltafw			lxImpdirvalTipoval =  .Tipo			lxImpdirvalNumero =  .Numero			lxImpdirvalDescripcio =  .Descripcion			lxImpdirvalValdesde =  upper( .f_Valor_Desde_PK ) 			lxImpdirvalValhasta =  upper( .f_Valor_Hasta_PK ) 			lxImpdirvalMondesde =  upper( .f_Moneda_Desde_PK ) 			lxImpdirvalTipotarj =  .Tipotarjeta			lxImpdirvalMonhasta =  upper( .f_Moneda_Hasta_PK ) 			lxImpdirvalOpedesde =  upper( .f_OperadoraDeTarjeta_Desde_PK ) 			lxImpdirvalPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirvalOpehasta =  upper( .f_OperadoraDeTarjeta_Hasta_PK ) 			lxImpdirvalImportanci =  .Importancia			lxImpdirvalSucdesde =  upper( .f_Sucursal_Desde_PK ) 			lxImpdirvalSuchasta =  upper( .f_Sucursal_Hasta_PK ) 			lxImpdirvalTsucdesde =  upper( .f_TipoSucursal_Desde_PK ) 			lxImpdirvalTsuchasta =  upper( .f_TipoSucursal_Hasta_PK ) 			lxImpdirvalBase =  .Basededatos			lxImpdirvalTipoasi =  .Tipodeasiento			lxImpdirvalObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxImpdirvalNumero = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.IMPDIRVAL ( "Fectrans","Fecexpo","Faltafw","Fecimpo","Fmodifw","Esttrans","Horaexpo","Haltafw","Bdmodifw","Horaimpo","Zadsfw","Bdaltafw","Smodifw","Valtafw","Vmodifw","Umodifw","Hmodifw","Saltafw","Ualtafw","Tipoval","Numero","Descripcio","Valdesde","Valhasta","Mondesde","Tipotarj","Monhasta","Opedesde","Pcuenta","Opehasta","Importanci","Sucdesde","Suchasta","Tsucdesde","Tsuchasta","Base","Tipoasi","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxImpdirvalFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirvalFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirvalFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirvalFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirvalFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalUaltafw ) + "'" >>, <<lxImpdirvalTipoval >>, <<lxImpdirvalNumero >>, <<"'" + this.FormatearTextoSql( lxImpdirvalDescripcio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalValdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalValhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalMondesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalTipotarj ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalMonhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalOpedesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalPcuenta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalOpehasta ) + "'" >>, <<lxImpdirvalImportanci >>, <<"'" + this.FormatearTextoSql( lxImpdirvalSucdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalSuchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalTsucdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalTsuchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalBase ) + "'" >>, <<lxImpdirvalTipoasi >>, <<"'" + this.FormatearTextoSql( lxImpdirvalObs ) + "'" >> )
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
			local  lxImpdirvalFectrans, lxImpdirvalFecexpo, lxImpdirvalFaltafw, lxImpdirvalFecimpo, lxImpdirvalFmodifw, lxImpdirvalEsttrans, lxImpdirvalHoraexpo, lxImpdirvalHaltafw, lxImpdirvalBdmodifw, lxImpdirvalHoraimpo, lxImpdirvalZadsfw, lxImpdirvalBdaltafw, lxImpdirvalSmodifw, lxImpdirvalValtafw, lxImpdirvalVmodifw, lxImpdirvalUmodifw, lxImpdirvalHmodifw, lxImpdirvalSaltafw, lxImpdirvalUaltafw, lxImpdirvalTipoval, lxImpdirvalNumero, lxImpdirvalDescripcio, lxImpdirvalValdesde, lxImpdirvalValhasta, lxImpdirvalMondesde, lxImpdirvalTipotarj, lxImpdirvalMonhasta, lxImpdirvalOpedesde, lxImpdirvalPcuenta, lxImpdirvalOpehasta, lxImpdirvalImportanci, lxImpdirvalSucdesde, lxImpdirvalSuchasta, lxImpdirvalTsucdesde, lxImpdirvalTsuchasta, lxImpdirvalBase, lxImpdirvalTipoasi, lxImpdirvalObs
				lxImpdirvalFectrans =  .Fechatransferencia			lxImpdirvalFecexpo =  .Fechaexpo			lxImpdirvalFaltafw =  .Fechaaltafw			lxImpdirvalFecimpo =  .Fechaimpo			lxImpdirvalFmodifw =  .Fechamodificacionfw			lxImpdirvalEsttrans =  .Estadotransferencia			lxImpdirvalHoraexpo =  .Horaexpo			lxImpdirvalHaltafw =  .Horaaltafw			lxImpdirvalBdmodifw =  .Basededatosmodificacionfw			lxImpdirvalHoraimpo =  .Horaimpo			lxImpdirvalZadsfw =  .Zadsfw			lxImpdirvalBdaltafw =  .Basededatosaltafw			lxImpdirvalSmodifw =  .Seriemodificacionfw			lxImpdirvalValtafw =  .Versionaltafw			lxImpdirvalVmodifw =  .Versionmodificacionfw			lxImpdirvalUmodifw =  .Usuariomodificacionfw			lxImpdirvalHmodifw =  .Horamodificacionfw			lxImpdirvalSaltafw =  .Seriealtafw			lxImpdirvalUaltafw =  .Usuarioaltafw			lxImpdirvalTipoval =  .Tipo			lxImpdirvalNumero =  .Numero			lxImpdirvalDescripcio =  .Descripcion			lxImpdirvalValdesde =  upper( .f_Valor_Desde_PK ) 			lxImpdirvalValhasta =  upper( .f_Valor_Hasta_PK ) 			lxImpdirvalMondesde =  upper( .f_Moneda_Desde_PK ) 			lxImpdirvalTipotarj =  .Tipotarjeta			lxImpdirvalMonhasta =  upper( .f_Moneda_Hasta_PK ) 			lxImpdirvalOpedesde =  upper( .f_OperadoraDeTarjeta_Desde_PK ) 			lxImpdirvalPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirvalOpehasta =  upper( .f_OperadoraDeTarjeta_Hasta_PK ) 			lxImpdirvalImportanci =  .Importancia			lxImpdirvalSucdesde =  upper( .f_Sucursal_Desde_PK ) 			lxImpdirvalSuchasta =  upper( .f_Sucursal_Hasta_PK ) 			lxImpdirvalTsucdesde =  upper( .f_TipoSucursal_Desde_PK ) 			lxImpdirvalTsuchasta =  upper( .f_TipoSucursal_Hasta_PK ) 			lxImpdirvalBase =  .Basededatos			lxImpdirvalTipoasi =  .Tipodeasiento			lxImpdirvalObs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.NUMERO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.IMPDIRVAL set "Fectrans" = <<"'" + this.ConvertirDateSql( lxImpdirvalFectrans ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpdirvalFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxImpdirvalFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpdirvalFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpdirvalFmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxImpdirvalEsttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpdirvalHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalHaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalBdmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpdirvalHoraimpo ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpdirvalZadsfw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalBdaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalSmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalUmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalUaltafw ) + "'">>,"Tipoval" = <<lxImpdirvalTipoval>>,"Numero" = <<lxImpdirvalNumero>>,"Descripcio" = <<"'" + this.FormatearTextoSql( lxImpdirvalDescripcio ) + "'">>,"Valdesde" = <<"'" + this.FormatearTextoSql( lxImpdirvalValdesde ) + "'">>,"Valhasta" = <<"'" + this.FormatearTextoSql( lxImpdirvalValhasta ) + "'">>,"Mondesde" = <<"'" + this.FormatearTextoSql( lxImpdirvalMondesde ) + "'">>,"Tipotarj" = <<"'" + this.FormatearTextoSql( lxImpdirvalTipotarj ) + "'">>,"Monhasta" = <<"'" + this.FormatearTextoSql( lxImpdirvalMonhasta ) + "'">>,"Opedesde" = <<"'" + this.FormatearTextoSql( lxImpdirvalOpedesde ) + "'">>,"Pcuenta" = <<"'" + this.FormatearTextoSql( lxImpdirvalPcuenta ) + "'">>,"Opehasta" = <<"'" + this.FormatearTextoSql( lxImpdirvalOpehasta ) + "'">>,"Importanci" = <<lxImpdirvalImportanci>>,"Sucdesde" = <<"'" + this.FormatearTextoSql( lxImpdirvalSucdesde ) + "'">>,"Suchasta" = <<"'" + this.FormatearTextoSql( lxImpdirvalSuchasta ) + "'">>,"Tsucdesde" = <<"'" + this.FormatearTextoSql( lxImpdirvalTsucdesde ) + "'">>,"Tsuchasta" = <<"'" + this.FormatearTextoSql( lxImpdirvalTsuchasta ) + "'">>,"Base" = <<"'" + this.FormatearTextoSql( lxImpdirvalBase ) + "'">>,"Tipoasi" = <<lxImpdirvalTipoasi>>,"Obs" = <<"'" + this.FormatearTextoSql( lxImpdirvalObs ) + "'">> where "Numero" = <<lxImpdirvalNumero>> and  IMPDIRVAL.NUMERO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 NUMERO from ZooLogic.IMPDIRVAL where " + this.ConvertirFuncionesSql( " IMPDIRVAL.NUMERO != 0" ) )
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
			Local lxImpdirvalNumero
			lxImpdirvalNumero = .Numero

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Tipoval" as "Tipo", "Numero" as "Numero", "Descripcio" as "Descripcion", "Valdesde" as "F_valor_desde", "Valhasta" as "F_valor_hasta", "Mondesde" as "F_moneda_desde", "Tipotarj" as "Tipotarjeta", "Monhasta" as "F_moneda_hasta", "Opedesde" as "F_operadoradetarjeta_desde", "Pcuenta" as "Plandecuentas", "Opehasta" as "F_operadoradetarjeta_hasta", "Importanci" as "Importancia", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRVAL where "Numero" = <<lxImpdirvalNumero>> and  IMPDIRVAL.NUMERO != 0
			endtext
			use in select('c_IMPDIRVAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRVAL', set( 'Datasession' ) )

			if reccount( 'c_IMPDIRVAL' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxImpdirvalNumero as Variant
		llRetorno = .t.
		lxImpdirvalNumero = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.IMPDIRVAL where "Numero" = <<lxImpdirvalNumero>> and  IMPDIRVAL.NUMERO != 0
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Tipoval" as "Tipo", "Numero" as "Numero", "Descripcio" as "Descripcion", "Valdesde" as "F_valor_desde", "Valhasta" as "F_valor_hasta", "Mondesde" as "F_moneda_desde", "Tipotarj" as "Tipotarjeta", "Monhasta" as "F_moneda_hasta", "Opedesde" as "F_operadoradetarjeta_desde", "Pcuenta" as "Plandecuentas", "Opehasta" as "F_operadoradetarjeta_hasta", "Importanci" as "Importancia", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRVAL where  IMPDIRVAL.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_IMPDIRVAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRVAL', set( 'Datasession' ) )
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Tipoval" as "Tipo", "Numero" as "Numero", "Descripcio" as "Descripcion", "Valdesde" as "F_valor_desde", "Valhasta" as "F_valor_hasta", "Mondesde" as "F_moneda_desde", "Tipotarj" as "Tipotarjeta", "Monhasta" as "F_moneda_hasta", "Opedesde" as "F_operadoradetarjeta_desde", "Pcuenta" as "Plandecuentas", "Opehasta" as "F_operadoradetarjeta_hasta", "Importanci" as "Importancia", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRVAL where  str( NUMERO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPDIRVAL.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_IMPDIRVAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRVAL', set( 'Datasession' ) )
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Tipoval" as "Tipo", "Numero" as "Numero", "Descripcio" as "Descripcion", "Valdesde" as "F_valor_desde", "Valhasta" as "F_valor_hasta", "Mondesde" as "F_moneda_desde", "Tipotarj" as "Tipotarjeta", "Monhasta" as "F_moneda_hasta", "Opedesde" as "F_operadoradetarjeta_desde", "Pcuenta" as "Plandecuentas", "Opehasta" as "F_operadoradetarjeta_hasta", "Importanci" as "Importancia", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRVAL where  str( NUMERO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPDIRVAL.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_IMPDIRVAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRVAL', set( 'Datasession' ) )
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Tipoval" as "Tipo", "Numero" as "Numero", "Descripcio" as "Descripcion", "Valdesde" as "F_valor_desde", "Valhasta" as "F_valor_hasta", "Mondesde" as "F_moneda_desde", "Tipotarj" as "Tipotarjeta", "Monhasta" as "F_moneda_hasta", "Opedesde" as "F_operadoradetarjeta_desde", "Pcuenta" as "Plandecuentas", "Opehasta" as "F_operadoradetarjeta_hasta", "Importanci" as "Importancia", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRVAL where  IMPDIRVAL.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_IMPDIRVAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRVAL', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Fecexpo,Faltafw,Fecimpo,Fmodifw,Esttrans,Horaexpo,Haltafw,Bdmodifw,Horaimpo,Zadsfw," + ;
"Bdaltafw,Smodifw,Valtafw,Vmodifw,Umodifw,Hmodifw,Saltafw,Ualtafw,Tipoval,Numero,Descripcio,Valdesde," + ;
"Valhasta,Mondesde,Tipotarj,Monhasta,Opedesde,Pcuenta,Opehasta,Importanci,Sucdesde,Suchasta,Tsucdesde" + ;
",Tsuchasta,Base,Tipoasi,Obs" + ;
" from ZooLogic.IMPDIRVAL where  IMPDIRVAL.NUMERO != 0 and " + lcFiltro )
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
			local  lxImpdirvalFectrans, lxImpdirvalFecexpo, lxImpdirvalFaltafw, lxImpdirvalFecimpo, lxImpdirvalFmodifw, lxImpdirvalEsttrans, lxImpdirvalHoraexpo, lxImpdirvalHaltafw, lxImpdirvalBdmodifw, lxImpdirvalHoraimpo, lxImpdirvalZadsfw, lxImpdirvalBdaltafw, lxImpdirvalSmodifw, lxImpdirvalValtafw, lxImpdirvalVmodifw, lxImpdirvalUmodifw, lxImpdirvalHmodifw, lxImpdirvalSaltafw, lxImpdirvalUaltafw, lxImpdirvalTipoval, lxImpdirvalNumero, lxImpdirvalDescripcio, lxImpdirvalValdesde, lxImpdirvalValhasta, lxImpdirvalMondesde, lxImpdirvalTipotarj, lxImpdirvalMonhasta, lxImpdirvalOpedesde, lxImpdirvalPcuenta, lxImpdirvalOpehasta, lxImpdirvalImportanci, lxImpdirvalSucdesde, lxImpdirvalSuchasta, lxImpdirvalTsucdesde, lxImpdirvalTsuchasta, lxImpdirvalBase, lxImpdirvalTipoasi, lxImpdirvalObs
				lxImpdirvalFectrans = ctod( '  /  /    ' )			lxImpdirvalFecexpo = ctod( '  /  /    ' )			lxImpdirvalFaltafw = ctod( '  /  /    ' )			lxImpdirvalFecimpo = ctod( '  /  /    ' )			lxImpdirvalFmodifw = ctod( '  /  /    ' )			lxImpdirvalEsttrans = []			lxImpdirvalHoraexpo = []			lxImpdirvalHaltafw = []			lxImpdirvalBdmodifw = []			lxImpdirvalHoraimpo = []			lxImpdirvalZadsfw = []			lxImpdirvalBdaltafw = []			lxImpdirvalSmodifw = []			lxImpdirvalValtafw = []			lxImpdirvalVmodifw = []			lxImpdirvalUmodifw = []			lxImpdirvalHmodifw = []			lxImpdirvalSaltafw = []			lxImpdirvalUaltafw = []			lxImpdirvalTipoval = 0			lxImpdirvalNumero = 0			lxImpdirvalDescripcio = []			lxImpdirvalValdesde = []			lxImpdirvalValhasta = []			lxImpdirvalMondesde = []			lxImpdirvalTipotarj = []			lxImpdirvalMonhasta = []			lxImpdirvalOpedesde = []			lxImpdirvalPcuenta = []			lxImpdirvalOpehasta = []			lxImpdirvalImportanci = 0			lxImpdirvalSucdesde = []			lxImpdirvalSuchasta = []			lxImpdirvalTsucdesde = []			lxImpdirvalTsuchasta = []			lxImpdirvalBase = []			lxImpdirvalTipoasi = 0			lxImpdirvalObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.IMPDIRVAL where "NUMERO" = ] + transform( .oEntidad.NUMERO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'IMPDIRVAL' + '_' + tcCampo
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
		lcWhere = " Where  IMPDIRVAL.NUMERO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Tipoval" as "Tipo", "Numero" as "Numero", "Descripcio" as "Descripcion", "Valdesde" as "F_valor_desde", "Valhasta" as "F_valor_hasta", "Mondesde" as "F_moneda_desde", "Tipotarj" as "Tipotarjeta", "Monhasta" as "F_moneda_hasta", "Opedesde" as "F_operadoradetarjeta_desde", "Pcuenta" as "Plandecuentas", "Opehasta" as "F_operadoradetarjeta_hasta", "Importanci" as "Importancia", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'IMPDIRVAL', '', tnTope )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOVAL AS TIPO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIPCIO AS DESCRIPCION'
				Case lcAtributo == 'F_VALOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALDESDE AS F_VALOR_DESDE'
				Case lcAtributo == 'F_VALOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALHASTA AS F_VALOR_HASTA'
				Case lcAtributo == 'F_MONEDA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONDESDE AS F_MONEDA_DESDE'
				Case lcAtributo == 'TIPOTARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOTARJ AS TIPOTARJETA'
				Case lcAtributo == 'F_MONEDA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONHASTA AS F_MONEDA_HASTA'
				Case lcAtributo == 'F_OPERADORADETARJETA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPEDESDE AS F_OPERADORADETARJETA_DESDE'
				Case lcAtributo == 'PLANDECUENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PCUENTA AS PLANDECUENTAS'
				Case lcAtributo == 'F_OPERADORADETARJETA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPEHASTA AS F_OPERADORADETARJETA_HASTA'
				Case lcAtributo == 'IMPORTANCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPORTANCI AS IMPORTANCIA'
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
				Case lcAtributo == 'TIPODEASIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOASI AS TIPODEASIENTO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPOVAL'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIPCIO'
			Case upper( alltrim( tcAtributo ) ) == 'F_VALOR_DESDE'
				lcCampo = 'VALDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_VALOR_HASTA'
				lcCampo = 'VALHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_MONEDA_DESDE'
				lcCampo = 'MONDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOTARJETA'
				lcCampo = 'TIPOTARJ'
			Case upper( alltrim( tcAtributo ) ) == 'F_MONEDA_HASTA'
				lcCampo = 'MONHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_OPERADORADETARJETA_DESDE'
				lcCampo = 'OPEDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'PLANDECUENTAS'
				lcCampo = 'PCUENTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_OPERADORADETARJETA_HASTA'
				lcCampo = 'OPEHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'IMPORTANCIA'
				lcCampo = 'IMPORTANCI'
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
			Case upper( alltrim( tcAtributo ) ) == 'TIPODEASIENTO'
				lcCampo = 'TIPOASI'
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
			local  lxImpdirvalFectrans, lxImpdirvalFecexpo, lxImpdirvalFaltafw, lxImpdirvalFecimpo, lxImpdirvalFmodifw, lxImpdirvalEsttrans, lxImpdirvalHoraexpo, lxImpdirvalHaltafw, lxImpdirvalBdmodifw, lxImpdirvalHoraimpo, lxImpdirvalZadsfw, lxImpdirvalBdaltafw, lxImpdirvalSmodifw, lxImpdirvalValtafw, lxImpdirvalVmodifw, lxImpdirvalUmodifw, lxImpdirvalHmodifw, lxImpdirvalSaltafw, lxImpdirvalUaltafw, lxImpdirvalTipoval, lxImpdirvalNumero, lxImpdirvalDescripcio, lxImpdirvalValdesde, lxImpdirvalValhasta, lxImpdirvalMondesde, lxImpdirvalTipotarj, lxImpdirvalMonhasta, lxImpdirvalOpedesde, lxImpdirvalPcuenta, lxImpdirvalOpehasta, lxImpdirvalImportanci, lxImpdirvalSucdesde, lxImpdirvalSuchasta, lxImpdirvalTsucdesde, lxImpdirvalTsuchasta, lxImpdirvalBase, lxImpdirvalTipoasi, lxImpdirvalObs
				lxImpdirvalFectrans =  .Fechatransferencia			lxImpdirvalFecexpo =  .Fechaexpo			lxImpdirvalFaltafw =  .Fechaaltafw			lxImpdirvalFecimpo =  .Fechaimpo			lxImpdirvalFmodifw =  .Fechamodificacionfw			lxImpdirvalEsttrans =  .Estadotransferencia			lxImpdirvalHoraexpo =  .Horaexpo			lxImpdirvalHaltafw =  .Horaaltafw			lxImpdirvalBdmodifw =  .Basededatosmodificacionfw			lxImpdirvalHoraimpo =  .Horaimpo			lxImpdirvalZadsfw =  .Zadsfw			lxImpdirvalBdaltafw =  .Basededatosaltafw			lxImpdirvalSmodifw =  .Seriemodificacionfw			lxImpdirvalValtafw =  .Versionaltafw			lxImpdirvalVmodifw =  .Versionmodificacionfw			lxImpdirvalUmodifw =  .Usuariomodificacionfw			lxImpdirvalHmodifw =  .Horamodificacionfw			lxImpdirvalSaltafw =  .Seriealtafw			lxImpdirvalUaltafw =  .Usuarioaltafw			lxImpdirvalTipoval =  .Tipo			lxImpdirvalNumero =  .Numero			lxImpdirvalDescripcio =  .Descripcion			lxImpdirvalValdesde =  upper( .f_Valor_Desde_PK ) 			lxImpdirvalValhasta =  upper( .f_Valor_Hasta_PK ) 			lxImpdirvalMondesde =  upper( .f_Moneda_Desde_PK ) 			lxImpdirvalTipotarj =  .Tipotarjeta			lxImpdirvalMonhasta =  upper( .f_Moneda_Hasta_PK ) 			lxImpdirvalOpedesde =  upper( .f_OperadoraDeTarjeta_Desde_PK ) 			lxImpdirvalPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirvalOpehasta =  upper( .f_OperadoraDeTarjeta_Hasta_PK ) 			lxImpdirvalImportanci =  .Importancia			lxImpdirvalSucdesde =  upper( .f_Sucursal_Desde_PK ) 			lxImpdirvalSuchasta =  upper( .f_Sucursal_Hasta_PK ) 			lxImpdirvalTsucdesde =  upper( .f_TipoSucursal_Desde_PK ) 			lxImpdirvalTsuchasta =  upper( .f_TipoSucursal_Hasta_PK ) 			lxImpdirvalBase =  .Basededatos			lxImpdirvalTipoasi =  .Tipodeasiento			lxImpdirvalObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.IMPDIRVAL ( "Fectrans","Fecexpo","Faltafw","Fecimpo","Fmodifw","Esttrans","Horaexpo","Haltafw","Bdmodifw","Horaimpo","Zadsfw","Bdaltafw","Smodifw","Valtafw","Vmodifw","Umodifw","Hmodifw","Saltafw","Ualtafw","Tipoval","Numero","Descripcio","Valdesde","Valhasta","Mondesde","Tipotarj","Monhasta","Opedesde","Pcuenta","Opehasta","Importanci","Sucdesde","Suchasta","Tsucdesde","Tsuchasta","Base","Tipoasi","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxImpdirvalFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirvalFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirvalFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirvalFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirvalFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalUaltafw ) + "'" >>, <<lxImpdirvalTipoval >>, <<lxImpdirvalNumero >>, <<"'" + this.FormatearTextoSql( lxImpdirvalDescripcio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalValdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalValhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalMondesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalTipotarj ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalMonhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalOpedesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalPcuenta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalOpehasta ) + "'" >>, <<lxImpdirvalImportanci >>, <<"'" + this.FormatearTextoSql( lxImpdirvalSucdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalSuchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalTsucdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalTsuchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalBase ) + "'" >>, <<lxImpdirvalTipoasi >>, <<"'" + this.FormatearTextoSql( lxImpdirvalObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'IMPDIRVAL' 
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
			local  lxImpdirvalFectrans, lxImpdirvalFecexpo, lxImpdirvalFaltafw, lxImpdirvalFecimpo, lxImpdirvalFmodifw, lxImpdirvalEsttrans, lxImpdirvalHoraexpo, lxImpdirvalHaltafw, lxImpdirvalBdmodifw, lxImpdirvalHoraimpo, lxImpdirvalZadsfw, lxImpdirvalBdaltafw, lxImpdirvalSmodifw, lxImpdirvalValtafw, lxImpdirvalVmodifw, lxImpdirvalUmodifw, lxImpdirvalHmodifw, lxImpdirvalSaltafw, lxImpdirvalUaltafw, lxImpdirvalTipoval, lxImpdirvalNumero, lxImpdirvalDescripcio, lxImpdirvalValdesde, lxImpdirvalValhasta, lxImpdirvalMondesde, lxImpdirvalTipotarj, lxImpdirvalMonhasta, lxImpdirvalOpedesde, lxImpdirvalPcuenta, lxImpdirvalOpehasta, lxImpdirvalImportanci, lxImpdirvalSucdesde, lxImpdirvalSuchasta, lxImpdirvalTsucdesde, lxImpdirvalTsuchasta, lxImpdirvalBase, lxImpdirvalTipoasi, lxImpdirvalObs
				lxImpdirvalFectrans =  .Fechatransferencia			lxImpdirvalFecexpo =  .Fechaexpo			lxImpdirvalFaltafw =  .Fechaaltafw			lxImpdirvalFecimpo =  .Fechaimpo			lxImpdirvalFmodifw =  .Fechamodificacionfw			lxImpdirvalEsttrans =  .Estadotransferencia			lxImpdirvalHoraexpo =  .Horaexpo			lxImpdirvalHaltafw =  .Horaaltafw			lxImpdirvalBdmodifw =  .Basededatosmodificacionfw			lxImpdirvalHoraimpo =  .Horaimpo			lxImpdirvalZadsfw =  .Zadsfw			lxImpdirvalBdaltafw =  .Basededatosaltafw			lxImpdirvalSmodifw =  .Seriemodificacionfw			lxImpdirvalValtafw =  .Versionaltafw			lxImpdirvalVmodifw =  .Versionmodificacionfw			lxImpdirvalUmodifw =  .Usuariomodificacionfw			lxImpdirvalHmodifw =  .Horamodificacionfw			lxImpdirvalSaltafw =  .Seriealtafw			lxImpdirvalUaltafw =  .Usuarioaltafw			lxImpdirvalTipoval =  .Tipo			lxImpdirvalNumero =  .Numero			lxImpdirvalDescripcio =  .Descripcion			lxImpdirvalValdesde =  upper( .f_Valor_Desde_PK ) 			lxImpdirvalValhasta =  upper( .f_Valor_Hasta_PK ) 			lxImpdirvalMondesde =  upper( .f_Moneda_Desde_PK ) 			lxImpdirvalTipotarj =  .Tipotarjeta			lxImpdirvalMonhasta =  upper( .f_Moneda_Hasta_PK ) 			lxImpdirvalOpedesde =  upper( .f_OperadoraDeTarjeta_Desde_PK ) 			lxImpdirvalPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirvalOpehasta =  upper( .f_OperadoraDeTarjeta_Hasta_PK ) 			lxImpdirvalImportanci =  .Importancia			lxImpdirvalSucdesde =  upper( .f_Sucursal_Desde_PK ) 			lxImpdirvalSuchasta =  upper( .f_Sucursal_Hasta_PK ) 			lxImpdirvalTsucdesde =  upper( .f_TipoSucursal_Desde_PK ) 			lxImpdirvalTsuchasta =  upper( .f_TipoSucursal_Hasta_PK ) 			lxImpdirvalBase =  .Basededatos			lxImpdirvalTipoasi =  .Tipodeasiento			lxImpdirvalObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  IMPDIRVAL.NUMERO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.IMPDIRVAL set "Fectrans" = <<"'" + this.ConvertirDateSql( lxImpdirvalFectrans ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpdirvalFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxImpdirvalFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpdirvalFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpdirvalFmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxImpdirvalEsttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpdirvalHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalHaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalBdmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpdirvalHoraimpo ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpdirvalZadsfw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalBdaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalSmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalUmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalUaltafw ) + "'">>, "Tipoval" = <<lxImpdirvalTipoval>>, "Numero" = <<lxImpdirvalNumero>>, "Descripcio" = <<"'" + this.FormatearTextoSql( lxImpdirvalDescripcio ) + "'">>, "Valdesde" = <<"'" + this.FormatearTextoSql( lxImpdirvalValdesde ) + "'">>, "Valhasta" = <<"'" + this.FormatearTextoSql( lxImpdirvalValhasta ) + "'">>, "Mondesde" = <<"'" + this.FormatearTextoSql( lxImpdirvalMondesde ) + "'">>, "Tipotarj" = <<"'" + this.FormatearTextoSql( lxImpdirvalTipotarj ) + "'">>, "Monhasta" = <<"'" + this.FormatearTextoSql( lxImpdirvalMonhasta ) + "'">>, "Opedesde" = <<"'" + this.FormatearTextoSql( lxImpdirvalOpedesde ) + "'">>, "Pcuenta" = <<"'" + this.FormatearTextoSql( lxImpdirvalPcuenta ) + "'">>, "Opehasta" = <<"'" + this.FormatearTextoSql( lxImpdirvalOpehasta ) + "'">>, "Importanci" = <<lxImpdirvalImportanci>>, "Sucdesde" = <<"'" + this.FormatearTextoSql( lxImpdirvalSucdesde ) + "'">>, "Suchasta" = <<"'" + this.FormatearTextoSql( lxImpdirvalSuchasta ) + "'">>, "Tsucdesde" = <<"'" + this.FormatearTextoSql( lxImpdirvalTsucdesde ) + "'">>, "Tsuchasta" = <<"'" + this.FormatearTextoSql( lxImpdirvalTsuchasta ) + "'">>, "Base" = <<"'" + this.FormatearTextoSql( lxImpdirvalBase ) + "'">>, "Tipoasi" = <<lxImpdirvalTipoasi>>, "Obs" = <<"'" + this.FormatearTextoSql( lxImpdirvalObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'IMPDIRVAL' 
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

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  IMPDIRVAL.NUMERO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.IMPDIRVAL where ' + lcFiltro )
			loColeccion.cTabla = 'IMPDIRVAL' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.IMPDIRVAL where  IMPDIRVAL.NUMERO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.IMPDIRVAL where NUMERO = " + transform( this.oEntidad.NUMERO )+ " and  IMPDIRVAL.NUMERO != 0" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRVAL'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.IMPDIRVAL Where NUMERO = ] + transform( &lcCursor..NUMERO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.IMPDIRVAL set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, TipoVal = ] + transform( &lcCursor..TipoVal )+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, Descripcio = ] + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'"+ [, ValDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ValDesde ) + "'"+ [, ValHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ValHasta ) + "'"+ [, MonDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..MonDesde ) + "'"+ [, tipotarj = ] + "'" + this.FormatearTextoSql( &lcCursor..tipotarj ) + "'"+ [, MonHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..MonHasta ) + "'"+ [, OpeDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..OpeDesde ) + "'"+ [, PCUENTA = ] + "'" + this.FormatearTextoSql( &lcCursor..PCUENTA ) + "'"+ [, OpeHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..OpeHasta ) + "'"+ [, Importanci = ] + transform( &lcCursor..Importanci )+ [, SucDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..SucDesde ) + "'"+ [, SucHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..SucHasta ) + "'"+ [, TSucDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TSucDesde ) + "'"+ [, TSucHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TSucHasta ) + "'"+ [, Base = ] + "'" + this.FormatearTextoSql( &lcCursor..Base ) + "'"+ [, TipoAsi = ] + transform( &lcCursor..TipoAsi )+ [, OBS = ] + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'" + [ Where NUMERO = ] + transform( &lcCursor..NUMERO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECTRANS, FECEXPO, FALTAFW, FECIMPO, FMODIFW, ESTTRANS, HORAEXPO, HALTAFW, BDMODIFW, HORAIMPO, ZADSFW, BDALTAFW, SMODIFW, VALTAFW, VMODIFW, UMODIFW, HMODIFW, SALTAFW, UALTAFW, TipoVal, NUMERO, Descripcio, ValDesde, ValHasta, MonDesde, tipotarj, MonHasta, OpeDesde, PCUENTA, OpeHasta, Importanci, SucDesde, SucHasta, TSucDesde, TSucHasta, Base, TipoAsi, OBS
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + transform( &lcCursor..TipoVal ) + ',' + transform( &lcCursor..NUMERO )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ValDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ValHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..tipotarj ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OpeDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..PCUENTA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OpeHasta ) + "'" + ',' + transform( &lcCursor..Importanci ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SucDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SucHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TSucDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TSucHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Base ) + "'" + ',' + transform( &lcCursor..TipoAsi ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.IMPDIRVAL ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRVAL'
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
			Case  lcAlias == lcPrefijo + 'IMPDIRVAL'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPDIRVAL_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPDIRVAL_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_IMPDIRVAL')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'IMPDIRVAL'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..NUMERO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad IMPDIRVAL. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRVAL'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRVAL'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IMPDIRVAL') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IMPDIRVAL
Create Table ZooLogic.TablaTrabajo_IMPDIRVAL ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"bdaltafw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"tipoval" numeric( 2, 0 )  null, 
"numero" numeric( 8, 0 )  null, 
"descripcio" char( 50 )  null, 
"valdesde" char( 5 )  null, 
"valhasta" char( 5 )  null, 
"mondesde" char( 10 )  null, 
"tipotarj" char( 1 )  null, 
"monhasta" char( 10 )  null, 
"opedesde" char( 15 )  null, 
"pcuenta" char( 30 )  null, 
"opehasta" char( 15 )  null, 
"importanci" numeric( 5, 0 )  null, 
"sucdesde" char( 10 )  null, 
"suchasta" char( 10 )  null, 
"tsucdesde" char( 10 )  null, 
"tsuchasta" char( 10 )  null, 
"base" char( 21 )  null, 
"tipoasi" numeric( 1, 0 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_IMPDIRVAL' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_IMPDIRVAL' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRVAL'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('tipoval','tipoval')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('descripcio','descripcio')
			.AgregarMapeo('valdesde','valdesde')
			.AgregarMapeo('valhasta','valhasta')
			.AgregarMapeo('mondesde','mondesde')
			.AgregarMapeo('tipotarj','tipotarj')
			.AgregarMapeo('monhasta','monhasta')
			.AgregarMapeo('opedesde','opedesde')
			.AgregarMapeo('pcuenta','pcuenta')
			.AgregarMapeo('opehasta','opehasta')
			.AgregarMapeo('importanci','importanci')
			.AgregarMapeo('sucdesde','sucdesde')
			.AgregarMapeo('suchasta','suchasta')
			.AgregarMapeo('tsucdesde','tsucdesde')
			.AgregarMapeo('tsuchasta','tsuchasta')
			.AgregarMapeo('base','base')
			.AgregarMapeo('tipoasi','tipoasi')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_IMPDIRVAL'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.TIPOVAL = isnull( d.TIPOVAL, t.TIPOVAL ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.DESCRIPCIO = isnull( d.DESCRIPCIO, t.DESCRIPCIO ),t.VALDESDE = isnull( d.VALDESDE, t.VALDESDE ),t.VALHASTA = isnull( d.VALHASTA, t.VALHASTA ),t.MONDESDE = isnull( d.MONDESDE, t.MONDESDE ),t.TIPOTARJ = isnull( d.TIPOTARJ, t.TIPOTARJ ),t.MONHASTA = isnull( d.MONHASTA, t.MONHASTA ),t.OPEDESDE = isnull( d.OPEDESDE, t.OPEDESDE ),t.PCUENTA = isnull( d.PCUENTA, t.PCUENTA ),t.OPEHASTA = isnull( d.OPEHASTA, t.OPEHASTA ),t.IMPORTANCI = isnull( d.IMPORTANCI, t.IMPORTANCI ),t.SUCDESDE = isnull( d.SUCDESDE, t.SUCDESDE ),t.SUCHASTA = isnull( d.SUCHASTA, t.SUCHASTA ),t.TSUCDESDE = isnull( d.TSUCDESDE, t.TSUCDESDE ),t.TSUCHASTA = isnull( d.TSUCHASTA, t.TSUCHASTA ),t.BASE = isnull( d.BASE, t.BASE ),t.TIPOASI = isnull( d.TIPOASI, t.TIPOASI ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.IMPDIRVAL t inner join deleted d 
							 on t.NUMERO = d.NUMERO
				-- Fin Updates
				insert into ZooLogic.IMPDIRVAL(Fectrans,Fecexpo,Faltafw,Fecimpo,Fmodifw,Esttrans,Horaexpo,Haltafw,Bdmodifw,Horaimpo,Zadsfw,Bdaltafw,Smodifw,Valtafw,Vmodifw,Umodifw,Hmodifw,Saltafw,Ualtafw,Tipoval,Numero,Descripcio,Valdesde,Valhasta,Mondesde,Tipotarj,Monhasta,Opedesde,Pcuenta,Opehasta,Importanci,Sucdesde,Suchasta,Tsucdesde,Tsuchasta,Base,Tipoasi,Obs)
					Select isnull( d.FECTRANS,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.BDMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.ZADSFW,''),isnull( d.BDALTAFW,''),isnull( d.SMODIFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.TIPOVAL,0),isnull( d.NUMERO,0),isnull( d.DESCRIPCIO,''),isnull( d.VALDESDE,''),isnull( d.VALHASTA,''),isnull( d.MONDESDE,''),isnull( d.TIPOTARJ,''),isnull( d.MONHASTA,''),isnull( d.OPEDESDE,''),isnull( d.PCUENTA,''),isnull( d.OPEHASTA,''),isnull( d.IMPORTANCI,0),isnull( d.SUCDESDE,''),isnull( d.SUCHASTA,''),isnull( d.TSUCDESDE,''),isnull( d.TSUCHASTA,''),isnull( d.BASE,''),isnull( d.TIPOASI,0),isnull( d.OBS,'')
						From deleted d left join ZooLogic.IMPDIRVAL pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IMPDIRVAL') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IMPDIRVAL
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_IMPDIRVAL' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRVAL.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRVAL.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRVAL.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRVAL.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRVAL.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Estadotransferencia = nvl( c_IMPDIRVAL.Estadotransferencia, [] )
					.Horaexpo = nvl( c_IMPDIRVAL.Horaexpo, [] )
					.Horaaltafw = nvl( c_IMPDIRVAL.Horaaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_IMPDIRVAL.Basededatosmodificacionfw, [] )
					.Horaimpo = nvl( c_IMPDIRVAL.Horaimpo, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Basededatosaltafw = nvl( c_IMPDIRVAL.Basededatosaltafw, [] )
					.Seriemodificacionfw = nvl( c_IMPDIRVAL.Seriemodificacionfw, [] )
					.Versionaltafw = nvl( c_IMPDIRVAL.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_IMPDIRVAL.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_IMPDIRVAL.Usuariomodificacionfw, [] )
					.Horamodificacionfw = nvl( c_IMPDIRVAL.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_IMPDIRVAL.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_IMPDIRVAL.Usuarioaltafw, [] )
					.Tipo = nvl( c_IMPDIRVAL.Tipo, 0 )
					.Numero = nvl( c_IMPDIRVAL.Numero, 0 )
					.Descripcion = nvl( c_IMPDIRVAL.Descripcion, [] )
					.F_valor_desde_PK =  nvl( c_IMPDIRVAL.F_valor_desde, [] )
					.F_valor_hasta_PK =  nvl( c_IMPDIRVAL.F_valor_hasta, [] )
					.F_moneda_desde_PK =  nvl( c_IMPDIRVAL.F_moneda_desde, [] )
					.Tipotarjeta = nvl( c_IMPDIRVAL.Tipotarjeta, [] )
					.F_moneda_hasta_PK =  nvl( c_IMPDIRVAL.F_moneda_hasta, [] )
					.F_operadoradetarjeta_desde_PK =  nvl( c_IMPDIRVAL.F_operadoradetarjeta_desde, [] )
					.Plandecuentas_PK =  nvl( c_IMPDIRVAL.Plandecuentas, [] )
					.F_operadoradetarjeta_hasta_PK =  nvl( c_IMPDIRVAL.F_operadoradetarjeta_hasta, [] )
					.Importancia = nvl( c_IMPDIRVAL.Importancia, 0 )
					.F_sucursal_desde_PK =  nvl( c_IMPDIRVAL.F_sucursal_desde, [] )
					.F_sucursal_hasta_PK =  nvl( c_IMPDIRVAL.F_sucursal_hasta, [] )
					.F_tiposucursal_desde_PK =  nvl( c_IMPDIRVAL.F_tiposucursal_desde, [] )
					.F_tiposucursal_hasta_PK =  nvl( c_IMPDIRVAL.F_tiposucursal_hasta, [] )
					.Basededatos = nvl( c_IMPDIRVAL.Basededatos, [] )
					.Tipodeasiento = nvl( c_IMPDIRVAL.Tipodeasiento, 0 )
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
		return c_IMPDIRVAL.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.IMPDIRVAL' )
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
								from ZooLogic.IMPDIRVAL 
								Where   IMPDIRVAL.NUMERO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "IMPDIRVAL", "", lcCursor, set("Datasession") )
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
			"Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Tipoval" as "Tipo", "Numero" as "Numero", "Descripcio" as "Descripcion", "Valdesde" as "F_valor_desde", "Valhasta" as "F_valor_hasta", "Mondesde" as "F_moneda_desde", "Tipotarj" as "Tipotarjeta", "Monhasta" as "F_moneda_hasta", "Opedesde" as "F_operadoradetarjeta_desde", "Pcuenta" as "Plandecuentas", "Opehasta" as "F_operadoradetarjeta_hasta", "Importanci" as "Importancia", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.IMPDIRVAL 
								Where   IMPDIRVAL.NUMERO != 0
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
	Tabla = 'IMPDIRVAL'
	Filtro = " IMPDIRVAL.NUMERO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " IMPDIRVAL.NUMERO != 0"
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
	<row entidad="IMPDIRVAL                               " atributo="FECHATRANSFERENCIA                      " tabla="IMPDIRVAL      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="FECHAEXPO                               " tabla="IMPDIRVAL      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="FECHAALTAFW                             " tabla="IMPDIRVAL      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="FECHAIMPO                               " tabla="IMPDIRVAL      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="FECHAMODIFICACIONFW                     " tabla="IMPDIRVAL      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                                                                                                                        " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="ESTADOTRANSFERENCIA                     " tabla="IMPDIRVAL      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="HORAEXPO                                " tabla="IMPDIRVAL      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="HORAALTAFW                              " tabla="IMPDIRVAL      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="IMPDIRVAL      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="HORAIMPO                                " tabla="IMPDIRVAL      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="ZADSFW                                  " tabla="IMPDIRVAL      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="BASEDEDATOSALTAFW                       " tabla="IMPDIRVAL      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="SERIEMODIFICACIONFW                     " tabla="IMPDIRVAL      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="VERSIONALTAFW                           " tabla="IMPDIRVAL      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="VERSIONMODIFICACIONFW                   " tabla="IMPDIRVAL      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="USUARIOMODIFICACIONFW                   " tabla="IMPDIRVAL      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="HORAMODIFICACIONFW                      " tabla="IMPDIRVAL      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="SERIEALTAFW                             " tabla="IMPDIRVAL      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="USUARIOALTAFW                           " tabla="IMPDIRVAL      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="TIPO                                    " tabla="IMPDIRVAL      " campo="TIPOVAL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Tipo                                                                                                                                                                                                                                                      " dominio="COMBOF_TIPODEVALORES          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="12" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="NUMERO                                  " tabla="IMPDIRVAL      " campo="NUMERO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Número                                                                                                                                                                                                                                                    " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="DESCRIPCION                             " tabla="IMPDIRVAL      " campo="DESCRIPCIO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                                                                                                               " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="F_VALOR_DESDE                           " tabla="IMPDIRVAL      " campo="VALDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Valor desde                                                                                                                                                                                                                                               " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="11" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="F_VALOR_HASTA                           " tabla="IMPDIRVAL      " campo="VALHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="402" etiqueta="Valor hasta                                                                                                                                                                                                                                               " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="11" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="F_MONEDA_DESDE                          " tabla="IMPDIRVAL      " campo="MONDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Moneda desde                                                                                                                                                                                                                                              " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="13" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="TIPOTARJETA                             " tabla="IMPDIRVAL      " campo="TIPOTARJ  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="0                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="406" etiqueta="Tipo tarjeta                                                                                                                                                                                                                                              " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="15" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="F_MONEDA_HASTA                          " tabla="IMPDIRVAL      " campo="MONHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="408" etiqueta="Moneda hasta                                                                                                                                                                                                                                              " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="13" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="F_OPERADORADETARJETA_DESDE              " tabla="IMPDIRVAL      " campo="OPEDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="OPERADORADETARJETA                      " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Operadora hasta                                                                                                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="14" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="PLANDECUENTAS                           " tabla="IMPDIRVAL      " campo="PCUENTA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PLANDECUENTAS                           " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="412" etiqueta="Cuenta                                                                                                                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot; plancuenta.CTAIMPUT = .t. &quot;                                                                                                                                                                           " grupo="0" subgrupo="1" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="F_OPERADORADETARJETA_HASTA              " tabla="IMPDIRVAL      " campo="OPEHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="OPERADORADETARJETA                      " tipodato="C         " longitud="15" decimales="0" valorsugerido="ZZZZZZZZZZZZZZZ                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="414" etiqueta="Operadora desde                                                                                                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="14" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="IMPORTANCIA                             " tabla="IMPDIRVAL      " campo="IMPORTANCI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Importancia                                                                                                                                                                                                                                               " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="19" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="F_SUCURSAL_DESDE                        " tabla="IMPDIRVAL      " campo="SUCDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SUCURSAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Sucursal desde                                                                                                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="16" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="F_SUCURSAL_HASTA                        " tabla="IMPDIRVAL      " campo="SUCHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SUCURSAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="418" etiqueta="Sucursal hasta                                                                                                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="16" orden="21" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="F_TIPOSUCURSAL_DESDE                    " tabla="IMPDIRVAL      " campo="TSUCDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOSUCURSAL                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Tipo sucursal desde                                                                                                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="17" orden="22" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="F_TIPOSUCURSAL_HASTA                    " tabla="IMPDIRVAL      " campo="TSUCHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOSUCURSAL                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="422" etiqueta="Tipo sucursal hasta                                                                                                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="17" orden="23" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="BASEDEDATOS                             " tabla="IMPDIRVAL      " campo="BASE      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="21" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Base                                                                                                                                                                                                                                                      " dominio="COMBOSUCYAGRUCONVACIO         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="18" orden="24" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="TIPODEASIENTO                           " tabla="IMPDIRVAL      " campo="TIPOASI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="0                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="6" etiqueta="Imputación por tipo de asiento tipo                                                                                                                                                                                                                       " dominio="COMBOTIPODEASIENTO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="19" orden="80" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="OBSERVACION                             " tabla="IMPDIRVAL      " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Observaciones                                                                                                                                                                                                                                             " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="12" orden="99" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCRIPCION                             " tabla="XVAL           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="401" etiqueta="Detalle Val.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join XVAL On IMPDIRVAL.VALDESDE = XVAL.CLCOD And  XVAL.CLCOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCRIPCION                             " tabla="XVAL           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="403" etiqueta="Detalle Val.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join XVAL On IMPDIRVAL.VALHASTA = XVAL.CLCOD And  XVAL.CLCOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Mon.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On IMPDIRVAL.MONDESDE = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Mon.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On IMPDIRVAL.MONHASTA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERADORADETARJETA                      " atributo="DESCRIPCION                             " tabla="OPETAR         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Ope.                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPETAR On IMPDIRVAL.OPEDESDE = OPETAR.Codigo And  OPETAR.CODIGO != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="DESCRIPCION                             " tabla="PLANCUENTA     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Cue.                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PLANCUENTA On IMPDIRVAL.PCUENTA = PLANCUENTA.ctacodigo And  PLANCUENTA.CTACODIGO != ''                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERADORADETARJETA                      " atributo="DESCRIPCION                             " tabla="OPETAR         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="415" etiqueta="Detalle Ope.                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPETAR On IMPDIRVAL.OPEHASTA = OPETAR.Codigo And  OPETAR.CODIGO != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="DESCRIPCION                             " tabla="SUC            " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="417" etiqueta="Detalle Suc.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SUC On IMPDIRVAL.SUCDESDE = SUC.codigo And  SUC.CODIGO != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="DESCRIPCION                             " tabla="SUC            " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="419" etiqueta="Detalle Suc.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SUC On IMPDIRVAL.SUCHASTA = SUC.codigo And  SUC.CODIGO != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOSUCURSAL                            " atributo="DESCRIPCION                             " tabla="TSUCUR         " campo="TDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="421" etiqueta="Detalle Tip.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TSUCUR On IMPDIRVAL.TSUCDESDE = TSUCUR.TCOD And  TSUCUR.TCOD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOSUCURSAL                            " atributo="DESCRIPCION                             " tabla="TSUCUR         " campo="TDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="423" etiqueta="Detalle Tip.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TSUCUR On IMPDIRVAL.TSUCHASTA = TSUCUR.TCOD And  TSUCUR.TCOD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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