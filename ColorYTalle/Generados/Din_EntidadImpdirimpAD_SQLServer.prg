
define class Din_EntidadIMPDIRIMPAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_IMPDIRIMP'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_IDIPK'
	cTablaPrincipal = 'IMPDIRIMP'
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
			local  lxImpdirimpFmodifw, lxImpdirimpFectrans, lxImpdirimpFecimpo, lxImpdirimpFecexpo, lxImpdirimpFaltafw, lxImpdirimpHoraexpo, lxImpdirimpHaltafw, lxImpdirimpHoraimpo, lxImpdirimpSaltafw, lxImpdirimpVmodifw, lxImpdirimpZadsfw, lxImpdirimpValtafw, lxImpdirimpUaltafw, lxImpdirimpUmodifw, lxImpdirimpEsttrans, lxImpdirimpSmodifw, lxImpdirimpHmodifw, lxImpdirimpBdaltafw, lxImpdirimpBdmodifw, lxImpdirimpObs, lxImpdirimpNumero, lxImpdirimpDescripcio, lxImpdirimpImpdesde, lxImpdirimpImphasta, lxImpdirimpAplicacion, lxImpdirimpTipdesde, lxImpdirimpTiphasta, lxImpdirimpJurdesde, lxImpdirimpJurhasta, lxImpdirimpSucdesde, lxImpdirimpSuchasta, lxImpdirimpTsucdesde, lxImpdirimpTsuchasta, lxImpdirimpBase, lxImpdirimpPcuenta, lxImpdirimpImportanci, lxImpdirimpTipoasi
				lxImpdirimpFmodifw =  .Fechamodificacionfw			lxImpdirimpFectrans =  .Fechatransferencia			lxImpdirimpFecimpo =  .Fechaimpo			lxImpdirimpFecexpo =  .Fechaexpo			lxImpdirimpFaltafw =  .Fechaaltafw			lxImpdirimpHoraexpo =  .Horaexpo			lxImpdirimpHaltafw =  .Horaaltafw			lxImpdirimpHoraimpo =  .Horaimpo			lxImpdirimpSaltafw =  .Seriealtafw			lxImpdirimpVmodifw =  .Versionmodificacionfw			lxImpdirimpZadsfw =  .Zadsfw			lxImpdirimpValtafw =  .Versionaltafw			lxImpdirimpUaltafw =  .Usuarioaltafw			lxImpdirimpUmodifw =  .Usuariomodificacionfw			lxImpdirimpEsttrans =  .Estadotransferencia			lxImpdirimpSmodifw =  .Seriemodificacionfw			lxImpdirimpHmodifw =  .Horamodificacionfw			lxImpdirimpBdaltafw =  .Basededatosaltafw			lxImpdirimpBdmodifw =  .Basededatosmodificacionfw			lxImpdirimpObs =  .Observacion			lxImpdirimpNumero =  .Numero			lxImpdirimpDescripcio =  .Descripcion			lxImpdirimpImpdesde =  upper( .f_Impuesto_Desde_PK ) 			lxImpdirimpImphasta =  upper( .f_Impuesto_Hasta_PK ) 			lxImpdirimpAplicacion =  .Aplicacion			lxImpdirimpTipdesde =  upper( .f_TipoImp_Desde_PK ) 			lxImpdirimpTiphasta =  upper( .f_TipoImp_Hasta_PK ) 			lxImpdirimpJurdesde =  upper( .f_Jurisdiccion_Desde_PK ) 			lxImpdirimpJurhasta =  upper( .f_Jurisdiccion_Hasta_PK ) 			lxImpdirimpSucdesde =  upper( .f_Sucursal_Desde_PK ) 			lxImpdirimpSuchasta =  upper( .f_Sucursal_Hasta_PK ) 			lxImpdirimpTsucdesde =  upper( .f_TipoSucursal_Desde_PK ) 			lxImpdirimpTsuchasta =  upper( .f_TipoSucursal_Hasta_PK ) 			lxImpdirimpBase =  .Basededatos			lxImpdirimpPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirimpImportanci =  .Importancia			lxImpdirimpTipoasi =  .Tipodeasiento
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxImpdirimpNumero = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.IMPDIRIMP ( "Fmodifw","Fectrans","Fecimpo","Fecexpo","Faltafw","Horaexpo","Haltafw","Horaimpo","Saltafw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Esttrans","Smodifw","Hmodifw","Bdaltafw","Bdmodifw","Obs","Numero","Descripcio","Impdesde","Imphasta","Aplicacion","Tipdesde","Tiphasta","Jurdesde","Jurhasta","Sucdesde","Suchasta","Tsucdesde","Tsuchasta","Base","Pcuenta","Importanci","Tipoasi" ) values ( <<"'" + this.ConvertirDateSql( lxImpdirimpFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirimpFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirimpFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirimpFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirimpFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpObs ) + "'" >>, <<lxImpdirimpNumero >>, <<"'" + this.FormatearTextoSql( lxImpdirimpDescripcio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpImpdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpImphasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpAplicacion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpTipdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpTiphasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpJurdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpJurhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpSucdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpSuchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpTsucdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpTsuchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpBase ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpPcuenta ) + "'" >>, <<lxImpdirimpImportanci >>, <<lxImpdirimpTipoasi >> )
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
			local  lxImpdirimpFmodifw, lxImpdirimpFectrans, lxImpdirimpFecimpo, lxImpdirimpFecexpo, lxImpdirimpFaltafw, lxImpdirimpHoraexpo, lxImpdirimpHaltafw, lxImpdirimpHoraimpo, lxImpdirimpSaltafw, lxImpdirimpVmodifw, lxImpdirimpZadsfw, lxImpdirimpValtafw, lxImpdirimpUaltafw, lxImpdirimpUmodifw, lxImpdirimpEsttrans, lxImpdirimpSmodifw, lxImpdirimpHmodifw, lxImpdirimpBdaltafw, lxImpdirimpBdmodifw, lxImpdirimpObs, lxImpdirimpNumero, lxImpdirimpDescripcio, lxImpdirimpImpdesde, lxImpdirimpImphasta, lxImpdirimpAplicacion, lxImpdirimpTipdesde, lxImpdirimpTiphasta, lxImpdirimpJurdesde, lxImpdirimpJurhasta, lxImpdirimpSucdesde, lxImpdirimpSuchasta, lxImpdirimpTsucdesde, lxImpdirimpTsuchasta, lxImpdirimpBase, lxImpdirimpPcuenta, lxImpdirimpImportanci, lxImpdirimpTipoasi
				lxImpdirimpFmodifw =  .Fechamodificacionfw			lxImpdirimpFectrans =  .Fechatransferencia			lxImpdirimpFecimpo =  .Fechaimpo			lxImpdirimpFecexpo =  .Fechaexpo			lxImpdirimpFaltafw =  .Fechaaltafw			lxImpdirimpHoraexpo =  .Horaexpo			lxImpdirimpHaltafw =  .Horaaltafw			lxImpdirimpHoraimpo =  .Horaimpo			lxImpdirimpSaltafw =  .Seriealtafw			lxImpdirimpVmodifw =  .Versionmodificacionfw			lxImpdirimpZadsfw =  .Zadsfw			lxImpdirimpValtafw =  .Versionaltafw			lxImpdirimpUaltafw =  .Usuarioaltafw			lxImpdirimpUmodifw =  .Usuariomodificacionfw			lxImpdirimpEsttrans =  .Estadotransferencia			lxImpdirimpSmodifw =  .Seriemodificacionfw			lxImpdirimpHmodifw =  .Horamodificacionfw			lxImpdirimpBdaltafw =  .Basededatosaltafw			lxImpdirimpBdmodifw =  .Basededatosmodificacionfw			lxImpdirimpObs =  .Observacion			lxImpdirimpNumero =  .Numero			lxImpdirimpDescripcio =  .Descripcion			lxImpdirimpImpdesde =  upper( .f_Impuesto_Desde_PK ) 			lxImpdirimpImphasta =  upper( .f_Impuesto_Hasta_PK ) 			lxImpdirimpAplicacion =  .Aplicacion			lxImpdirimpTipdesde =  upper( .f_TipoImp_Desde_PK ) 			lxImpdirimpTiphasta =  upper( .f_TipoImp_Hasta_PK ) 			lxImpdirimpJurdesde =  upper( .f_Jurisdiccion_Desde_PK ) 			lxImpdirimpJurhasta =  upper( .f_Jurisdiccion_Hasta_PK ) 			lxImpdirimpSucdesde =  upper( .f_Sucursal_Desde_PK ) 			lxImpdirimpSuchasta =  upper( .f_Sucursal_Hasta_PK ) 			lxImpdirimpTsucdesde =  upper( .f_TipoSucursal_Desde_PK ) 			lxImpdirimpTsuchasta =  upper( .f_TipoSucursal_Hasta_PK ) 			lxImpdirimpBase =  .Basededatos			lxImpdirimpPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirimpImportanci =  .Importancia			lxImpdirimpTipoasi =  .Tipodeasiento
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.NUMERO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.IMPDIRIMP set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpdirimpFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxImpdirimpFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpdirimpFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpdirimpFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxImpdirimpFaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpdirimpHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxImpdirimpHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpdirimpHoraimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxImpdirimpSaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirimpVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpdirimpZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxImpdirimpValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpdirimpUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxImpdirimpUmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxImpdirimpEsttrans ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxImpdirimpSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirimpHmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpdirimpBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirimpBdmodifw ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxImpdirimpObs ) + "'">>,"Numero" = <<lxImpdirimpNumero>>,"Descripcio" = <<"'" + this.FormatearTextoSql( lxImpdirimpDescripcio ) + "'">>,"Impdesde" = <<"'" + this.FormatearTextoSql( lxImpdirimpImpdesde ) + "'">>,"Imphasta" = <<"'" + this.FormatearTextoSql( lxImpdirimpImphasta ) + "'">>,"Aplicacion" = <<"'" + this.FormatearTextoSql( lxImpdirimpAplicacion ) + "'">>,"Tipdesde" = <<"'" + this.FormatearTextoSql( lxImpdirimpTipdesde ) + "'">>,"Tiphasta" = <<"'" + this.FormatearTextoSql( lxImpdirimpTiphasta ) + "'">>,"Jurdesde" = <<"'" + this.FormatearTextoSql( lxImpdirimpJurdesde ) + "'">>,"Jurhasta" = <<"'" + this.FormatearTextoSql( lxImpdirimpJurhasta ) + "'">>,"Sucdesde" = <<"'" + this.FormatearTextoSql( lxImpdirimpSucdesde ) + "'">>,"Suchasta" = <<"'" + this.FormatearTextoSql( lxImpdirimpSuchasta ) + "'">>,"Tsucdesde" = <<"'" + this.FormatearTextoSql( lxImpdirimpTsucdesde ) + "'">>,"Tsuchasta" = <<"'" + this.FormatearTextoSql( lxImpdirimpTsuchasta ) + "'">>,"Base" = <<"'" + this.FormatearTextoSql( lxImpdirimpBase ) + "'">>,"Pcuenta" = <<"'" + this.FormatearTextoSql( lxImpdirimpPcuenta ) + "'">>,"Importanci" = <<lxImpdirimpImportanci>>,"Tipoasi" = <<lxImpdirimpTipoasi>> where "Numero" = <<lxImpdirimpNumero>> and  IMPDIRIMP.NUMERO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 NUMERO from ZooLogic.IMPDIRIMP where " + this.ConvertirFuncionesSql( " IMPDIRIMP.NUMERO != 0" ) )
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
			Local lxImpdirimpNumero
			lxImpdirimpNumero = .Numero

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Descripcio" as "Descripcion", "Impdesde" as "F_impuesto_desde", "Imphasta" as "F_impuesto_hasta", "Aplicacion" as "Aplicacion", "Tipdesde" as "F_tipoimp_desde", "Tiphasta" as "F_tipoimp_hasta", "Jurdesde" as "F_jurisdiccion_desde", "Jurhasta" as "F_jurisdiccion_hasta", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Tipoasi" as "Tipodeasiento" from ZooLogic.IMPDIRIMP where "Numero" = <<lxImpdirimpNumero>> and  IMPDIRIMP.NUMERO != 0
			endtext
			use in select('c_IMPDIRIMP')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRIMP', set( 'Datasession' ) )

			if reccount( 'c_IMPDIRIMP' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxImpdirimpNumero as Variant
		llRetorno = .t.
		lxImpdirimpNumero = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.IMPDIRIMP where "Numero" = <<lxImpdirimpNumero>> and  IMPDIRIMP.NUMERO != 0
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Descripcio" as "Descripcion", "Impdesde" as "F_impuesto_desde", "Imphasta" as "F_impuesto_hasta", "Aplicacion" as "Aplicacion", "Tipdesde" as "F_tipoimp_desde", "Tiphasta" as "F_tipoimp_hasta", "Jurdesde" as "F_jurisdiccion_desde", "Jurhasta" as "F_jurisdiccion_hasta", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Tipoasi" as "Tipodeasiento" from ZooLogic.IMPDIRIMP where  IMPDIRIMP.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_IMPDIRIMP')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRIMP', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Descripcio" as "Descripcion", "Impdesde" as "F_impuesto_desde", "Imphasta" as "F_impuesto_hasta", "Aplicacion" as "Aplicacion", "Tipdesde" as "F_tipoimp_desde", "Tiphasta" as "F_tipoimp_hasta", "Jurdesde" as "F_jurisdiccion_desde", "Jurhasta" as "F_jurisdiccion_hasta", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Tipoasi" as "Tipodeasiento" from ZooLogic.IMPDIRIMP where  str( NUMERO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPDIRIMP.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_IMPDIRIMP')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRIMP', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Descripcio" as "Descripcion", "Impdesde" as "F_impuesto_desde", "Imphasta" as "F_impuesto_hasta", "Aplicacion" as "Aplicacion", "Tipdesde" as "F_tipoimp_desde", "Tiphasta" as "F_tipoimp_hasta", "Jurdesde" as "F_jurisdiccion_desde", "Jurhasta" as "F_jurisdiccion_hasta", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Tipoasi" as "Tipodeasiento" from ZooLogic.IMPDIRIMP where  str( NUMERO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPDIRIMP.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_IMPDIRIMP')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRIMP', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Descripcio" as "Descripcion", "Impdesde" as "F_impuesto_desde", "Imphasta" as "F_impuesto_hasta", "Aplicacion" as "Aplicacion", "Tipdesde" as "F_tipoimp_desde", "Tiphasta" as "F_tipoimp_hasta", "Jurdesde" as "F_jurisdiccion_desde", "Jurhasta" as "F_jurisdiccion_hasta", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Tipoasi" as "Tipodeasiento" from ZooLogic.IMPDIRIMP where  IMPDIRIMP.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_IMPDIRIMP')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRIMP', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fectrans,Fecimpo,Fecexpo,Faltafw,Horaexpo,Haltafw,Horaimpo,Saltafw,Vmodifw,Zadsfw,Va" + ;
"ltafw,Ualtafw,Umodifw,Esttrans,Smodifw,Hmodifw,Bdaltafw,Bdmodifw,Obs,Numero,Descripcio,Impdesde,Imph" + ;
"asta,Aplicacion,Tipdesde,Tiphasta,Jurdesde,Jurhasta,Sucdesde,Suchasta,Tsucdesde,Tsuchasta,Base,Pcuen" + ;
"ta,Importanci,Tipoasi" + ;
" from ZooLogic.IMPDIRIMP where  IMPDIRIMP.NUMERO != 0 and " + lcFiltro )
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
			local  lxImpdirimpFmodifw, lxImpdirimpFectrans, lxImpdirimpFecimpo, lxImpdirimpFecexpo, lxImpdirimpFaltafw, lxImpdirimpHoraexpo, lxImpdirimpHaltafw, lxImpdirimpHoraimpo, lxImpdirimpSaltafw, lxImpdirimpVmodifw, lxImpdirimpZadsfw, lxImpdirimpValtafw, lxImpdirimpUaltafw, lxImpdirimpUmodifw, lxImpdirimpEsttrans, lxImpdirimpSmodifw, lxImpdirimpHmodifw, lxImpdirimpBdaltafw, lxImpdirimpBdmodifw, lxImpdirimpObs, lxImpdirimpNumero, lxImpdirimpDescripcio, lxImpdirimpImpdesde, lxImpdirimpImphasta, lxImpdirimpAplicacion, lxImpdirimpTipdesde, lxImpdirimpTiphasta, lxImpdirimpJurdesde, lxImpdirimpJurhasta, lxImpdirimpSucdesde, lxImpdirimpSuchasta, lxImpdirimpTsucdesde, lxImpdirimpTsuchasta, lxImpdirimpBase, lxImpdirimpPcuenta, lxImpdirimpImportanci, lxImpdirimpTipoasi
				lxImpdirimpFmodifw = ctod( '  /  /    ' )			lxImpdirimpFectrans = ctod( '  /  /    ' )			lxImpdirimpFecimpo = ctod( '  /  /    ' )			lxImpdirimpFecexpo = ctod( '  /  /    ' )			lxImpdirimpFaltafw = ctod( '  /  /    ' )			lxImpdirimpHoraexpo = []			lxImpdirimpHaltafw = []			lxImpdirimpHoraimpo = []			lxImpdirimpSaltafw = []			lxImpdirimpVmodifw = []			lxImpdirimpZadsfw = []			lxImpdirimpValtafw = []			lxImpdirimpUaltafw = []			lxImpdirimpUmodifw = []			lxImpdirimpEsttrans = []			lxImpdirimpSmodifw = []			lxImpdirimpHmodifw = []			lxImpdirimpBdaltafw = []			lxImpdirimpBdmodifw = []			lxImpdirimpObs = []			lxImpdirimpNumero = 0			lxImpdirimpDescripcio = []			lxImpdirimpImpdesde = []			lxImpdirimpImphasta = []			lxImpdirimpAplicacion = []			lxImpdirimpTipdesde = []			lxImpdirimpTiphasta = []			lxImpdirimpJurdesde = []			lxImpdirimpJurhasta = []			lxImpdirimpSucdesde = []			lxImpdirimpSuchasta = []			lxImpdirimpTsucdesde = []			lxImpdirimpTsuchasta = []			lxImpdirimpBase = []			lxImpdirimpPcuenta = []			lxImpdirimpImportanci = 0			lxImpdirimpTipoasi = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.IMPDIRIMP where "NUMERO" = ] + transform( .oEntidad.NUMERO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'IMPDIRIMP' + '_' + tcCampo
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
		lcWhere = " Where  IMPDIRIMP.NUMERO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Descripcio" as "Descripcion", "Impdesde" as "F_impuesto_desde", "Imphasta" as "F_impuesto_hasta", "Aplicacion" as "Aplicacion", "Tipdesde" as "F_tipoimp_desde", "Tiphasta" as "F_tipoimp_hasta", "Jurdesde" as "F_jurisdiccion_desde", "Jurhasta" as "F_jurisdiccion_hasta", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Tipoasi" as "Tipodeasiento"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'IMPDIRIMP', '', tnTope )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIPCIO AS DESCRIPCION'
				Case lcAtributo == 'F_IMPUESTO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPDESDE AS F_IMPUESTO_DESDE'
				Case lcAtributo == 'F_IMPUESTO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPHASTA AS F_IMPUESTO_HASTA'
				Case lcAtributo == 'APLICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APLICACION AS APLICACION'
				Case lcAtributo == 'F_TIPOIMP_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPDESDE AS F_TIPOIMP_DESDE'
				Case lcAtributo == 'F_TIPOIMP_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPHASTA AS F_TIPOIMP_HASTA'
				Case lcAtributo == 'F_JURISDICCION_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JURDESDE AS F_JURISDICCION_DESDE'
				Case lcAtributo == 'F_JURISDICCION_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JURHASTA AS F_JURISDICCION_HASTA'
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
				Case lcAtributo == 'PLANDECUENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PCUENTA AS PLANDECUENTAS'
				Case lcAtributo == 'IMPORTANCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPORTANCI AS IMPORTANCIA'
				Case lcAtributo == 'TIPODEASIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOASI AS TIPODEASIENTO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIPCIO'
			Case upper( alltrim( tcAtributo ) ) == 'F_IMPUESTO_DESDE'
				lcCampo = 'IMPDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_IMPUESTO_HASTA'
				lcCampo = 'IMPHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'APLICACION'
				lcCampo = 'APLICACION'
			Case upper( alltrim( tcAtributo ) ) == 'F_TIPOIMP_DESDE'
				lcCampo = 'TIPDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_TIPOIMP_HASTA'
				lcCampo = 'TIPHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_JURISDICCION_DESDE'
				lcCampo = 'JURDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_JURISDICCION_HASTA'
				lcCampo = 'JURHASTA'
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
			Case upper( alltrim( tcAtributo ) ) == 'PLANDECUENTAS'
				lcCampo = 'PCUENTA'
			Case upper( alltrim( tcAtributo ) ) == 'IMPORTANCIA'
				lcCampo = 'IMPORTANCI'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODEASIENTO'
				lcCampo = 'TIPOASI'
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
			local  lxImpdirimpFmodifw, lxImpdirimpFectrans, lxImpdirimpFecimpo, lxImpdirimpFecexpo, lxImpdirimpFaltafw, lxImpdirimpHoraexpo, lxImpdirimpHaltafw, lxImpdirimpHoraimpo, lxImpdirimpSaltafw, lxImpdirimpVmodifw, lxImpdirimpZadsfw, lxImpdirimpValtafw, lxImpdirimpUaltafw, lxImpdirimpUmodifw, lxImpdirimpEsttrans, lxImpdirimpSmodifw, lxImpdirimpHmodifw, lxImpdirimpBdaltafw, lxImpdirimpBdmodifw, lxImpdirimpObs, lxImpdirimpNumero, lxImpdirimpDescripcio, lxImpdirimpImpdesde, lxImpdirimpImphasta, lxImpdirimpAplicacion, lxImpdirimpTipdesde, lxImpdirimpTiphasta, lxImpdirimpJurdesde, lxImpdirimpJurhasta, lxImpdirimpSucdesde, lxImpdirimpSuchasta, lxImpdirimpTsucdesde, lxImpdirimpTsuchasta, lxImpdirimpBase, lxImpdirimpPcuenta, lxImpdirimpImportanci, lxImpdirimpTipoasi
				lxImpdirimpFmodifw =  .Fechamodificacionfw			lxImpdirimpFectrans =  .Fechatransferencia			lxImpdirimpFecimpo =  .Fechaimpo			lxImpdirimpFecexpo =  .Fechaexpo			lxImpdirimpFaltafw =  .Fechaaltafw			lxImpdirimpHoraexpo =  .Horaexpo			lxImpdirimpHaltafw =  .Horaaltafw			lxImpdirimpHoraimpo =  .Horaimpo			lxImpdirimpSaltafw =  .Seriealtafw			lxImpdirimpVmodifw =  .Versionmodificacionfw			lxImpdirimpZadsfw =  .Zadsfw			lxImpdirimpValtafw =  .Versionaltafw			lxImpdirimpUaltafw =  .Usuarioaltafw			lxImpdirimpUmodifw =  .Usuariomodificacionfw			lxImpdirimpEsttrans =  .Estadotransferencia			lxImpdirimpSmodifw =  .Seriemodificacionfw			lxImpdirimpHmodifw =  .Horamodificacionfw			lxImpdirimpBdaltafw =  .Basededatosaltafw			lxImpdirimpBdmodifw =  .Basededatosmodificacionfw			lxImpdirimpObs =  .Observacion			lxImpdirimpNumero =  .Numero			lxImpdirimpDescripcio =  .Descripcion			lxImpdirimpImpdesde =  upper( .f_Impuesto_Desde_PK ) 			lxImpdirimpImphasta =  upper( .f_Impuesto_Hasta_PK ) 			lxImpdirimpAplicacion =  .Aplicacion			lxImpdirimpTipdesde =  upper( .f_TipoImp_Desde_PK ) 			lxImpdirimpTiphasta =  upper( .f_TipoImp_Hasta_PK ) 			lxImpdirimpJurdesde =  upper( .f_Jurisdiccion_Desde_PK ) 			lxImpdirimpJurhasta =  upper( .f_Jurisdiccion_Hasta_PK ) 			lxImpdirimpSucdesde =  upper( .f_Sucursal_Desde_PK ) 			lxImpdirimpSuchasta =  upper( .f_Sucursal_Hasta_PK ) 			lxImpdirimpTsucdesde =  upper( .f_TipoSucursal_Desde_PK ) 			lxImpdirimpTsuchasta =  upper( .f_TipoSucursal_Hasta_PK ) 			lxImpdirimpBase =  .Basededatos			lxImpdirimpPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirimpImportanci =  .Importancia			lxImpdirimpTipoasi =  .Tipodeasiento
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.IMPDIRIMP ( "Fmodifw","Fectrans","Fecimpo","Fecexpo","Faltafw","Horaexpo","Haltafw","Horaimpo","Saltafw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Esttrans","Smodifw","Hmodifw","Bdaltafw","Bdmodifw","Obs","Numero","Descripcio","Impdesde","Imphasta","Aplicacion","Tipdesde","Tiphasta","Jurdesde","Jurhasta","Sucdesde","Suchasta","Tsucdesde","Tsuchasta","Base","Pcuenta","Importanci","Tipoasi" ) values ( <<"'" + this.ConvertirDateSql( lxImpdirimpFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirimpFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirimpFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirimpFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirimpFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpObs ) + "'" >>, <<lxImpdirimpNumero >>, <<"'" + this.FormatearTextoSql( lxImpdirimpDescripcio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpImpdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpImphasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpAplicacion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpTipdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpTiphasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpJurdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpJurhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpSucdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpSuchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpTsucdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpTsuchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpBase ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirimpPcuenta ) + "'" >>, <<lxImpdirimpImportanci >>, <<lxImpdirimpTipoasi >> )
		endtext
		loColeccion.cTabla = 'IMPDIRIMP' 
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
			local  lxImpdirimpFmodifw, lxImpdirimpFectrans, lxImpdirimpFecimpo, lxImpdirimpFecexpo, lxImpdirimpFaltafw, lxImpdirimpHoraexpo, lxImpdirimpHaltafw, lxImpdirimpHoraimpo, lxImpdirimpSaltafw, lxImpdirimpVmodifw, lxImpdirimpZadsfw, lxImpdirimpValtafw, lxImpdirimpUaltafw, lxImpdirimpUmodifw, lxImpdirimpEsttrans, lxImpdirimpSmodifw, lxImpdirimpHmodifw, lxImpdirimpBdaltafw, lxImpdirimpBdmodifw, lxImpdirimpObs, lxImpdirimpNumero, lxImpdirimpDescripcio, lxImpdirimpImpdesde, lxImpdirimpImphasta, lxImpdirimpAplicacion, lxImpdirimpTipdesde, lxImpdirimpTiphasta, lxImpdirimpJurdesde, lxImpdirimpJurhasta, lxImpdirimpSucdesde, lxImpdirimpSuchasta, lxImpdirimpTsucdesde, lxImpdirimpTsuchasta, lxImpdirimpBase, lxImpdirimpPcuenta, lxImpdirimpImportanci, lxImpdirimpTipoasi
				lxImpdirimpFmodifw =  .Fechamodificacionfw			lxImpdirimpFectrans =  .Fechatransferencia			lxImpdirimpFecimpo =  .Fechaimpo			lxImpdirimpFecexpo =  .Fechaexpo			lxImpdirimpFaltafw =  .Fechaaltafw			lxImpdirimpHoraexpo =  .Horaexpo			lxImpdirimpHaltafw =  .Horaaltafw			lxImpdirimpHoraimpo =  .Horaimpo			lxImpdirimpSaltafw =  .Seriealtafw			lxImpdirimpVmodifw =  .Versionmodificacionfw			lxImpdirimpZadsfw =  .Zadsfw			lxImpdirimpValtafw =  .Versionaltafw			lxImpdirimpUaltafw =  .Usuarioaltafw			lxImpdirimpUmodifw =  .Usuariomodificacionfw			lxImpdirimpEsttrans =  .Estadotransferencia			lxImpdirimpSmodifw =  .Seriemodificacionfw			lxImpdirimpHmodifw =  .Horamodificacionfw			lxImpdirimpBdaltafw =  .Basededatosaltafw			lxImpdirimpBdmodifw =  .Basededatosmodificacionfw			lxImpdirimpObs =  .Observacion			lxImpdirimpNumero =  .Numero			lxImpdirimpDescripcio =  .Descripcion			lxImpdirimpImpdesde =  upper( .f_Impuesto_Desde_PK ) 			lxImpdirimpImphasta =  upper( .f_Impuesto_Hasta_PK ) 			lxImpdirimpAplicacion =  .Aplicacion			lxImpdirimpTipdesde =  upper( .f_TipoImp_Desde_PK ) 			lxImpdirimpTiphasta =  upper( .f_TipoImp_Hasta_PK ) 			lxImpdirimpJurdesde =  upper( .f_Jurisdiccion_Desde_PK ) 			lxImpdirimpJurhasta =  upper( .f_Jurisdiccion_Hasta_PK ) 			lxImpdirimpSucdesde =  upper( .f_Sucursal_Desde_PK ) 			lxImpdirimpSuchasta =  upper( .f_Sucursal_Hasta_PK ) 			lxImpdirimpTsucdesde =  upper( .f_TipoSucursal_Desde_PK ) 			lxImpdirimpTsuchasta =  upper( .f_TipoSucursal_Hasta_PK ) 			lxImpdirimpBase =  .Basededatos			lxImpdirimpPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirimpImportanci =  .Importancia			lxImpdirimpTipoasi =  .Tipodeasiento
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  IMPDIRIMP.NUMERO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.IMPDIRIMP set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpdirimpFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxImpdirimpFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpdirimpFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpdirimpFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxImpdirimpFaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpdirimpHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxImpdirimpHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpdirimpHoraimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxImpdirimpSaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirimpVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpdirimpZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxImpdirimpValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpdirimpUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxImpdirimpUmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxImpdirimpEsttrans ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxImpdirimpSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirimpHmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpdirimpBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirimpBdmodifw ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxImpdirimpObs ) + "'">>, "Numero" = <<lxImpdirimpNumero>>, "Descripcio" = <<"'" + this.FormatearTextoSql( lxImpdirimpDescripcio ) + "'">>, "Impdesde" = <<"'" + this.FormatearTextoSql( lxImpdirimpImpdesde ) + "'">>, "Imphasta" = <<"'" + this.FormatearTextoSql( lxImpdirimpImphasta ) + "'">>, "Aplicacion" = <<"'" + this.FormatearTextoSql( lxImpdirimpAplicacion ) + "'">>, "Tipdesde" = <<"'" + this.FormatearTextoSql( lxImpdirimpTipdesde ) + "'">>, "Tiphasta" = <<"'" + this.FormatearTextoSql( lxImpdirimpTiphasta ) + "'">>, "Jurdesde" = <<"'" + this.FormatearTextoSql( lxImpdirimpJurdesde ) + "'">>, "Jurhasta" = <<"'" + this.FormatearTextoSql( lxImpdirimpJurhasta ) + "'">>, "Sucdesde" = <<"'" + this.FormatearTextoSql( lxImpdirimpSucdesde ) + "'">>, "Suchasta" = <<"'" + this.FormatearTextoSql( lxImpdirimpSuchasta ) + "'">>, "Tsucdesde" = <<"'" + this.FormatearTextoSql( lxImpdirimpTsucdesde ) + "'">>, "Tsuchasta" = <<"'" + this.FormatearTextoSql( lxImpdirimpTsuchasta ) + "'">>, "Base" = <<"'" + this.FormatearTextoSql( lxImpdirimpBase ) + "'">>, "Pcuenta" = <<"'" + this.FormatearTextoSql( lxImpdirimpPcuenta ) + "'">>, "Importanci" = <<lxImpdirimpImportanci>>, "Tipoasi" = <<lxImpdirimpTipoasi>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'IMPDIRIMP' 
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

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  IMPDIRIMP.NUMERO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.IMPDIRIMP where ' + lcFiltro )
			loColeccion.cTabla = 'IMPDIRIMP' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.IMPDIRIMP where  IMPDIRIMP.NUMERO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.IMPDIRIMP where NUMERO = " + transform( this.oEntidad.NUMERO )+ " and  IMPDIRIMP.NUMERO != 0" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRIMP'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.IMPDIRIMP Where NUMERO = ] + transform( &lcCursor..NUMERO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.IMPDIRIMP set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, OBS = ] + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'"+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, Descripcio = ] + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'"+ [, ImpDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ImpDesde ) + "'"+ [, ImpHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ImpHasta ) + "'"+ [, Aplicacion = ] + "'" + this.FormatearTextoSql( &lcCursor..Aplicacion ) + "'"+ [, TipDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TipDesde ) + "'"+ [, TipHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TipHasta ) + "'"+ [, JurDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..JurDesde ) + "'"+ [, JurHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..JurHasta ) + "'"+ [, SucDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..SucDesde ) + "'"+ [, SucHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..SucHasta ) + "'"+ [, TSucDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TSucDesde ) + "'"+ [, TSucHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TSucHasta ) + "'"+ [, Base = ] + "'" + this.FormatearTextoSql( &lcCursor..Base ) + "'"+ [, PCUENTA = ] + "'" + this.FormatearTextoSql( &lcCursor..PCUENTA ) + "'"+ [, Importanci = ] + transform( &lcCursor..Importanci )+ [, TipoAsi = ] + transform( &lcCursor..TipoAsi ) + [ Where NUMERO = ] + transform( &lcCursor..NUMERO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FMODIFW, FECTRANS, FECIMPO, FECEXPO, FALTAFW, HORAEXPO, HALTAFW, HORAIMPO, SALTAFW, VMODIFW, ZADSFW, VALTAFW, UALTAFW, UMODIFW, ESTTRANS, SMODIFW, HMODIFW, BDALTAFW, BDMODIFW, OBS, NUMERO, Descripcio, ImpDesde, ImpHasta, Aplicacion, TipDesde, TipHasta, JurDesde, JurHasta, SucDesde, SucHasta, TSucDesde, TSucHasta, Base, PCUENTA, Importanci, TipoAsi
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'" + ',' + transform( &lcCursor..NUMERO )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ImpDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ImpHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Aplicacion ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..JurDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..JurHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SucDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SucHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TSucDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TSucHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Base ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PCUENTA ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Importanci ) + ',' + transform( &lcCursor..TipoAsi )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.IMPDIRIMP ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRIMP'
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
			Case  lcAlias == lcPrefijo + 'IMPDIRIMP'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPDIRIMP_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPDIRIMP_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_IMPDIRIMP')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'IMPDIRIMP'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..NUMERO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad IMPDIRIMP. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRIMP'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRIMP'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IMPDIRIMP') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IMPDIRIMP
