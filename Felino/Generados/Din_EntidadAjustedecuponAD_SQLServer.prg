
define class Din_EntidadAJUSTEDECUPONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_AJUSTEDECUPON'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [IdCupon]
	cExpresionCCPorCampos = [#tabla#.IdCupon]
	cTagClaveCandidata = '_AJCCC'
	cTagClavePk = '_AJCPK'
	cTablaPrincipal = 'AJUCUPON'
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
			local  lxAjucuponFecexpo, lxAjucuponFaltafw, lxAjucuponFecimpo, lxAjucuponFectrans, lxAjucuponFmodifw, lxAjucuponNumero, lxAjucuponIdcaja, lxAjucuponPventa, lxAjucuponNctipo, lxAjucuponMonto, lxAjucuponValtafw, lxAjucuponVmodifw, lxAjucuponUmodifw, lxAjucuponZadsfw, lxAjucuponHmodifw, lxAjucuponSmodifw, lxAjucuponHoraexpo, lxAjucuponSaltafw, lxAjucuponHoraimpo, lxAjucuponUaltafw, lxAjucuponEsttrans, lxAjucuponIdfactura, lxAjucuponIdcupon, lxAjucuponIdnc, lxAjucuponIdcliente, lxAjucuponIdvendedor, lxAjucuponLetra, lxAjucuponBdmodifw, lxAjucuponBdaltafw, lxAjucuponHaltafw, lxAjucuponCodigo
				lxAjucuponFecexpo =  .Fechaexpo			lxAjucuponFaltafw =  .Fechaaltafw			lxAjucuponFecimpo =  .Fechaimpo			lxAjucuponFectrans =  .Fechatransferencia			lxAjucuponFmodifw =  .Fechamodificacionfw			lxAjucuponNumero =  .Numerofactura			lxAjucuponIdcaja =  .Caja			lxAjucuponPventa =  .Puntodeventafactura			lxAjucuponNctipo =  .Tiponotadecredito			lxAjucuponMonto =  .Montoajuste			lxAjucuponValtafw =  .Versionaltafw			lxAjucuponVmodifw =  .Versionmodificacionfw			lxAjucuponUmodifw =  .Usuariomodificacionfw			lxAjucuponZadsfw =  .Zadsfw			lxAjucuponHmodifw =  .Horamodificacionfw			lxAjucuponSmodifw =  .Seriemodificacionfw			lxAjucuponHoraexpo =  .Horaexpo			lxAjucuponSaltafw =  .Seriealtafw			lxAjucuponHoraimpo =  .Horaimpo			lxAjucuponUaltafw =  .Usuarioaltafw			lxAjucuponEsttrans =  .Estadotransferencia			lxAjucuponIdfactura =  .Idfactura			lxAjucuponIdcupon =  .Idcupon			lxAjucuponIdnc =  .Notadecredito			lxAjucuponIdcliente =  .Idcliente			lxAjucuponIdvendedor =  .Vendedor			lxAjucuponLetra =  .Letrafactura			lxAjucuponBdmodifw =  .Basededatosmodificacionfw			lxAjucuponBdaltafw =  .Basededatosaltafw			lxAjucuponHaltafw =  .Horaaltafw			lxAjucuponCodigo =  .Codigo
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxAjucuponCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.AJUCUPON ( "Fecexpo","Faltafw","Fecimpo","Fectrans","Fmodifw","Numero","Idcaja","Pventa","Nctipo","Monto","Valtafw","Vmodifw","Umodifw","Zadsfw","Hmodifw","Smodifw","Horaexpo","Saltafw","Horaimpo","Ualtafw","Esttrans","Idfactura","Idcupon","Idnc","Idcliente","Idvendedor","Letra","Bdmodifw","Bdaltafw","Haltafw","Codigo" ) values ( <<"'" + this.ConvertirDateSql( lxAjucuponFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjucuponFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjucuponFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjucuponFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjucuponFmodifw ) + "'" >>, <<lxAjucuponNumero >>, <<lxAjucuponIdcaja >>, <<lxAjucuponPventa >>, <<lxAjucuponNctipo >>, <<lxAjucuponMonto >>, <<"'" + this.FormatearTextoSql( lxAjucuponValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponIdfactura ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponIdcupon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponIdnc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponIdcliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponIdvendedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponLetra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponCodigo ) + "'" >> )
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
			If this.ConsultarPorClaveCandidata()
				lcError  = this.oEntidad.ObtenerMensajeClaveCandidataExistente()
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
			local  lxAjucuponFecexpo, lxAjucuponFaltafw, lxAjucuponFecimpo, lxAjucuponFectrans, lxAjucuponFmodifw, lxAjucuponNumero, lxAjucuponIdcaja, lxAjucuponPventa, lxAjucuponNctipo, lxAjucuponMonto, lxAjucuponValtafw, lxAjucuponVmodifw, lxAjucuponUmodifw, lxAjucuponZadsfw, lxAjucuponHmodifw, lxAjucuponSmodifw, lxAjucuponHoraexpo, lxAjucuponSaltafw, lxAjucuponHoraimpo, lxAjucuponUaltafw, lxAjucuponEsttrans, lxAjucuponIdfactura, lxAjucuponIdcupon, lxAjucuponIdnc, lxAjucuponIdcliente, lxAjucuponIdvendedor, lxAjucuponLetra, lxAjucuponBdmodifw, lxAjucuponBdaltafw, lxAjucuponHaltafw, lxAjucuponCodigo
				lxAjucuponFecexpo =  .Fechaexpo			lxAjucuponFaltafw =  .Fechaaltafw			lxAjucuponFecimpo =  .Fechaimpo			lxAjucuponFectrans =  .Fechatransferencia			lxAjucuponFmodifw =  .Fechamodificacionfw			lxAjucuponNumero =  .Numerofactura			lxAjucuponIdcaja =  .Caja			lxAjucuponPventa =  .Puntodeventafactura			lxAjucuponNctipo =  .Tiponotadecredito			lxAjucuponMonto =  .Montoajuste			lxAjucuponValtafw =  .Versionaltafw			lxAjucuponVmodifw =  .Versionmodificacionfw			lxAjucuponUmodifw =  .Usuariomodificacionfw			lxAjucuponZadsfw =  .Zadsfw			lxAjucuponHmodifw =  .Horamodificacionfw			lxAjucuponSmodifw =  .Seriemodificacionfw			lxAjucuponHoraexpo =  .Horaexpo			lxAjucuponSaltafw =  .Seriealtafw			lxAjucuponHoraimpo =  .Horaimpo			lxAjucuponUaltafw =  .Usuarioaltafw			lxAjucuponEsttrans =  .Estadotransferencia			lxAjucuponIdfactura =  .Idfactura			lxAjucuponIdcupon =  .Idcupon			lxAjucuponIdnc =  .Notadecredito			lxAjucuponIdcliente =  .Idcliente			lxAjucuponIdvendedor =  .Vendedor			lxAjucuponLetra =  .Letrafactura			lxAjucuponBdmodifw =  .Basededatosmodificacionfw			lxAjucuponBdaltafw =  .Basededatosaltafw			lxAjucuponHaltafw =  .Horaaltafw			lxAjucuponCodigo =  .Codigo
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.AJUCUPON set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAjucuponFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxAjucuponFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxAjucuponFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxAjucuponFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxAjucuponFmodifw ) + "'">>,"Numero" = <<lxAjucuponNumero>>,"Idcaja" = <<lxAjucuponIdcaja>>,"Pventa" = <<lxAjucuponPventa>>,"Nctipo" = <<lxAjucuponNctipo>>,"Monto" = <<lxAjucuponMonto>>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxAjucuponValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxAjucuponVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxAjucuponUmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxAjucuponZadsfw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxAjucuponHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxAjucuponSmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxAjucuponHoraexpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxAjucuponSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxAjucuponHoraimpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxAjucuponUaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxAjucuponEsttrans ) + "'">>,"Idfactura" = <<"'" + this.FormatearTextoSql( lxAjucuponIdfactura ) + "'">>,"Idcupon" = <<"'" + this.FormatearTextoSql( lxAjucuponIdcupon ) + "'">>,"Idnc" = <<"'" + this.FormatearTextoSql( lxAjucuponIdnc ) + "'">>,"Idcliente" = <<"'" + this.FormatearTextoSql( lxAjucuponIdcliente ) + "'">>,"Idvendedor" = <<"'" + this.FormatearTextoSql( lxAjucuponIdvendedor ) + "'">>,"Letra" = <<"'" + this.FormatearTextoSql( lxAjucuponLetra ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAjucuponBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAjucuponBdaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxAjucuponHaltafw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxAjucuponCodigo ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxAjucuponCodigo ) + "'">> and  AJUCUPON.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.AJUCUPON where " + this.ConvertirFuncionesSql( " AJUCUPON.CODIGO != ''" ) )
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
			Local lxAjucuponCodigo
			lxAjucuponCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numerofactura", "Idcaja" as "Caja", "Pventa" as "Puntodeventafactura", "Nctipo" as "Tiponotadecredito", "Monto" as "Montoajuste", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Idfactura" as "Idfactura", "Idcupon" as "Idcupon", "Idnc" as "Notadecredito", "Idcliente" as "Idcliente", "Idvendedor" as "Vendedor", "Letra" as "Letrafactura", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo" from ZooLogic.AJUCUPON where "Codigo" = <<"'" + this.FormatearTextoSql( lxAjucuponCodigo ) + "'">> and  AJUCUPON.CODIGO != ''
			endtext
			use in select('c_AJUSTEDECUPON')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTEDECUPON', set( 'Datasession' ) )

			if reccount( 'c_AJUSTEDECUPON' ) = 0
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
			Local lxAjuCuponIdCupon As Variant
			lxAjuCuponIdCupon = .IdCupon
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numerofactura", "Idcaja" as "Caja", "Pventa" as "Puntodeventafactura", "Nctipo" as "Tiponotadecredito", "Monto" as "Montoajuste", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Idfactura" as "Idfactura", "Idcupon" as "Idcupon", "Idnc" as "Notadecredito", "Idcliente" as "Idcliente", "Idvendedor" as "Vendedor", "Letra" as "Letrafactura", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo" from ZooLogic.AJUCUPON where  AJUCUPON.CODIGO != '' And IdCupon = <<"'" + this.FormatearTextoSql( lxAjuCuponIdCupon ) + "'">>
			endtext
			use in select('c_AJUSTEDECUPON')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTEDECUPON', set( 'Datasession' ) )
			if reccount( 'c_AJUSTEDECUPON' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxAjucuponCodigo as Variant
		llRetorno = .t.
		lxAjucuponCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.AJUCUPON where "Codigo" = <<"'" + this.FormatearTextoSql( lxAjucuponCodigo ) + "'">> and  AJUCUPON.CODIGO != ''
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
				lcOrden =  .IdCupon
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numerofactura", "Idcaja" as "Caja", "Pventa" as "Puntodeventafactura", "Nctipo" as "Tiponotadecredito", "Monto" as "Montoajuste", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Idfactura" as "Idfactura", "Idcupon" as "Idcupon", "Idnc" as "Notadecredito", "Idcliente" as "Idcliente", "Idvendedor" as "Vendedor", "Letra" as "Letrafactura", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo" from ZooLogic.AJUCUPON where  AJUCUPON.CODIGO != '' order by IdCupon
			endtext
			use in select('c_AJUSTEDECUPON')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTEDECUPON', set( 'Datasession' ) )
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
				lcOrden =  .IdCupon
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numerofactura", "Idcaja" as "Caja", "Pventa" as "Puntodeventafactura", "Nctipo" as "Tiponotadecredito", "Monto" as "Montoajuste", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Idfactura" as "Idfactura", "Idcupon" as "Idcupon", "Idnc" as "Notadecredito", "Idcliente" as "Idcliente", "Idvendedor" as "Vendedor", "Letra" as "Letrafactura", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo" from ZooLogic.AJUCUPON where  funciones.padr( IdCupon, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  AJUCUPON.CODIGO != '' order by IdCupon
			endtext
			use in select('c_AJUSTEDECUPON')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTEDECUPON', set( 'Datasession' ) )
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
				lcOrden =  .IdCupon
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numerofactura", "Idcaja" as "Caja", "Pventa" as "Puntodeventafactura", "Nctipo" as "Tiponotadecredito", "Monto" as "Montoajuste", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Idfactura" as "Idfactura", "Idcupon" as "Idcupon", "Idnc" as "Notadecredito", "Idcliente" as "Idcliente", "Idvendedor" as "Vendedor", "Letra" as "Letrafactura", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo" from ZooLogic.AJUCUPON where  funciones.padr( IdCupon, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  AJUCUPON.CODIGO != '' order by IdCupon desc
			endtext
			use in select('c_AJUSTEDECUPON')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTEDECUPON', set( 'Datasession' ) )
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
				lcOrden =  .IdCupon
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numerofactura", "Idcaja" as "Caja", "Pventa" as "Puntodeventafactura", "Nctipo" as "Tiponotadecredito", "Monto" as "Montoajuste", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Idfactura" as "Idfactura", "Idcupon" as "Idcupon", "Idnc" as "Notadecredito", "Idcliente" as "Idcliente", "Idvendedor" as "Vendedor", "Letra" as "Letrafactura", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo" from ZooLogic.AJUCUPON where  AJUCUPON.CODIGO != '' order by IdCupon desc
			endtext
			use in select('c_AJUSTEDECUPON')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTEDECUPON', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Faltafw,Fecimpo,Fectrans,Fmodifw,Numero,Idcaja,Pventa,Nctipo,Monto,Valtafw,Vmodifw,U" + ;
"modifw,Zadsfw,Hmodifw,Smodifw,Horaexpo,Saltafw,Horaimpo,Ualtafw,Esttrans,Idfactura,Idcupon,Idnc,Idcl" + ;
"iente,Idvendedor,Letra,Bdmodifw,Bdaltafw,Haltafw,Codigo" + ;
" from ZooLogic.AJUCUPON where  AJUCUPON.CODIGO != '' and " + lcFiltro )
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
			local  lxAjucuponFecexpo, lxAjucuponFaltafw, lxAjucuponFecimpo, lxAjucuponFectrans, lxAjucuponFmodifw, lxAjucuponNumero, lxAjucuponIdcaja, lxAjucuponPventa, lxAjucuponNctipo, lxAjucuponMonto, lxAjucuponValtafw, lxAjucuponVmodifw, lxAjucuponUmodifw, lxAjucuponZadsfw, lxAjucuponHmodifw, lxAjucuponSmodifw, lxAjucuponHoraexpo, lxAjucuponSaltafw, lxAjucuponHoraimpo, lxAjucuponUaltafw, lxAjucuponEsttrans, lxAjucuponIdfactura, lxAjucuponIdcupon, lxAjucuponIdnc, lxAjucuponIdcliente, lxAjucuponIdvendedor, lxAjucuponLetra, lxAjucuponBdmodifw, lxAjucuponBdaltafw, lxAjucuponHaltafw, lxAjucuponCodigo
				lxAjucuponFecexpo = ctod( '  /  /    ' )			lxAjucuponFaltafw = ctod( '  /  /    ' )			lxAjucuponFecimpo = ctod( '  /  /    ' )			lxAjucuponFectrans = ctod( '  /  /    ' )			lxAjucuponFmodifw = ctod( '  /  /    ' )			lxAjucuponNumero = 0			lxAjucuponIdcaja = 0			lxAjucuponPventa = 0			lxAjucuponNctipo = 0			lxAjucuponMonto = 0			lxAjucuponValtafw = []			lxAjucuponVmodifw = []			lxAjucuponUmodifw = []			lxAjucuponZadsfw = []			lxAjucuponHmodifw = []			lxAjucuponSmodifw = []			lxAjucuponHoraexpo = []			lxAjucuponSaltafw = []			lxAjucuponHoraimpo = []			lxAjucuponUaltafw = []			lxAjucuponEsttrans = []			lxAjucuponIdfactura = []			lxAjucuponIdcupon = []			lxAjucuponIdnc = []			lxAjucuponIdcliente = []			lxAjucuponIdvendedor = []			lxAjucuponLetra = []			lxAjucuponBdmodifw = []			lxAjucuponBdaltafw = []			lxAjucuponHaltafw = []			lxAjucuponCodigo = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.AJUCUPON where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'AJUCUPON' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where Codigo = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(Codigo, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AJUCUPON.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numerofactura", "Idcaja" as "Caja", "Pventa" as "Puntodeventafactura", "Nctipo" as "Tiponotadecredito", "Monto" as "Montoajuste", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Idfactura" as "Idfactura", "Idcupon" as "Idcupon", "Idnc" as "Notadecredito", "Idcliente" as "Idcliente", "Idvendedor" as "Vendedor", "Letra" as "Letrafactura", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AJUCUPON', '', tnTope )
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
				Case lcAtributo == 'NUMEROFACTURA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMEROFACTURA'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'PUNTODEVENTAFACTURA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PVENTA AS PUNTODEVENTAFACTURA'
				Case lcAtributo == 'TIPONOTADECREDITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NCTIPO AS TIPONOTADECREDITO'
				Case lcAtributo == 'MONTOAJUSTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTOAJUSTE'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'IDFACTURA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDFACTURA AS IDFACTURA'
				Case lcAtributo == 'IDCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCUPON AS IDCUPON'
				Case lcAtributo == 'NOTADECREDITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDNC AS NOTADECREDITO'
				Case lcAtributo == 'IDCLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCLIENTE AS IDCLIENTE'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVENDEDOR AS VENDEDOR'
				Case lcAtributo == 'LETRAFACTURA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRAFACTURA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
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
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROFACTURA'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTAFACTURA'
				lcCampo = 'PVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPONOTADECREDITO'
				lcCampo = 'NCTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOAJUSTE'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'IDFACTURA'
				lcCampo = 'IDFACTURA'
			Case upper( alltrim( tcAtributo ) ) == 'IDCUPON'
				lcCampo = 'IDCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'NOTADECREDITO'
				lcCampo = 'IDNC'
			Case upper( alltrim( tcAtributo ) ) == 'IDCLIENTE'
				lcCampo = 'IDCLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'IDVENDEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'LETRAFACTURA'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
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
			local  lxAjucuponFecexpo, lxAjucuponFaltafw, lxAjucuponFecimpo, lxAjucuponFectrans, lxAjucuponFmodifw, lxAjucuponNumero, lxAjucuponIdcaja, lxAjucuponPventa, lxAjucuponNctipo, lxAjucuponMonto, lxAjucuponValtafw, lxAjucuponVmodifw, lxAjucuponUmodifw, lxAjucuponZadsfw, lxAjucuponHmodifw, lxAjucuponSmodifw, lxAjucuponHoraexpo, lxAjucuponSaltafw, lxAjucuponHoraimpo, lxAjucuponUaltafw, lxAjucuponEsttrans, lxAjucuponIdfactura, lxAjucuponIdcupon, lxAjucuponIdnc, lxAjucuponIdcliente, lxAjucuponIdvendedor, lxAjucuponLetra, lxAjucuponBdmodifw, lxAjucuponBdaltafw, lxAjucuponHaltafw, lxAjucuponCodigo
				lxAjucuponFecexpo =  .Fechaexpo			lxAjucuponFaltafw =  .Fechaaltafw			lxAjucuponFecimpo =  .Fechaimpo			lxAjucuponFectrans =  .Fechatransferencia			lxAjucuponFmodifw =  .Fechamodificacionfw			lxAjucuponNumero =  .Numerofactura			lxAjucuponIdcaja =  .Caja			lxAjucuponPventa =  .Puntodeventafactura			lxAjucuponNctipo =  .Tiponotadecredito			lxAjucuponMonto =  .Montoajuste			lxAjucuponValtafw =  .Versionaltafw			lxAjucuponVmodifw =  .Versionmodificacionfw			lxAjucuponUmodifw =  .Usuariomodificacionfw			lxAjucuponZadsfw =  .Zadsfw			lxAjucuponHmodifw =  .Horamodificacionfw			lxAjucuponSmodifw =  .Seriemodificacionfw			lxAjucuponHoraexpo =  .Horaexpo			lxAjucuponSaltafw =  .Seriealtafw			lxAjucuponHoraimpo =  .Horaimpo			lxAjucuponUaltafw =  .Usuarioaltafw			lxAjucuponEsttrans =  .Estadotransferencia			lxAjucuponIdfactura =  .Idfactura			lxAjucuponIdcupon =  .Idcupon			lxAjucuponIdnc =  .Notadecredito			lxAjucuponIdcliente =  .Idcliente			lxAjucuponIdvendedor =  .Vendedor			lxAjucuponLetra =  .Letrafactura			lxAjucuponBdmodifw =  .Basededatosmodificacionfw			lxAjucuponBdaltafw =  .Basededatosaltafw			lxAjucuponHaltafw =  .Horaaltafw			lxAjucuponCodigo =  .Codigo
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.AJUCUPON ( "Fecexpo","Faltafw","Fecimpo","Fectrans","Fmodifw","Numero","Idcaja","Pventa","Nctipo","Monto","Valtafw","Vmodifw","Umodifw","Zadsfw","Hmodifw","Smodifw","Horaexpo","Saltafw","Horaimpo","Ualtafw","Esttrans","Idfactura","Idcupon","Idnc","Idcliente","Idvendedor","Letra","Bdmodifw","Bdaltafw","Haltafw","Codigo" ) values ( <<"'" + this.ConvertirDateSql( lxAjucuponFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjucuponFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjucuponFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjucuponFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjucuponFmodifw ) + "'" >>, <<lxAjucuponNumero >>, <<lxAjucuponIdcaja >>, <<lxAjucuponPventa >>, <<lxAjucuponNctipo >>, <<lxAjucuponMonto >>, <<"'" + this.FormatearTextoSql( lxAjucuponValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponIdfactura ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponIdcupon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponIdnc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponIdcliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponIdvendedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponLetra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucuponCodigo ) + "'" >> )
		endtext
		loColeccion.cTabla = 'AJUCUPON' 
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
			local  lxAjucuponFecexpo, lxAjucuponFaltafw, lxAjucuponFecimpo, lxAjucuponFectrans, lxAjucuponFmodifw, lxAjucuponNumero, lxAjucuponIdcaja, lxAjucuponPventa, lxAjucuponNctipo, lxAjucuponMonto, lxAjucuponValtafw, lxAjucuponVmodifw, lxAjucuponUmodifw, lxAjucuponZadsfw, lxAjucuponHmodifw, lxAjucuponSmodifw, lxAjucuponHoraexpo, lxAjucuponSaltafw, lxAjucuponHoraimpo, lxAjucuponUaltafw, lxAjucuponEsttrans, lxAjucuponIdfactura, lxAjucuponIdcupon, lxAjucuponIdnc, lxAjucuponIdcliente, lxAjucuponIdvendedor, lxAjucuponLetra, lxAjucuponBdmodifw, lxAjucuponBdaltafw, lxAjucuponHaltafw, lxAjucuponCodigo
				lxAjucuponFecexpo =  .Fechaexpo			lxAjucuponFaltafw =  .Fechaaltafw			lxAjucuponFecimpo =  .Fechaimpo			lxAjucuponFectrans =  .Fechatransferencia			lxAjucuponFmodifw =  .Fechamodificacionfw			lxAjucuponNumero =  .Numerofactura			lxAjucuponIdcaja =  .Caja			lxAjucuponPventa =  .Puntodeventafactura			lxAjucuponNctipo =  .Tiponotadecredito			lxAjucuponMonto =  .Montoajuste			lxAjucuponValtafw =  .Versionaltafw			lxAjucuponVmodifw =  .Versionmodificacionfw			lxAjucuponUmodifw =  .Usuariomodificacionfw			lxAjucuponZadsfw =  .Zadsfw			lxAjucuponHmodifw =  .Horamodificacionfw			lxAjucuponSmodifw =  .Seriemodificacionfw			lxAjucuponHoraexpo =  .Horaexpo			lxAjucuponSaltafw =  .Seriealtafw			lxAjucuponHoraimpo =  .Horaimpo			lxAjucuponUaltafw =  .Usuarioaltafw			lxAjucuponEsttrans =  .Estadotransferencia			lxAjucuponIdfactura =  .Idfactura			lxAjucuponIdcupon =  .Idcupon			lxAjucuponIdnc =  .Notadecredito			lxAjucuponIdcliente =  .Idcliente			lxAjucuponIdvendedor =  .Vendedor			lxAjucuponLetra =  .Letrafactura			lxAjucuponBdmodifw =  .Basededatosmodificacionfw			lxAjucuponBdaltafw =  .Basededatosaltafw			lxAjucuponHaltafw =  .Horaaltafw			lxAjucuponCodigo =  .Codigo
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  AJUCUPON.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.AJUCUPON set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAjucuponFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxAjucuponFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAjucuponFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxAjucuponFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAjucuponFmodifw ) + "'">>, "Numero" = <<lxAjucuponNumero>>, "Idcaja" = <<lxAjucuponIdcaja>>, "Pventa" = <<lxAjucuponPventa>>, "Nctipo" = <<lxAjucuponNctipo>>, "Monto" = <<lxAjucuponMonto>>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxAjucuponValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxAjucuponVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxAjucuponUmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxAjucuponZadsfw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxAjucuponHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxAjucuponSmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxAjucuponHoraexpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxAjucuponSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxAjucuponHoraimpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxAjucuponUaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxAjucuponEsttrans ) + "'">>, "Idfactura" = <<"'" + this.FormatearTextoSql( lxAjucuponIdfactura ) + "'">>, "Idcupon" = <<"'" + this.FormatearTextoSql( lxAjucuponIdcupon ) + "'">>, "Idnc" = <<"'" + this.FormatearTextoSql( lxAjucuponIdnc ) + "'">>, "Idcliente" = <<"'" + this.FormatearTextoSql( lxAjucuponIdcliente ) + "'">>, "Idvendedor" = <<"'" + this.FormatearTextoSql( lxAjucuponIdvendedor ) + "'">>, "Letra" = <<"'" + this.FormatearTextoSql( lxAjucuponLetra ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAjucuponBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAjucuponBdaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxAjucuponHaltafw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxAjucuponCodigo ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'AJUCUPON' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  AJUCUPON.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.AJUCUPON where ' + lcFiltro )
			loColeccion.cTabla = 'AJUCUPON' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.AJUCUPON where  AJUCUPON.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.AJUCUPON where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  AJUCUPON.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxAjuCuponIdCupon as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTEDECUPON'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.AJUCUPON Where  IdCupon = ] + "'" + this.FormatearTextoSql( &lcCursor..IdCupon    ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..Codigo
				if lxValorClavePK == curSeek.Codigo or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.Codigo and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.Codigo
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.AJUCUPON set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, PVenta = ] + transform( &lcCursor..PVenta )+ [, NCTIPO = ] + transform( &lcCursor..NCTIPO )+ [, Monto = ] + transform( &lcCursor..Monto )+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, IdFactura = ] + "'" + this.FormatearTextoSql( &lcCursor..IdFactura ) + "'"+ [, IdCupon = ] + "'" + this.FormatearTextoSql( &lcCursor..IdCupon ) + "'"+ [, IdNC = ] + "'" + this.FormatearTextoSql( &lcCursor..IdNC ) + "'"+ [, IdCliente = ] + "'" + this.FormatearTextoSql( &lcCursor..IdCliente ) + "'"+ [, idVendedor = ] + "'" + this.FormatearTextoSql( &lcCursor..idVendedor ) + "'"+ [, Letra = ] + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.AJUCUPON Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FALTAFW, FECIMPO, FECTRANS, FMODIFW, Numero, IdCaja, PVenta, NCTIPO, Monto, VALTAFW, VMODIFW, UMODIFW, ZADSFW, HMODIFW, SMODIFW, HORAEXPO, SALTAFW, HORAIMPO, UALTAFW, ESTTRANS, IdFactura, IdCupon, IdNC, IdCliente, idVendedor, Letra, BDMODIFW, BDALTAFW, HALTAFW, Codigo
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + transform( &lcCursor..Numero ) + ',' + transform( &lcCursor..IdCaja ) + ',' + transform( &lcCursor..PVenta )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..NCTIPO ) + ',' + transform( &lcCursor..Monto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdFactura ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdCupon ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdNC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdCliente ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..idVendedor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.AJUCUPON ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTEDECUPON'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Id cupón: ' + transform( &tcCursor..IdCupon    )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'AJUSTEDECUPON'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'AJUSTEDECUPON_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_AjuCupon')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'AJUSTEDECUPON'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..IdCupon )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad AJUSTEDECUPON. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTEDECUPON'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,IdCupon as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( IdCupon, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTEDECUPON'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_AjuCupon') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_AjuCupon
Create Table ZooLogic.TablaTrabajo_AjuCupon ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"numero" numeric( 8, 0 )  null, 
"idcaja" numeric( 2, 0 )  null, 
"pventa" numeric( 4, 0 )  null, 
"nctipo" numeric( 2, 0 )  null, 
"monto" numeric( 15, 2 )  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"horaexpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"esttrans" char( 20 )  null, 
"idfactura" char( 38 )  null, 
"idcupon" char( 38 )  null, 
"idnc" char( 38 )  null, 
"idcliente" char( 10 )  null, 
"idvendedor" char( 10 )  null, 
"letra" char( 1 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"codigo" char( 38 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_AjuCupon' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_AjuCupon' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTEDECUPON'
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
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('pventa','pventa')
			.AgregarMapeo('nctipo','nctipo')
			.AgregarMapeo('monto','monto')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('idfactura','idfactura')
			.AgregarMapeo('idcupon','idcupon')
			.AgregarMapeo('idnc','idnc')
			.AgregarMapeo('idcliente','idcliente')
			.AgregarMapeo('idvendedor','idvendedor')
			.AgregarMapeo('letra','letra')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('codigo','codigo')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_AjuCupon'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.PVENTA = isnull( d.PVENTA, t.PVENTA ),t.NCTIPO = isnull( d.NCTIPO, t.NCTIPO ),t.MONTO = isnull( d.MONTO, t.MONTO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.IDFACTURA = isnull( d.IDFACTURA, t.IDFACTURA ),t.IDCUPON = isnull( d.IDCUPON, t.IDCUPON ),t.IDNC = isnull( d.IDNC, t.IDNC ),t.IDCLIENTE = isnull( d.IDCLIENTE, t.IDCLIENTE ),t.IDVENDEDOR = isnull( d.IDVENDEDOR, t.IDVENDEDOR ),t.LETRA = isnull( d.LETRA, t.LETRA ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO )
					from ZooLogic.AJUCUPON t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.IdCupon = d.IdCupon
				-- Fin Updates
				insert into ZooLogic.AJUCUPON(Fecexpo,Faltafw,Fecimpo,Fectrans,Fmodifw,Numero,Idcaja,Pventa,Nctipo,Monto,Valtafw,Vmodifw,Umodifw,Zadsfw,Hmodifw,Smodifw,Horaexpo,Saltafw,Horaimpo,Ualtafw,Esttrans,Idfactura,Idcupon,Idnc,Idcliente,Idvendedor,Letra,Bdmodifw,Bdaltafw,Haltafw,Codigo)
					Select isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.NUMERO,0),isnull( d.IDCAJA,0),isnull( d.PVENTA,0),isnull( d.NCTIPO,0),isnull( d.MONTO,0),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.ZADSFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.UALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.IDFACTURA,''),isnull( d.IDCUPON,''),isnull( d.IDNC,''),isnull( d.IDCLIENTE,''),isnull( d.IDVENDEDOR,''),isnull( d.LETRA,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.CODIGO,'')
						From deleted d left join ZooLogic.AJUCUPON pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.AJUCUPON cc 
							 on  d.IdCupon = cc.IdCupon
						Where pk.Codigo Is Null 
							 and cc.IdCupon Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: ID CUPÓN ' + cast( d.IdCupon as Varchar(38) ) + '','La clave principal no es la esperada'
					from ZooLogic.AJUCUPON t inner join deleted d 
							on   t.IdCupon = d.IdCupon
						left join deleted h 
							 on t.Codigo = h.Codigo
							 where h.Codigo is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: ID CUPÓN ' + cast( d.IdCupon as Varchar(38) ) + '','La clave principal a importar ya existe'
					from ZooLogic.AJUCUPON t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.IdCupon = h.IdCupon
							where   h.IdCupon is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_AjuCupon') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_AjuCupon
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_AJUSTEDECUPON' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDECUPON.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDECUPON.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDECUPON.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDECUPON.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDECUPON.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Numerofactura = nvl( c_AJUSTEDECUPON.Numerofactura, 0 )
					.Caja = nvl( c_AJUSTEDECUPON.Caja, 0 )
					.Puntodeventafactura = nvl( c_AJUSTEDECUPON.Puntodeventafactura, 0 )
					.Tiponotadecredito = nvl( c_AJUSTEDECUPON.Tiponotadecredito, 0 )
					.Montoajuste = nvl( c_AJUSTEDECUPON.Montoajuste, 0 )
					.Versionaltafw = nvl( c_AJUSTEDECUPON.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_AJUSTEDECUPON.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_AJUSTEDECUPON.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horamodificacionfw = nvl( c_AJUSTEDECUPON.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_AJUSTEDECUPON.Seriemodificacionfw, [] )
					.Horaexpo = nvl( c_AJUSTEDECUPON.Horaexpo, [] )
					.Seriealtafw = nvl( c_AJUSTEDECUPON.Seriealtafw, [] )
					.Horaimpo = nvl( c_AJUSTEDECUPON.Horaimpo, [] )
					.Usuarioaltafw = nvl( c_AJUSTEDECUPON.Usuarioaltafw, [] )
					.Estadotransferencia = nvl( c_AJUSTEDECUPON.Estadotransferencia, [] )
					.Idfactura = nvl( c_AJUSTEDECUPON.Idfactura, [] )
					.Idcupon = nvl( c_AJUSTEDECUPON.Idcupon, [] )
					.Notadecredito = nvl( c_AJUSTEDECUPON.Notadecredito, [] )
					.Idcliente = nvl( c_AJUSTEDECUPON.Idcliente, [] )
					.Vendedor = nvl( c_AJUSTEDECUPON.Vendedor, [] )
					.Letrafactura = nvl( c_AJUSTEDECUPON.Letrafactura, [] )
					.Basededatosmodificacionfw = nvl( c_AJUSTEDECUPON.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_AJUSTEDECUPON.Basededatosaltafw, [] )
					.Horaaltafw = nvl( c_AJUSTEDECUPON.Horaaltafw, [] )
					.Codigo = nvl( c_AJUSTEDECUPON.Codigo, [] )
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
			lxRetorno = c_AJUSTEDECUPON.CODIGO
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
		return c_AJUSTEDECUPON.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.AJUCUPON' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,Codigo as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    Codigo from (
							select * 
								from ZooLogic.AJUCUPON 
								Where   AJUCUPON.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "AJUCUPON", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numerofactura", "Idcaja" as "Caja", "Pventa" as "Puntodeventafactura", "Nctipo" as "Tiponotadecredito", "Monto" as "Montoajuste", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Idfactura" as "Idfactura", "Idcupon" as "Idcupon", "Idnc" as "Notadecredito", "Idcliente" as "Idcliente", "Idvendedor" as "Vendedor", "Letra" as "Letrafactura", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.AJUCUPON 
								Where   AJUCUPON.CODIGO != ''
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
	Tabla = 'AJUCUPON'
	Filtro = " AJUCUPON.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " AJUCUPON.CODIGO != ''"
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
	<row entidad="AJUSTEDECUPON                           " atributo="FECHAEXPO                               " tabla="AJUCUPON       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="FECHAALTAFW                             " tabla="AJUCUPON       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="FECHAIMPO                               " tabla="AJUCUPON       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="FECHATRANSFERENCIA                      " tabla="AJUCUPON       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="FECHAMODIFICACIONFW                     " tabla="AJUCUPON       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="NUMEROFACTURA                           " tabla="AJUCUPON       " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="FACTTIPO                                " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="CAJA                                    " tabla="AJUCUPON       " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Caja                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="PUNTODEVENTAFACTURA                     " tabla="AJUCUPON       " campo="PVENTA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="TIPONOTADECREDITO                       " tabla="AJUCUPON       " campo="NCTIPO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo de nota de crédito                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="MONTOAJUSTE                             " tabla="AJUCUPON       " campo="MONTO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de ajuste                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="VERSIONALTAFW                           " tabla="AJUCUPON       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="VERSIONMODIFICACIONFW                   " tabla="AJUCUPON       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="USUARIOMODIFICACIONFW                   " tabla="AJUCUPON       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="ZADSFW                                  " tabla="AJUCUPON       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="HORAMODIFICACIONFW                      " tabla="AJUCUPON       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="SERIEMODIFICACIONFW                     " tabla="AJUCUPON       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="HORAEXPO                                " tabla="AJUCUPON       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="SERIEALTAFW                             " tabla="AJUCUPON       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="HORAIMPO                                " tabla="AJUCUPON       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="USUARIOALTAFW                           " tabla="AJUCUPON       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="ESTADOTRANSFERENCIA                     " tabla="AJUCUPON       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="IDFACTURA                               " tabla="AJUCUPON       " campo="IDFACTURA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Id de factura                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="IDCUPON                                 " tabla="AJUCUPON       " campo="IDCUPON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="Id cupón                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="NOTADECREDITO                           " tabla="AJUCUPON       " campo="IDNC      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Id de nota de crédito                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="IDCLIENTE                               " tabla="AJUCUPON       " campo="IDCLIENTE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Id de cliente                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="VENDEDOR                                " tabla="AJUCUPON       " campo="IDVENDEDOR" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vendedor                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="LETRAFACTURA                            " tabla="AJUCUPON       " campo="LETRA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Letra                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="AJUCUPON       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="BASEDEDATOSALTAFW                       " tabla="AJUCUPON       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="HORAALTAFW                              " tabla="AJUCUPON       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDECUPON                           " atributo="CODIGO                                  " tabla="AJUCUPON       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="Id                                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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