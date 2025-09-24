
define class Din_EntidadTIDIFERENCIASDEINVENTARIODETALLEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_TIDIFERENCIASDEINVENTARIODETALLE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( Numero, 9, 0)]
	cExpresionCCPorCampos = [str( #tabla#.Numero, 9, 0)]
	cTagClaveCandidata = '_TIDCC'
	cTagClavePk = '_TIDPK'
	cTablaPrincipal = 'TIDIFINVDET'
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
			local  lxTidifinvdetFecimpo, lxTidifinvdetFectrans, lxTidifinvdetFmodifw, lxTidifinvdetFaltafw, lxTidifinvdetFecexpo, lxTidifinvdetHaltafw, lxTidifinvdetHoraexpo, lxTidifinvdetUmodifw, lxTidifinvdetHmodifw, lxTidifinvdetSmodifw, lxTidifinvdetSaltafw, lxTidifinvdetHoraimpo, lxTidifinvdetVmodifw, lxTidifinvdetValtafw, lxTidifinvdetBdaltafw, lxTidifinvdetZadsfw, lxTidifinvdetBdmodifw, lxTidifinvdetUaltafw, lxTidifinvdetEsttrans, lxTidifinvdetNumero, lxTidifinvdetRechazado, lxTidifinvdetCodigo, lxTidifinvdetArt, lxTidifinvdetCcolor, lxTidifinvdetTalle, lxTidifinvdetDiferencia, lxTidifinvdetIdcabecera, lxTidifinvdetObs, lxTidifinvdetTipo
				lxTidifinvdetFecimpo =  .Fechaimpo			lxTidifinvdetFectrans =  .Fechatransferencia			lxTidifinvdetFmodifw =  .Fechamodificacionfw			lxTidifinvdetFaltafw =  .Fechaaltafw			lxTidifinvdetFecexpo =  .Fechaexpo			lxTidifinvdetHaltafw =  .Horaaltafw			lxTidifinvdetHoraexpo =  .Horaexpo			lxTidifinvdetUmodifw =  .Usuariomodificacionfw			lxTidifinvdetHmodifw =  .Horamodificacionfw			lxTidifinvdetSmodifw =  .Seriemodificacionfw			lxTidifinvdetSaltafw =  .Seriealtafw			lxTidifinvdetHoraimpo =  .Horaimpo			lxTidifinvdetVmodifw =  .Versionmodificacionfw			lxTidifinvdetValtafw =  .Versionaltafw			lxTidifinvdetBdaltafw =  .Basededatosaltafw			lxTidifinvdetZadsfw =  .Zadsfw			lxTidifinvdetBdmodifw =  .Basededatosmodificacionfw			lxTidifinvdetUaltafw =  .Usuarioaltafw			lxTidifinvdetEsttrans =  .Estadotransferencia			lxTidifinvdetNumero =  .Numero			lxTidifinvdetRechazado =  .Rechazado			lxTidifinvdetCodigo =  .Codigo			lxTidifinvdetArt =  upper( .Articulo_PK ) 			lxTidifinvdetCcolor =  upper( .Color_PK ) 			lxTidifinvdetTalle =  upper( .Talle_PK ) 			lxTidifinvdetDiferencia =  .Diferencia			lxTidifinvdetIdcabecera =  .Idcabecera_PK 			lxTidifinvdetObs =  .Obs			lxTidifinvdetTipo =  .Tipo
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxTidifinvdetCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.TIDIFINVDET ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Haltafw","Horaexpo","Umodifw","Hmodifw","Smodifw","Saltafw","Horaimpo","Vmodifw","Valtafw","Bdaltafw","Zadsfw","Bdmodifw","Ualtafw","Esttrans","Numero","Rechazado","Codigo","Art","Ccolor","Talle","Diferencia","Idcabecera","Obs","Tipo" ) values ( <<"'" + this.ConvertirDateSql( lxTidifinvdetFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvdetFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvdetFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvdetFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvdetFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetEsttrans ) + "'" >>, <<lxTidifinvdetNumero >>, <<iif( lxTidifinvdetRechazado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetArt ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetCcolor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetTalle ) + "'" >>, <<lxTidifinvdetDiferencia >>, <<lxTidifinvdetIdcabecera >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetObs ) + "'" >>, <<lxTidifinvdetTipo >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
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
			local  lxTidifinvdetFecimpo, lxTidifinvdetFectrans, lxTidifinvdetFmodifw, lxTidifinvdetFaltafw, lxTidifinvdetFecexpo, lxTidifinvdetHaltafw, lxTidifinvdetHoraexpo, lxTidifinvdetUmodifw, lxTidifinvdetHmodifw, lxTidifinvdetSmodifw, lxTidifinvdetSaltafw, lxTidifinvdetHoraimpo, lxTidifinvdetVmodifw, lxTidifinvdetValtafw, lxTidifinvdetBdaltafw, lxTidifinvdetZadsfw, lxTidifinvdetBdmodifw, lxTidifinvdetUaltafw, lxTidifinvdetEsttrans, lxTidifinvdetNumero, lxTidifinvdetRechazado, lxTidifinvdetCodigo, lxTidifinvdetArt, lxTidifinvdetCcolor, lxTidifinvdetTalle, lxTidifinvdetDiferencia, lxTidifinvdetIdcabecera, lxTidifinvdetObs, lxTidifinvdetTipo
				lxTidifinvdetFecimpo =  .Fechaimpo			lxTidifinvdetFectrans =  .Fechatransferencia			lxTidifinvdetFmodifw =  .Fechamodificacionfw			lxTidifinvdetFaltafw =  .Fechaaltafw			lxTidifinvdetFecexpo =  .Fechaexpo			lxTidifinvdetHaltafw =  .Horaaltafw			lxTidifinvdetHoraexpo =  .Horaexpo			lxTidifinvdetUmodifw =  .Usuariomodificacionfw			lxTidifinvdetHmodifw =  .Horamodificacionfw			lxTidifinvdetSmodifw =  .Seriemodificacionfw			lxTidifinvdetSaltafw =  .Seriealtafw			lxTidifinvdetHoraimpo =  .Horaimpo			lxTidifinvdetVmodifw =  .Versionmodificacionfw			lxTidifinvdetValtafw =  .Versionaltafw			lxTidifinvdetBdaltafw =  .Basededatosaltafw			lxTidifinvdetZadsfw =  .Zadsfw			lxTidifinvdetBdmodifw =  .Basededatosmodificacionfw			lxTidifinvdetUaltafw =  .Usuarioaltafw			lxTidifinvdetEsttrans =  .Estadotransferencia			lxTidifinvdetNumero =  .Numero			lxTidifinvdetRechazado =  .Rechazado			lxTidifinvdetCodigo =  .Codigo			lxTidifinvdetArt =  upper( .Articulo_PK ) 			lxTidifinvdetCcolor =  upper( .Color_PK ) 			lxTidifinvdetTalle =  upper( .Talle_PK ) 			lxTidifinvdetDiferencia =  .Diferencia			lxTidifinvdetIdcabecera =  .Idcabecera_PK 			lxTidifinvdetObs =  .Obs			lxTidifinvdetTipo =  .Tipo
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.TIDIFINVDET set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxTidifinvdetFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxTidifinvdetFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxTidifinvdetFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxTidifinvdetFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxTidifinvdetFecexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxTidifinvdetHoraexpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetUmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxTidifinvdetHoraimpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetValtafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetBdaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetZadsfw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetBdmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetUaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxTidifinvdetEsttrans ) + "'">>,"Numero" = <<lxTidifinvdetNumero>>,"Rechazado" = <<iif( lxTidifinvdetRechazado, 1, 0 )>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxTidifinvdetCodigo ) + "'">>,"Art" = <<"'" + this.FormatearTextoSql( lxTidifinvdetArt ) + "'">>,"Ccolor" = <<"'" + this.FormatearTextoSql( lxTidifinvdetCcolor ) + "'">>,"Talle" = <<"'" + this.FormatearTextoSql( lxTidifinvdetTalle ) + "'">>,"Diferencia" = <<lxTidifinvdetDiferencia>>,"Idcabecera" = <<lxTidifinvdetIdcabecera>>,"Obs" = <<"'" + this.FormatearTextoSql( lxTidifinvdetObs ) + "'">>,"Tipo" = <<lxTidifinvdetTipo>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxTidifinvdetCodigo ) + "'">> and  TIDIFINVDET.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.TIDIFINVDET where " + this.ConvertirFuncionesSql( " TIDIFINVDET.CODIGO != ''" ) )
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
			Local lxTidifinvdetCodigo
			lxTidifinvdetCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Numero" as "Numero", "Rechazado" as "Rechazado", "Codigo" as "Codigo", "Art" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Diferencia" as "Diferencia", "Idcabecera" as "Idcabecera", "Obs" as "Obs", "Tipo" as "Tipo" from ZooLogic.TIDIFINVDET where "Codigo" = <<"'" + this.FormatearTextoSql( lxTidifinvdetCodigo ) + "'">> and  TIDIFINVDET.CODIGO != ''
			endtext
			use in select('c_TIDIFERENCIASDEINVENTARIODETALLE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIDIFERENCIASDEINVENTARIODETALLE', set( 'Datasession' ) )

			if reccount( 'c_TIDIFERENCIASDEINVENTARIODETALLE' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxTIDifInvDetNumero As Variant
			lxTIDifInvDetNumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Numero" as "Numero", "Rechazado" as "Rechazado", "Codigo" as "Codigo", "Art" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Diferencia" as "Diferencia", "Idcabecera" as "Idcabecera", "Obs" as "Obs", "Tipo" as "Tipo" from ZooLogic.TIDIFINVDET where  TIDIFINVDET.CODIGO != '' And Numero = <<lxTIDifInvDetNumero>>
			endtext
			use in select('c_TIDIFERENCIASDEINVENTARIODETALLE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIDIFERENCIASDEINVENTARIODETALLE', set( 'Datasession' ) )
			if reccount( 'c_TIDIFERENCIASDEINVENTARIODETALLE' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxTidifinvdetCodigo as Variant
		llRetorno = .t.
		lxTidifinvdetCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.TIDIFINVDET where "Codigo" = <<"'" + this.FormatearTextoSql( lxTidifinvdetCodigo ) + "'">> and  TIDIFINVDET.CODIGO != ''
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
				lcOrden =  str( .Numero, 9, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Numero" as "Numero", "Rechazado" as "Rechazado", "Codigo" as "Codigo", "Art" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Diferencia" as "Diferencia", "Idcabecera" as "Idcabecera", "Obs" as "Obs", "Tipo" as "Tipo" from ZooLogic.TIDIFINVDET where  TIDIFINVDET.CODIGO != '' order by Numero
			endtext
			use in select('c_TIDIFERENCIASDEINVENTARIODETALLE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIDIFERENCIASDEINVENTARIODETALLE', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 9, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Numero" as "Numero", "Rechazado" as "Rechazado", "Codigo" as "Codigo", "Art" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Diferencia" as "Diferencia", "Idcabecera" as "Idcabecera", "Obs" as "Obs", "Tipo" as "Tipo" from ZooLogic.TIDIFINVDET where  str( Numero, 9, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TIDIFINVDET.CODIGO != '' order by Numero
			endtext
			use in select('c_TIDIFERENCIASDEINVENTARIODETALLE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIDIFERENCIASDEINVENTARIODETALLE', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 9, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Numero" as "Numero", "Rechazado" as "Rechazado", "Codigo" as "Codigo", "Art" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Diferencia" as "Diferencia", "Idcabecera" as "Idcabecera", "Obs" as "Obs", "Tipo" as "Tipo" from ZooLogic.TIDIFINVDET where  str( Numero, 9, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TIDIFINVDET.CODIGO != '' order by Numero desc
			endtext
			use in select('c_TIDIFERENCIASDEINVENTARIODETALLE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIDIFERENCIASDEINVENTARIODETALLE', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 9, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Numero" as "Numero", "Rechazado" as "Rechazado", "Codigo" as "Codigo", "Art" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Diferencia" as "Diferencia", "Idcabecera" as "Idcabecera", "Obs" as "Obs", "Tipo" as "Tipo" from ZooLogic.TIDIFINVDET where  TIDIFINVDET.CODIGO != '' order by Numero desc
			endtext
			use in select('c_TIDIFERENCIASDEINVENTARIODETALLE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIDIFERENCIASDEINVENTARIODETALLE', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Haltafw,Horaexpo,Umodifw,Hmodifw,Smodifw,Saltafw,Ho" + ;
"raimpo,Vmodifw,Valtafw,Bdaltafw,Zadsfw,Bdmodifw,Ualtafw,Esttrans,Numero,Rechazado,Codigo,Art,Ccolor," + ;
"Talle,Diferencia,Idcabecera,Obs,Tipo" + ;
" from ZooLogic.TIDIFINVDET where  TIDIFINVDET.CODIGO != '' and " + lcFiltro )
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
			local  lxTidifinvdetFecimpo, lxTidifinvdetFectrans, lxTidifinvdetFmodifw, lxTidifinvdetFaltafw, lxTidifinvdetFecexpo, lxTidifinvdetHaltafw, lxTidifinvdetHoraexpo, lxTidifinvdetUmodifw, lxTidifinvdetHmodifw, lxTidifinvdetSmodifw, lxTidifinvdetSaltafw, lxTidifinvdetHoraimpo, lxTidifinvdetVmodifw, lxTidifinvdetValtafw, lxTidifinvdetBdaltafw, lxTidifinvdetZadsfw, lxTidifinvdetBdmodifw, lxTidifinvdetUaltafw, lxTidifinvdetEsttrans, lxTidifinvdetNumero, lxTidifinvdetRechazado, lxTidifinvdetCodigo, lxTidifinvdetArt, lxTidifinvdetCcolor, lxTidifinvdetTalle, lxTidifinvdetDiferencia, lxTidifinvdetIdcabecera, lxTidifinvdetObs, lxTidifinvdetTipo
				lxTidifinvdetFecimpo = ctod( '  /  /    ' )			lxTidifinvdetFectrans = ctod( '  /  /    ' )			lxTidifinvdetFmodifw = ctod( '  /  /    ' )			lxTidifinvdetFaltafw = ctod( '  /  /    ' )			lxTidifinvdetFecexpo = ctod( '  /  /    ' )			lxTidifinvdetHaltafw = []			lxTidifinvdetHoraexpo = []			lxTidifinvdetUmodifw = []			lxTidifinvdetHmodifw = []			lxTidifinvdetSmodifw = []			lxTidifinvdetSaltafw = []			lxTidifinvdetHoraimpo = []			lxTidifinvdetVmodifw = []			lxTidifinvdetValtafw = []			lxTidifinvdetBdaltafw = []			lxTidifinvdetZadsfw = []			lxTidifinvdetBdmodifw = []			lxTidifinvdetUaltafw = []			lxTidifinvdetEsttrans = []			lxTidifinvdetNumero = 0			lxTidifinvdetRechazado = .F.			lxTidifinvdetCodigo = []			lxTidifinvdetArt = []			lxTidifinvdetCcolor = []			lxTidifinvdetTalle = []			lxTidifinvdetDiferencia = 0			lxTidifinvdetIdcabecera = 0			lxTidifinvdetObs = []			lxTidifinvdetTipo = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.TIDIFINVDET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'TIDIFINVDET' + '_' + tcCampo
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
		lcWhere = " Where  TIDIFINVDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Numero" as "Numero", "Rechazado" as "Rechazado", "Codigo" as "Codigo", "Art" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Diferencia" as "Diferencia", "Idcabecera" as "Idcabecera", "Obs" as "Obs", "Tipo" as "Tipo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'TIDIFINVDET', '', tnTope )
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
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'RECHAZADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECHAZADO AS RECHAZADO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ART AS ARTICULO'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOLOR AS COLOR'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLE AS TALLE'
				Case lcAtributo == 'DIFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIFERENCIA AS DIFERENCIA'
				Case lcAtributo == 'IDCABECERA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCABECERA AS IDCABECERA'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPO'
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
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'RECHAZADO'
				lcCampo = 'RECHAZADO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'ART'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'TALLE'
			Case upper( alltrim( tcAtributo ) ) == 'DIFERENCIA'
				lcCampo = 'DIFERENCIA'
			Case upper( alltrim( tcAtributo ) ) == 'IDCABECERA'
				lcCampo = 'IDCABECERA'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPO'
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
			local  lxTidifinvdetFecimpo, lxTidifinvdetFectrans, lxTidifinvdetFmodifw, lxTidifinvdetFaltafw, lxTidifinvdetFecexpo, lxTidifinvdetHaltafw, lxTidifinvdetHoraexpo, lxTidifinvdetUmodifw, lxTidifinvdetHmodifw, lxTidifinvdetSmodifw, lxTidifinvdetSaltafw, lxTidifinvdetHoraimpo, lxTidifinvdetVmodifw, lxTidifinvdetValtafw, lxTidifinvdetBdaltafw, lxTidifinvdetZadsfw, lxTidifinvdetBdmodifw, lxTidifinvdetUaltafw, lxTidifinvdetEsttrans, lxTidifinvdetNumero, lxTidifinvdetRechazado, lxTidifinvdetCodigo, lxTidifinvdetArt, lxTidifinvdetCcolor, lxTidifinvdetTalle, lxTidifinvdetDiferencia, lxTidifinvdetIdcabecera, lxTidifinvdetObs, lxTidifinvdetTipo
				lxTidifinvdetFecimpo =  .Fechaimpo			lxTidifinvdetFectrans =  .Fechatransferencia			lxTidifinvdetFmodifw =  .Fechamodificacionfw			lxTidifinvdetFaltafw =  .Fechaaltafw			lxTidifinvdetFecexpo =  .Fechaexpo			lxTidifinvdetHaltafw =  .Horaaltafw			lxTidifinvdetHoraexpo =  .Horaexpo			lxTidifinvdetUmodifw =  .Usuariomodificacionfw			lxTidifinvdetHmodifw =  .Horamodificacionfw			lxTidifinvdetSmodifw =  .Seriemodificacionfw			lxTidifinvdetSaltafw =  .Seriealtafw			lxTidifinvdetHoraimpo =  .Horaimpo			lxTidifinvdetVmodifw =  .Versionmodificacionfw			lxTidifinvdetValtafw =  .Versionaltafw			lxTidifinvdetBdaltafw =  .Basededatosaltafw			lxTidifinvdetZadsfw =  .Zadsfw			lxTidifinvdetBdmodifw =  .Basededatosmodificacionfw			lxTidifinvdetUaltafw =  .Usuarioaltafw			lxTidifinvdetEsttrans =  .Estadotransferencia			lxTidifinvdetNumero =  .Numero			lxTidifinvdetRechazado =  .Rechazado			lxTidifinvdetCodigo =  .Codigo			lxTidifinvdetArt =  upper( .Articulo_PK ) 			lxTidifinvdetCcolor =  upper( .Color_PK ) 			lxTidifinvdetTalle =  upper( .Talle_PK ) 			lxTidifinvdetDiferencia =  .Diferencia			lxTidifinvdetIdcabecera =  .Idcabecera_PK 			lxTidifinvdetObs =  .Obs			lxTidifinvdetTipo =  .Tipo
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.TIDIFINVDET ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Haltafw","Horaexpo","Umodifw","Hmodifw","Smodifw","Saltafw","Horaimpo","Vmodifw","Valtafw","Bdaltafw","Zadsfw","Bdmodifw","Ualtafw","Esttrans","Numero","Rechazado","Codigo","Art","Ccolor","Talle","Diferencia","Idcabecera","Obs","Tipo" ) values ( <<"'" + this.ConvertirDateSql( lxTidifinvdetFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvdetFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvdetFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvdetFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvdetFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetEsttrans ) + "'" >>, <<lxTidifinvdetNumero >>, <<iif( lxTidifinvdetRechazado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetArt ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetCcolor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetTalle ) + "'" >>, <<lxTidifinvdetDiferencia >>, <<lxTidifinvdetIdcabecera >>, <<"'" + this.FormatearTextoSql( lxTidifinvdetObs ) + "'" >>, <<lxTidifinvdetTipo >> )
		endtext
		loColeccion.cTabla = 'TIDIFINVDET' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxTidifinvdetFecimpo, lxTidifinvdetFectrans, lxTidifinvdetFmodifw, lxTidifinvdetFaltafw, lxTidifinvdetFecexpo, lxTidifinvdetHaltafw, lxTidifinvdetHoraexpo, lxTidifinvdetUmodifw, lxTidifinvdetHmodifw, lxTidifinvdetSmodifw, lxTidifinvdetSaltafw, lxTidifinvdetHoraimpo, lxTidifinvdetVmodifw, lxTidifinvdetValtafw, lxTidifinvdetBdaltafw, lxTidifinvdetZadsfw, lxTidifinvdetBdmodifw, lxTidifinvdetUaltafw, lxTidifinvdetEsttrans, lxTidifinvdetNumero, lxTidifinvdetRechazado, lxTidifinvdetCodigo, lxTidifinvdetArt, lxTidifinvdetCcolor, lxTidifinvdetTalle, lxTidifinvdetDiferencia, lxTidifinvdetIdcabecera, lxTidifinvdetObs, lxTidifinvdetTipo
				lxTidifinvdetFecimpo =  .Fechaimpo			lxTidifinvdetFectrans =  .Fechatransferencia			lxTidifinvdetFmodifw =  .Fechamodificacionfw			lxTidifinvdetFaltafw =  .Fechaaltafw			lxTidifinvdetFecexpo =  .Fechaexpo			lxTidifinvdetHaltafw =  .Horaaltafw			lxTidifinvdetHoraexpo =  .Horaexpo			lxTidifinvdetUmodifw =  .Usuariomodificacionfw			lxTidifinvdetHmodifw =  .Horamodificacionfw			lxTidifinvdetSmodifw =  .Seriemodificacionfw			lxTidifinvdetSaltafw =  .Seriealtafw			lxTidifinvdetHoraimpo =  .Horaimpo			lxTidifinvdetVmodifw =  .Versionmodificacionfw			lxTidifinvdetValtafw =  .Versionaltafw			lxTidifinvdetBdaltafw =  .Basededatosaltafw			lxTidifinvdetZadsfw =  .Zadsfw			lxTidifinvdetBdmodifw =  .Basededatosmodificacionfw			lxTidifinvdetUaltafw =  .Usuarioaltafw			lxTidifinvdetEsttrans =  .Estadotransferencia			lxTidifinvdetNumero =  .Numero			lxTidifinvdetRechazado =  .Rechazado			lxTidifinvdetCodigo =  .Codigo			lxTidifinvdetArt =  upper( .Articulo_PK ) 			lxTidifinvdetCcolor =  upper( .Color_PK ) 			lxTidifinvdetTalle =  upper( .Talle_PK ) 			lxTidifinvdetDiferencia =  .Diferencia			lxTidifinvdetIdcabecera =  .Idcabecera_PK 			lxTidifinvdetObs =  .Obs			lxTidifinvdetTipo =  .Tipo
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  TIDIFINVDET.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.TIDIFINVDET set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxTidifinvdetFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxTidifinvdetFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxTidifinvdetFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxTidifinvdetFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxTidifinvdetFecexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxTidifinvdetHoraexpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetUmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxTidifinvdetHoraimpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetValtafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetBdaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetZadsfw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetBdmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxTidifinvdetUaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxTidifinvdetEsttrans ) + "'">>, "Numero" = <<lxTidifinvdetNumero>>, "Rechazado" = <<iif( lxTidifinvdetRechazado, 1, 0 )>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxTidifinvdetCodigo ) + "'">>, "Art" = <<"'" + this.FormatearTextoSql( lxTidifinvdetArt ) + "'">>, "Ccolor" = <<"'" + this.FormatearTextoSql( lxTidifinvdetCcolor ) + "'">>, "Talle" = <<"'" + this.FormatearTextoSql( lxTidifinvdetTalle ) + "'">>, "Diferencia" = <<lxTidifinvdetDiferencia>>, "Idcabecera" = <<lxTidifinvdetIdcabecera>>, "Obs" = <<"'" + this.FormatearTextoSql( lxTidifinvdetObs ) + "'">>, "Tipo" = <<lxTidifinvdetTipo>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'TIDIFINVDET' 
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
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  TIDIFINVDET.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.TIDIFINVDET where ' + lcFiltro )
			loColeccion.cTabla = 'TIDIFINVDET' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.TIDIFINVDET where  TIDIFINVDET.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.TIDIFINVDET where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  TIDIFINVDET.CODIGO != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxTIDifInvDetNumero as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TIDIFERENCIASDEINVENTARIODETALLE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.TIDIFINVDET Where  Numero = ] + transform( &lcCursor..Numero     ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..CODIGO
				if lxValorClavePK == curSeek.CODIGO or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.CODIGO and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.CODIGO
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.TIDIFINVDET set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, Rechazado = ] + Transform( iif( &lcCursor..Rechazado, 1, 0 ))+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, ART = ] + "'" + this.FormatearTextoSql( &lcCursor..ART ) + "'"+ [, cColor = ] + "'" + this.FormatearTextoSql( &lcCursor..cColor ) + "'"+ [, Talle = ] + "'" + this.FormatearTextoSql( &lcCursor..Talle ) + "'"+ [, DIFERENCIA = ] + transform( &lcCursor..DIFERENCIA )+ [, IDCABECERA = ] + transform( &lcCursor..IDCABECERA )+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, TIPO = ] + transform( &lcCursor..TIPO ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.TIDIFINVDET Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECIMPO, FECTRANS, FMODIFW, FALTAFW, FECEXPO, HALTAFW, HORAEXPO, UMODIFW, HMODIFW, SMODIFW, SALTAFW, HORAIMPO, VMODIFW, VALTAFW, BDALTAFW, ZADSFW, BDMODIFW, UALTAFW, ESTTRANS, Numero, Rechazado, CODIGO, ART, cColor, Talle, DIFERENCIA, IDCABECERA, Obs, TIPO
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + transform( &lcCursor..Numero ) + ',' + Transform( iif( &lcCursor..Rechazado, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ART ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cColor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Talle ) + "'" + ',' + transform( &lcCursor..DIFERENCIA ) + ',' + transform( &lcCursor..IDCABECERA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + transform( &lcCursor..TIPO )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.TIDIFINVDET ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TIDIFERENCIASDEINVENTARIODETALLE'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO C (38) , Orden N(16), texto C(80))
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
			Case  lcAlias == lcPrefijo + 'TIDIFERENCIASDEINVENTARIODETALLE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'TIDIFERENCIASDEINVENTARIODETALLE_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_TIDifInvDet')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'TIDIFERENCIASDEINVENTARIODETALLE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Numero )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad TIDIFERENCIASDEINVENTARIODETALLE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIDIFERENCIASDEINVENTARIODETALLE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( Numero, 9, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( Numero, 9, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIDIFERENCIASDEINVENTARIODETALLE'
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TIDifInvDet') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TIDifInvDet
Create Table ZooLogic.TablaTrabajo_TIDifInvDet ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"bdaltafw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"bdmodifw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"esttrans" char( 20 )  null, 
"numero" numeric( 9, 0 )  null, 
"rechazado" bit  null, 
"codigo" char( 38 )  null, 
"art" char( 15 )  null, 
"ccolor" char( 6 )  null, 
"talle" char( 5 )  null, 
"diferencia" numeric( 15, 2 )  null, 
"idcabecera" numeric( 8, 0 )  null, 
"obs" char( 20 )  null, 
"tipo" numeric( 1, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_TIDifInvDet' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_TIDifInvDet' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIDIFERENCIASDEINVENTARIODETALLE'
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
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('rechazado','rechazado')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('art','art')
			.AgregarMapeo('ccolor','ccolor')
			.AgregarMapeo('talle','talle')
			.AgregarMapeo('diferencia','diferencia')
			.AgregarMapeo('idcabecera','idcabecera')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('tipo','tipo')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_TIDifInvDet'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.RECHAZADO = isnull( d.RECHAZADO, t.RECHAZADO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.ART = isnull( d.ART, t.ART ),t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),t.TALLE = isnull( d.TALLE, t.TALLE ),t.DIFERENCIA = isnull( d.DIFERENCIA, t.DIFERENCIA ),t.IDCABECERA = isnull( d.IDCABECERA, t.IDCABECERA ),t.OBS = isnull( d.OBS, t.OBS ),t.TIPO = isnull( d.TIPO, t.TIPO )
					from ZooLogic.TIDIFINVDET t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.Numero = d.Numero
				-- Fin Updates
				insert into ZooLogic.TIDIFINVDET(Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Haltafw,Horaexpo,Umodifw,Hmodifw,Smodifw,Saltafw,Horaimpo,Vmodifw,Valtafw,Bdaltafw,Zadsfw,Bdmodifw,Ualtafw,Esttrans,Numero,Rechazado,Codigo,Art,Ccolor,Talle,Diferencia,Idcabecera,Obs,Tipo)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.UMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.BDALTAFW,''),isnull( d.ZADSFW,''),isnull( d.BDMODIFW,''),isnull( d.UALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.NUMERO,0),isnull( d.RECHAZADO,0),isnull( d.CODIGO,''),isnull( d.ART,''),isnull( d.CCOLOR,''),isnull( d.TALLE,''),isnull( d.DIFERENCIA,0),isnull( d.IDCABECERA,0),isnull( d.OBS,''),isnull( d.TIPO,0)
						From deleted d left join ZooLogic.TIDIFINVDET pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.TIDIFINVDET cc 
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.Numero as Varchar(9) ) + '','La clave principal no es la esperada'
					from ZooLogic.TIDIFINVDET t inner join deleted d 
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.Numero as Varchar(9) ) + '','La clave principal a importar ya existe'
					from ZooLogic.TIDIFINVDET t inner join deleted d 
							 on t.CODIGO = d.CODIGO
						left join deleted h 
							on   t.Numero = h.Numero
							where   h.Numero is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TIDifInvDet') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TIDifInvDet
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_TIDIFERENCIASDEINVENTARIODETALLE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Horaaltafw, [] )
					.Horaexpo = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Horaexpo, [] )
					.Usuariomodificacionfw = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Usuariomodificacionfw, [] )
					.Horamodificacionfw = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Seriealtafw, [] )
					.Horaimpo = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Horaimpo, [] )
					.Versionmodificacionfw = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Versionaltafw, [] )
					.Basededatosaltafw = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Basededatosaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Basededatosmodificacionfw = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Basededatosmodificacionfw, [] )
					.Usuarioaltafw = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Usuarioaltafw, [] )
					.Estadotransferencia = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Estadotransferencia, [] )
					.Numero = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Numero, 0 )
					.Rechazado = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Rechazado, .F. )
					.Codigo = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Codigo, [] )
					.Articulo_PK =  nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Articulo, [] )
					.Color_PK =  nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Color, [] )
					.Talle_PK =  nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Talle, [] )
					.Diferencia = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Diferencia, 0 )
					.Idcabecera_PK =  nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Idcabecera, 0 )
					.Obs = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Obs, [] )
					.Tipo = nvl( c_TIDIFERENCIASDEINVENTARIODETALLE.Tipo, 0 )
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
			lxRetorno = c_TIDIFERENCIASDEINVENTARIODETALLE.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_TIDIFERENCIASDEINVENTARIODETALLE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.TIDIFINVDET' )
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
								from ZooLogic.TIDIFINVDET 
								Where   TIDIFINVDET.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "TIDIFINVDET", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Numero" as "Numero", "Rechazado" as "Rechazado", "Codigo" as "Codigo", "Art" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Diferencia" as "Diferencia", "Idcabecera" as "Idcabecera", "Obs" as "Obs", "Tipo" as "Tipo"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.TIDIFINVDET 
								Where   TIDIFINVDET.CODIGO != ''
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
	Tabla = 'TIDIFINVDET'
	Filtro = " TIDIFINVDET.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " TIDIFINVDET.CODIGO != ''"
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
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="FECHAIMPO                               " tabla="TIDIFINVDET    " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="FECHATRANSFERENCIA                      " tabla="TIDIFINVDET    " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="FECHAMODIFICACIONFW                     " tabla="TIDIFINVDET    " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="FECHAALTAFW                             " tabla="TIDIFINVDET    " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="FECHAEXPO                               " tabla="TIDIFINVDET    " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="HORAALTAFW                              " tabla="TIDIFINVDET    " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="HORAEXPO                                " tabla="TIDIFINVDET    " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="USUARIOMODIFICACIONFW                   " tabla="TIDIFINVDET    " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="HORAMODIFICACIONFW                      " tabla="TIDIFINVDET    " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="SERIEMODIFICACIONFW                     " tabla="TIDIFINVDET    " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="SERIEALTAFW                             " tabla="TIDIFINVDET    " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="HORAIMPO                                " tabla="TIDIFINVDET    " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="VERSIONMODIFICACIONFW                   " tabla="TIDIFINVDET    " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="VERSIONALTAFW                           " tabla="TIDIFINVDET    " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="BASEDEDATOSALTAFW                       " tabla="TIDIFINVDET    " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="ZADSFW                                  " tabla="TIDIFINVDET    " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="TIDIFINVDET    " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="USUARIOALTAFW                           " tabla="TIDIFINVDET    " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="ESTADOTRANSFERENCIA                     " tabla="TIDIFINVDET    " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="NUMERO                                  " tabla="TIDIFINVDET    " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código número                                                                                                                                                   " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="RECHAZADO                               " tabla="TIDIFINVDET    " campo="RECHAZADO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="0" etiqueta="Rechazado                                                                                                                                                       " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="CODIGO                                  " tabla="TIDIFINVDET    " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="24" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="ARTICULO                                " tabla="TIDIFINVDET    " campo="ART       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Artículo                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot; art.astock &lt;= 1 &quot;                                                                                                                                                                                     " grupo="1" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="COLOR                                   " tabla="TIDIFINVDET    " campo="CCOLOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Color                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="TALLE                                   " tabla="TIDIFINVDET    " campo="TALLE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Talle                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="DIFERENCIA                              " tabla="TIDIFINVDET    " campo="DIFERENCIA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Diferencia                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="IDCABECERA                              " tabla="TIDIFINVDET    " campo="IDCABECERA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIDiferenciasDeInventario               " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Diferencia de inventario                                                                                                                                        " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="OBS                                     " tabla="TIDIFINVDET    " campo="OBS       " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIODETALLE        " atributo="TIPO                                    " tabla="TIDIFINVDET    " campo="TIPO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="9" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On TIDIFINVDET.ART = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On TIDIFINVDET.CCOLOR = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLE                                   " atributo="DESCRIPCION                             " tabla="TALLE          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="11" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLE On TIDIFINVDET.TALLE = TALLE.Codigo And  TALLE.CODIGO != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="DESCRIPCION                             " tabla="TIDIFINV       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Dif.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIDIFINV On TIDIFINVDET.IDCABECERA = TIDIFINV.CODIGO And  TIDIFINV.CODIGO != 0                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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