Create Table ZooLogic.TablaTrabajo_IMPDIRIMP ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"esttrans" char( 20 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"obs" varchar(max)  null, 
"numero" numeric( 8, 0 )  null, 
"descripcio" char( 50 )  null, 
"impdesde" char( 10 )  null, 
"imphasta" char( 10 )  null, 
"aplicacion" char( 10 )  null, 
"tipdesde" char( 10 )  null, 
"tiphasta" char( 10 )  null, 
"jurdesde" char( 8 )  null, 
"jurhasta" char( 8 )  null, 
"sucdesde" char( 10 )  null, 
"suchasta" char( 10 )  null, 
"tsucdesde" char( 10 )  null, 
"tsuchasta" char( 10 )  null, 
"base" char( 21 )  null, 
"pcuenta" char( 30 )  null, 
"importanci" numeric( 5, 0 )  null, 
"tipoasi" numeric( 1, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_IMPDIRIMP' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_IMPDIRIMP' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRIMP'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('descripcio','descripcio')
			.AgregarMapeo('impdesde','impdesde')
			.AgregarMapeo('imphasta','imphasta')
			.AgregarMapeo('aplicacion','aplicacion')
			.AgregarMapeo('tipdesde','tipdesde')
			.AgregarMapeo('tiphasta','tiphasta')
			.AgregarMapeo('jurdesde','jurdesde')
			.AgregarMapeo('jurhasta','jurhasta')
			.AgregarMapeo('sucdesde','sucdesde')
			.AgregarMapeo('suchasta','suchasta')
			.AgregarMapeo('tsucdesde','tsucdesde')
			.AgregarMapeo('tsuchasta','tsuchasta')
			.AgregarMapeo('base','base')
			.AgregarMapeo('pcuenta','pcuenta')
			.AgregarMapeo('importanci','importanci')
			.AgregarMapeo('tipoasi','tipoasi')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_IMPDIRIMP'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.OBS = isnull( d.OBS, t.OBS ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.DESCRIPCIO = isnull( d.DESCRIPCIO, t.DESCRIPCIO ),t.IMPDESDE = isnull( d.IMPDESDE, t.IMPDESDE ),t.IMPHASTA = isnull( d.IMPHASTA, t.IMPHASTA ),t.APLICACION = isnull( d.APLICACION, t.APLICACION ),t.TIPDESDE = isnull( d.TIPDESDE, t.TIPDESDE ),t.TIPHASTA = isnull( d.TIPHASTA, t.TIPHASTA ),t.JURDESDE = isnull( d.JURDESDE, t.JURDESDE ),t.JURHASTA = isnull( d.JURHASTA, t.JURHASTA ),t.SUCDESDE = isnull( d.SUCDESDE, t.SUCDESDE ),t.SUCHASTA = isnull( d.SUCHASTA, t.SUCHASTA ),t.TSUCDESDE = isnull( d.TSUCDESDE, t.TSUCDESDE ),t.TSUCHASTA = isnull( d.TSUCHASTA, t.TSUCHASTA ),t.BASE = isnull( d.BASE, t.BASE ),t.PCUENTA = isnull( d.PCUENTA, t.PCUENTA ),t.IMPORTANCI = isnull( d.IMPORTANCI, t.IMPORTANCI ),t.TIPOASI = isnull( d.TIPOASI, t.TIPOASI )
					from ZooLogic.IMPDIRIMP t inner join deleted d 
							 on t.NUMERO = d.NUMERO
				-- Fin Updates
				insert into ZooLogic.IMPDIRIMP(Fmodifw,Fectrans,Fecimpo,Fecexpo,Faltafw,Horaexpo,Haltafw,Horaimpo,Saltafw,Vmodifw,Zadsfw,Valtafw,Ualtafw,Umodifw,Esttrans,Smodifw,Hmodifw,Bdaltafw,Bdmodifw,Obs,Numero,Descripcio,Impdesde,Imphasta,Aplicacion,Tipdesde,Tiphasta,Jurdesde,Jurhasta,Sucdesde,Suchasta,Tsucdesde,Tsuchasta,Base,Pcuenta,Importanci,Tipoasi)
					Select isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.SALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.OBS,''),isnull( d.NUMERO,0),isnull( d.DESCRIPCIO,''),isnull( d.IMPDESDE,''),isnull( d.IMPHASTA,''),isnull( d.APLICACION,''),isnull( d.TIPDESDE,''),isnull( d.TIPHASTA,''),isnull( d.JURDESDE,''),isnull( d.JURHASTA,''),isnull( d.SUCDESDE,''),isnull( d.SUCHASTA,''),isnull( d.TSUCDESDE,''),isnull( d.TSUCHASTA,''),isnull( d.BASE,''),isnull( d.PCUENTA,''),isnull( d.IMPORTANCI,0),isnull( d.TIPOASI,0)
						From deleted d left join ZooLogic.IMPDIRIMP pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IMPDIRIMP') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IMPDIRIMP
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_IMPDIRIMP' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRIMP.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRIMP.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRIMP.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRIMP.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRIMP.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_IMPDIRIMP.Horaexpo, [] )
					.Horaaltafw = nvl( c_IMPDIRIMP.Horaaltafw, [] )
					.Horaimpo = nvl( c_IMPDIRIMP.Horaimpo, [] )
					.Seriealtafw = nvl( c_IMPDIRIMP.Seriealtafw, [] )
					.Versionmodificacionfw = nvl( c_IMPDIRIMP.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_IMPDIRIMP.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_IMPDIRIMP.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_IMPDIRIMP.Usuariomodificacionfw, [] )
					.Estadotransferencia = nvl( c_IMPDIRIMP.Estadotransferencia, [] )
					.Seriemodificacionfw = nvl( c_IMPDIRIMP.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_IMPDIRIMP.Horamodificacionfw, [] )
					.Basededatosaltafw = nvl( c_IMPDIRIMP.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_IMPDIRIMP.Basededatosmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Numero = nvl( c_IMPDIRIMP.Numero, 0 )
					.Descripcion = nvl( c_IMPDIRIMP.Descripcion, [] )
					.F_impuesto_desde_PK =  nvl( c_IMPDIRIMP.F_impuesto_desde, [] )
					.F_impuesto_hasta_PK =  nvl( c_IMPDIRIMP.F_impuesto_hasta, [] )
					.Aplicacion = nvl( c_IMPDIRIMP.Aplicacion, [] )
					.F_tipoimp_desde_PK =  nvl( c_IMPDIRIMP.F_tipoimp_desde, [] )
					.F_tipoimp_hasta_PK =  nvl( c_IMPDIRIMP.F_tipoimp_hasta, [] )
					.F_jurisdiccion_desde_PK =  nvl( c_IMPDIRIMP.F_jurisdiccion_desde, [] )
					.F_jurisdiccion_hasta_PK =  nvl( c_IMPDIRIMP.F_jurisdiccion_hasta, [] )
					.F_sucursal_desde_PK =  nvl( c_IMPDIRIMP.F_sucursal_desde, [] )
					.F_sucursal_hasta_PK =  nvl( c_IMPDIRIMP.F_sucursal_hasta, [] )
					.F_tiposucursal_desde_PK =  nvl( c_IMPDIRIMP.F_tiposucursal_desde, [] )
					.F_tiposucursal_hasta_PK =  nvl( c_IMPDIRIMP.F_tiposucursal_hasta, [] )
					.Basededatos = nvl( c_IMPDIRIMP.Basededatos, [] )
					.Plandecuentas_PK =  nvl( c_IMPDIRIMP.Plandecuentas, [] )
					.Importancia = nvl( c_IMPDIRIMP.Importancia, 0 )
					.Tipodeasiento = nvl( c_IMPDIRIMP.Tipodeasiento, 0 )
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
		return c_IMPDIRIMP.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.IMPDIRIMP' )
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
								from ZooLogic.IMPDIRIMP 
								Where   IMPDIRIMP.NUMERO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "IMPDIRIMP", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Observacion", "Numero" as "Numero", "Descripcio" as "Descripcion", "Impdesde" as "F_impuesto_desde", "Imphasta" as "F_impuesto_hasta", "Aplicacion" as "Aplicacion", "Tipdesde" as "F_tipoimp_desde", "Tiphasta" as "F_tipoimp_hasta", "Jurdesde" as "F_jurisdiccion_desde", "Jurhasta" as "F_jurisdiccion_hasta", "Sucdesde" as "F_sucursal_desde", "Suchasta" as "F_sucursal_hasta", "Tsucdesde" as "F_tiposucursal_desde", "Tsuchasta" as "F_tiposucursal_hasta", "Base" as "Basededatos", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Tipoasi" as "Tipodeasiento"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.IMPDIRIMP 
								Where   IMPDIRIMP.NUMERO != 0
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
	Tabla = 'IMPDIRIMP'
	Filtro = " IMPDIRIMP.NUMERO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " IMPDIRIMP.NUMERO != 0"
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
	<row entidad="IMPDIRIMP                               " atributo="FECHAMODIFICACIONFW                     " tabla="IMPDIRIMP      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                                                                                                                        " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="FECHATRANSFERENCIA                      " tabla="IMPDIRIMP      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="FECHAIMPO                               " tabla="IMPDIRIMP      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="FECHAEXPO                               " tabla="IMPDIRIMP      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="FECHAALTAFW                             " tabla="IMPDIRIMP      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="HORAEXPO                                " tabla="IMPDIRIMP      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="HORAALTAFW                              " tabla="IMPDIRIMP      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="HORAIMPO                                " tabla="IMPDIRIMP      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="SERIEALTAFW                             " tabla="IMPDIRIMP      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="VERSIONMODIFICACIONFW                   " tabla="IMPDIRIMP      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="ZADSFW                                  " tabla="IMPDIRIMP      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="VERSIONALTAFW                           " tabla="IMPDIRIMP      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="USUARIOALTAFW                           " tabla="IMPDIRIMP      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="USUARIOMODIFICACIONFW                   " tabla="IMPDIRIMP      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="ESTADOTRANSFERENCIA                     " tabla="IMPDIRIMP      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="SERIEMODIFICACIONFW                     " tabla="IMPDIRIMP      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="HORAMODIFICACIONFW                      " tabla="IMPDIRIMP      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="BASEDEDATOSALTAFW                       " tabla="IMPDIRIMP      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="IMPDIRIMP      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="OBSERVACION                             " tabla="IMPDIRIMP      " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                                                                                                             " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="NUMERO                                  " tabla="IMPDIRIMP      " campo="NUMERO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Número                                                                                                                                                                                                                                                    " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="DESCRIPCION                             " tabla="IMPDIRIMP      " campo="DESCRIPCIO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                                                                                                               " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="F_IMPUESTO_DESDE                        " tabla="IMPDIRIMP      " campo="IMPDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="IMPUESTO                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Impuesto desde                                                                                                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="F_IMPUESTO_HASTA                        " tabla="IMPDIRIMP      " campo="IMPHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="IMPUESTO                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="404" etiqueta="Impuesto hasta                                                                                                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="APLICACION                              " tabla="IMPDIRIMP      " campo="APLICACION" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Aplicación desde                                                                                                                                                                                                                                          " dominio="COMBOXMLIMPUESTOCONTODOS      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="F_TIPOIMP_DESDE                         " tabla="IMPDIRIMP      " campo="TIPDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOIMPUESTO                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Tipo desde                                                                                                                                                                                                                                                " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="F_TIPOIMP_HASTA                         " tabla="IMPDIRIMP      " campo="TIPHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOIMPUESTO                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="410" etiqueta="Tipo hasta                                                                                                                                                                                                                                                " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="F_JURISDICCION_DESDE                    " tabla="IMPDIRIMP      " campo="JURDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="JURISDICCION                            " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Jurisdicción hasta                                                                                                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="F_JURISDICCION_HASTA                    " tabla="IMPDIRIMP      " campo="JURHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="JURISDICCION                            " tipodato="C         " longitud="8" decimales="0" valorsugerido="ZZZZZZZZ                                                                                                                                                                                                                                                      " obligatorio="false" admitebusqueda="414" etiqueta="Jurisdicción desde                                                                                                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="F_SUCURSAL_DESDE                        " tabla="IMPDIRIMP      " campo="SUCDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SUCURSAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Sucursal desde                                                                                                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="F_SUCURSAL_HASTA                        " tabla="IMPDIRIMP      " campo="SUCHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SUCURSAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="418" etiqueta="Sucursal hasta                                                                                                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="F_TIPOSUCURSAL_DESDE                    " tabla="IMPDIRIMP      " campo="TSUCDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOSUCURSAL                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Tipo sucursal desde                                                                                                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="F_TIPOSUCURSAL_HASTA                    " tabla="IMPDIRIMP      " campo="TSUCHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOSUCURSAL                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="422" etiqueta="Tipo sucursal hasta                                                                                                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="BASEDEDATOS                             " tabla="IMPDIRIMP      " campo="BASE      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="21" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Base                                                                                                                                                                                                                                                      " dominio="COMBOSUCYAGRUCONVACIO         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="9" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="PLANDECUENTAS                           " tabla="IMPDIRIMP      " campo="PCUENTA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PLANDECUENTAS                           " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="426" etiqueta="Cuenta                                                                                                                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot; plancuenta.CTAIMPUT = .t. &quot;                                                                                                                                                                           " grupo="0" subgrupo="1" orden="46" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="IMPORTANCIA                             " tabla="IMPDIRIMP      " campo="IMPORTANCI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Importancia                                                                                                                                                                                                                                               " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="47" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRIMP                               " atributo="TIPODEASIENTO                           " tabla="IMPDIRIMP      " campo="TIPOASI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="0                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="6" etiqueta="Imputación por tipo de asiento                                                                                                                                                                                                                            " dominio="COMBOTIPODEASIENTO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="DESCRIPCION                             " tabla="IMPUESTO       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="403" etiqueta="Detalle Imp.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join IMPUESTO On IMPDIRIMP.IMPDESDE = IMPUESTO.codigo And  IMPUESTO.CODIGO != ''                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="DESCRIPCION                             " tabla="IMPUESTO       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Imp.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join IMPUESTO On IMPDIRIMP.IMPHASTA = IMPUESTO.codigo And  IMPUESTO.CODIGO != ''                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOIMPUESTO                            " atributo="DESCRIPCION                             " tabla="TIPOIMP        " campo="DECRIP    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Tip.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOIMP On IMPDIRIMP.TIPDESDE = TIPOIMP.Codigo And  TIPOIMP.CODIGO != ''                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOIMPUESTO                            " atributo="DESCRIPCION                             " tabla="TIPOIMP        " campo="DECRIP    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Tip.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOIMP On IMPDIRIMP.TIPHASTA = TIPOIMP.Codigo And  TIPOIMP.CODIGO != ''                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="JURISDICCION                            " atributo="DESCRIPCION                             " tabla="JURISDIC       " campo="DESCRI    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Jur.                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join JURISDIC On IMPDIRIMP.JURDESDE = JURISDIC.codigo And  JURISDIC.CODIGO != ''                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="JURISDICCION                            " atributo="DESCRIPCION                             " tabla="JURISDIC       " campo="DESCRI    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="415" etiqueta="Detalle Jur.                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join JURISDIC On IMPDIRIMP.JURHASTA = JURISDIC.codigo And  JURISDIC.CODIGO != ''                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="DESCRIPCION                             " tabla="SUC            " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="417" etiqueta="Detalle Suc.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SUC On IMPDIRIMP.SUCDESDE = SUC.codigo And  SUC.CODIGO != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="DESCRIPCION                             " tabla="SUC            " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="419" etiqueta="Detalle Suc.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SUC On IMPDIRIMP.SUCHASTA = SUC.codigo And  SUC.CODIGO != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOSUCURSAL                            " atributo="DESCRIPCION                             " tabla="TSUCUR         " campo="TDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="421" etiqueta="Detalle Tip.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TSUCUR On IMPDIRIMP.TSUCDESDE = TSUCUR.TCOD And  TSUCUR.TCOD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOSUCURSAL                            " atributo="DESCRIPCION                             " tabla="TSUCUR         " campo="TDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="423" etiqueta="Detalle Tip.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TSUCUR On IMPDIRIMP.TSUCHASTA = TSUCUR.TCOD And  TSUCUR.TCOD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="DESCRIPCION                             " tabla="PLANCUENTA     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="427" etiqueta="Detalle Cue.                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PLANCUENTA On IMPDIRIMP.PCUENTA = PLANCUENTA.ctacodigo And  PLANCUENTA.CTACODIGO != ''                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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