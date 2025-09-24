
define class Din_EntidadINFORMACIONADICIONALCOMPVTASAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_INFORMACIONADICIONALCOMPVTAS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_049PK'
	cTablaPrincipal = 'INFADICIONAL'
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
			local  lxFfch, lxFletra, lxFperson, lxZadsfw, lxFven, lxInfadicionalCodigo, lxFptoven, lxFcliente, lxEsttrans, lxFectrans, lxFnumcomp, lxFaltafw, lxHaltafw, lxFmodifw, lxHmodifw, lxFecimpo, lxHoraimpo, lxFecexpo, lxHoraexpo, lxUaltafw, lxUmodifw, lxSaltafw, lxSmodifw, lxBdaltafw, lxBdmodifw, lxValtafw, lxVmodifw, lxReferencia
				lxFfch =  .Fecha			lxFletra =  .Letra			lxFperson =  upper( .Cliente_PK ) 			lxZadsfw =  .Zadsfw			lxFven =  upper( .Vendedor_PK ) 			lxInfadicionalCodigo =  .Codigo			lxFptoven =  .Puntodeventa			lxFcliente =  .Clientedescripcion			lxEsttrans =  .Estadotransferencia			lxFectrans =  .Fechatransferencia			lxFnumcomp =  .Numero			lxFaltafw =  .Fechaaltafw			lxHaltafw =  .Horaaltafw			lxFmodifw =  .Fechamodificacionfw			lxHmodifw =  .Horamodificacionfw			lxFecimpo =  .Fechaimpo			lxHoraimpo =  .Horaimpo			lxFecexpo =  .Fechaexpo			lxHoraexpo =  .Horaexpo			lxUaltafw =  .Usuarioaltafw			lxUmodifw =  .Usuariomodificacionfw			lxSaltafw =  .Seriealtafw			lxSmodifw =  .Seriemodificacionfw			lxBdaltafw =  .Basededatosaltafw			lxBdmodifw =  .Basededatosmodificacionfw			lxValtafw =  .Versionaltafw			lxVmodifw =  .Versionmodificacionfw			lxReferencia =  .Referencia
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxInfadicionalCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.INFADICIONAL ( "Codigo" ) values ( <<"'" + this.FormatearTextoSql( lxInfadicionalCodigo ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Comprobantes
				if this.oEntidad.Comprobantes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipocomprobante = loItem.Tipocomprobante
					lxNroitem = lnContadorNroItem
					lxTipocompcaracter = loItem.Tipocompcaracter
					lxLetra = loItem.Letra
					lxPuntodeventa = loItem.Puntodeventa
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxTotal = loItem.Total
					lxVendedor = loItem.Vendedor
					lxTipo = loItem.Tipo
					lxAfecta = loItem.Afecta
					lxInterviniente = loItem.Interviniente
					lxNombreentidad = loItem.Nombreentidad
					lxCodigoentidad = loItem.Codigoentidad
					lxOrigen = loItem.Origen
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompAfe("AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxTipocomprobante>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
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
		return this.oEntidad.CODIGO
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxFfch, lxFletra, lxFperson, lxZadsfw, lxFven, lxInfadicionalCodigo, lxFptoven, lxFcliente, lxEsttrans, lxFectrans, lxFnumcomp, lxFaltafw, lxHaltafw, lxFmodifw, lxHmodifw, lxFecimpo, lxHoraimpo, lxFecexpo, lxHoraexpo, lxUaltafw, lxUmodifw, lxSaltafw, lxSmodifw, lxBdaltafw, lxBdmodifw, lxValtafw, lxVmodifw, lxReferencia
				lxFfch =  .Fecha			lxFletra =  .Letra			lxFperson =  upper( .Cliente_PK ) 			lxZadsfw =  .Zadsfw			lxFven =  upper( .Vendedor_PK ) 			lxInfadicionalCodigo =  .Codigo			lxFptoven =  .Puntodeventa			lxFcliente =  .Clientedescripcion			lxEsttrans =  .Estadotransferencia			lxFectrans =  .Fechatransferencia			lxFnumcomp =  .Numero			lxFaltafw =  .Fechaaltafw			lxHaltafw =  .Horaaltafw			lxFmodifw =  .Fechamodificacionfw			lxHmodifw =  .Horamodificacionfw			lxFecimpo =  .Fechaimpo			lxHoraimpo =  .Horaimpo			lxFecexpo =  .Fechaexpo			lxHoraexpo =  .Horaexpo			lxUaltafw =  .Usuarioaltafw			lxUmodifw =  .Usuariomodificacionfw			lxSaltafw =  .Seriealtafw			lxSmodifw =  .Seriemodificacionfw			lxBdaltafw =  .Basededatosaltafw			lxBdmodifw =  .Basededatosmodificacionfw			lxValtafw =  .Versionaltafw			lxVmodifw =  .Versionmodificacionfw			lxReferencia =  .Referencia
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.INFADICIONAL set "Codigo" = <<"'" + this.FormatearTextoSql( lxInfadicionalCodigo ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxInfadicionalCodigo ) + "'">> and  INFADICIONAL.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Comprobantes
				if this.oEntidad.Comprobantes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipocomprobante = loItem.Tipocomprobante
					lxNroitem = lnContadorNroItem
					lxTipocompcaracter = loItem.Tipocompcaracter
					lxLetra = loItem.Letra
					lxPuntodeventa = loItem.Puntodeventa
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxTotal = loItem.Total
					lxVendedor = loItem.Vendedor
					lxTipo = loItem.Tipo
					lxAfecta = loItem.Afecta
					lxInterviniente = loItem.Interviniente
					lxNombreentidad = loItem.Nombreentidad
					lxCodigoentidad = loItem.Codigoentidad
					lxOrigen = loItem.Origen
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompAfe("AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxTipocomprobante>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.INFADICIONAL where " + this.ConvertirFuncionesSql( " INFADICIONAL.CODIGO != ''" ) )
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
			Local lxInfadicionalCodigo
			lxInfadicionalCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo" from ZooLogic.INFADICIONAL where "Codigo" = <<"'" + this.FormatearTextoSql( lxInfadicionalCodigo ) + "'">> and  INFADICIONAL.CODIGO != ''
			endtext
			use in select('c_INFORMACIONADICIONALCOMPVTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INFORMACIONADICIONALCOMPVTAS', set( 'Datasession' ) )

			if reccount( 'c_INFORMACIONADICIONALCOMPVTAS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where CODIGO = <<"'" + this.FormatearTextoSql( c_INFORMACIONADICIONALCOMPVTAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Comprobantes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Comprobantes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Comprobantes
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxInfadicionalCodigo as Variant
		llRetorno = .t.
		lxInfadicionalCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.INFADICIONAL where "Codigo" = <<"'" + this.FormatearTextoSql( lxInfadicionalCodigo ) + "'">> and  INFADICIONAL.CODIGO != ''
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Codigo" as "Codigo" from ZooLogic.INFADICIONAL where  INFADICIONAL.CODIGO != '' order by Codigo
			endtext
			use in select('c_INFORMACIONADICIONALCOMPVTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INFORMACIONADICIONALCOMPVTAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where CODIGO = <<"'" + this.FormatearTextoSql( c_INFORMACIONADICIONALCOMPVTAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Comprobantes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Comprobantes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Comprobantes
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Codigo" as "Codigo" from ZooLogic.INFADICIONAL where  funciones.padr( Codigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  INFADICIONAL.CODIGO != '' order by Codigo
			endtext
			use in select('c_INFORMACIONADICIONALCOMPVTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INFORMACIONADICIONALCOMPVTAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where CODIGO = <<"'" + this.FormatearTextoSql( c_INFORMACIONADICIONALCOMPVTAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Comprobantes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Comprobantes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Comprobantes
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Codigo" as "Codigo" from ZooLogic.INFADICIONAL where  funciones.padr( Codigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  INFADICIONAL.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_INFORMACIONADICIONALCOMPVTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INFORMACIONADICIONALCOMPVTAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where CODIGO = <<"'" + this.FormatearTextoSql( c_INFORMACIONADICIONALCOMPVTAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Comprobantes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Comprobantes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Comprobantes
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Codigo" as "Codigo" from ZooLogic.INFADICIONAL where  INFADICIONAL.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_INFORMACIONADICIONALCOMPVTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INFORMACIONADICIONALCOMPVTAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where CODIGO = <<"'" + this.FormatearTextoSql( c_INFORMACIONADICIONALCOMPVTAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Comprobantes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Comprobantes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Comprobantes
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
			lcXml = this.oConexion.EjecutarSql( "select Codigo" + ;
" from ZooLogic.INFADICIONAL where  INFADICIONAL.CODIGO != '' and " + lcFiltro )
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
			local  lxFfch, lxFletra, lxFperson, lxZadsfw, lxFven, lxInfadicionalCodigo, lxFptoven, lxFcliente, lxEsttrans, lxFectrans, lxFnumcomp, lxFaltafw, lxHaltafw, lxFmodifw, lxHmodifw, lxFecimpo, lxHoraimpo, lxFecexpo, lxHoraexpo, lxUaltafw, lxUmodifw, lxSaltafw, lxSmodifw, lxBdaltafw, lxBdmodifw, lxValtafw, lxVmodifw, lxReferencia
				lxFfch = ctod( '  /  /    ' )			lxFletra = []			lxFperson = []			lxZadsfw = []			lxFven = []			lxInfadicionalCodigo = []			lxFptoven = 0			lxFcliente = []			lxEsttrans = []			lxFectrans = ctod( '  /  /    ' )			lxFnumcomp = 0			lxFaltafw = ctod( '  /  /    ' )			lxHaltafw = []			lxFmodifw = ctod( '  /  /    ' )			lxHmodifw = []			lxFecimpo = ctod( '  /  /    ' )			lxHoraimpo = []			lxFecexpo = ctod( '  /  /    ' )			lxHoraexpo = []			lxUaltafw = []			lxUmodifw = []			lxSaltafw = []			lxSmodifw = []			lxBdaltafw = []			lxBdmodifw = []			lxValtafw = []			lxVmodifw = []			lxReferencia = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.INFADICIONAL where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'INFADICIONAL' + '_' + tcCampo
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
		lcWhere = " Where  INFADICIONAL.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Ffch" as "Fecha", "Fletra" as "Letra", "Fperson" as "Cliente", "Zadsfw" as "Zadsfw", "Fven" as "Vendedor", "Codigo" as "Codigo", "Fptoven" as "Puntodeventa", "Fcliente" as "Clientedescripcion", "Esttrans" as "Estadotransferencia", "Fectrans" as "Fechatransferencia", "Fnumcomp" as "Numero", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Fmodifw" as "Fechamodificacionfw", "Hmodifw" as "Horamodificacionfw", "Fecimpo" as "Fechaimpo", "Horaimpo" as "Horaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Referencia" as "Referencia"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'INFADICIONAL', '', tnTope )
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
	Function ObtenerDatosDetalleComprobantes( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COMPAFE.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleComprobantes( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CompAfe', 'Comprobantes', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleComprobantes( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleComprobantes( lcAtributo )
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
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleComprobantes( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPOCOM AS TIPOCOMPROBANTE'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'TIPOCOMPCARACTER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECOMPROB AS TIPOCOMPCARACTER'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFELETRA AS LETRA'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFEPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENUMCOM AS NUMERO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFEFECHA AS FECHA'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETOTAL AS TOTAL'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFEVEND AS VENDEDOR'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPO AS TIPO'
				Case lcAtributo == 'AFECTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECTA AS AFECTA'
				Case lcAtributo == 'INTERVINIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCINTER AS INTERVINIENTE'
				Case lcAtributo == 'NOMBREENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMINTER AS NOMBREENTIDAD'
				Case lcAtributo == 'CODIGOENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODINTER AS CODIGOENTIDAD'
				Case lcAtributo == 'ORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGEN AS ORIGEN'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleComprobantes( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'AFETIPOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPCARACTER'
				lcCampo = 'AFECOMPROB'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'AFELETRA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'AFEPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'AFENUMCOM'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'AFEFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'AFETOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'AFEVEND'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'AFETIPO'
			Case upper( alltrim( tcAtributo ) ) == 'AFECTA'
				lcCampo = 'AFECTA'
			Case upper( alltrim( tcAtributo ) ) == 'INTERVINIENTE'
				lcCampo = 'DESCINTER'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBREENTIDAD'
				lcCampo = 'NOMINTER'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOENTIDAD'
				lcCampo = 'CODINTER'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGEN'
				lcCampo = 'ORIGEN'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'COMPROBANTES'
			lcRetorno = 'COMPAFE'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxFfch, lxFletra, lxFperson, lxZadsfw, lxFven, lxInfadicionalCodigo, lxFptoven, lxFcliente, lxEsttrans, lxFectrans, lxFnumcomp, lxFaltafw, lxHaltafw, lxFmodifw, lxHmodifw, lxFecimpo, lxHoraimpo, lxFecexpo, lxHoraexpo, lxUaltafw, lxUmodifw, lxSaltafw, lxSmodifw, lxBdaltafw, lxBdmodifw, lxValtafw, lxVmodifw, lxReferencia
				lxFfch =  .Fecha			lxFletra =  .Letra			lxFperson =  upper( .Cliente_PK ) 			lxZadsfw =  .Zadsfw			lxFven =  upper( .Vendedor_PK ) 			lxInfadicionalCodigo =  .Codigo			lxFptoven =  .Puntodeventa			lxFcliente =  .Clientedescripcion			lxEsttrans =  .Estadotransferencia			lxFectrans =  .Fechatransferencia			lxFnumcomp =  .Numero			lxFaltafw =  .Fechaaltafw			lxHaltafw =  .Horaaltafw			lxFmodifw =  .Fechamodificacionfw			lxHmodifw =  .Horamodificacionfw			lxFecimpo =  .Fechaimpo			lxHoraimpo =  .Horaimpo			lxFecexpo =  .Fechaexpo			lxHoraexpo =  .Horaexpo			lxUaltafw =  .Usuarioaltafw			lxUmodifw =  .Usuariomodificacionfw			lxSaltafw =  .Seriealtafw			lxSmodifw =  .Seriemodificacionfw			lxBdaltafw =  .Basededatosaltafw			lxBdmodifw =  .Basededatosmodificacionfw			lxValtafw =  .Versionaltafw			lxVmodifw =  .Versionmodificacionfw			lxReferencia =  .Referencia
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.INFADICIONAL ( "Codigo" ) values ( <<"'" + this.FormatearTextoSql( lxInfadicionalCodigo ) + "'" >> )
		endtext
		loColeccion.cTabla = 'INFADICIONAL' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Comprobantes
				if this.oEntidad.Comprobantes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipocomprobante = loItem.Tipocomprobante
					lxNroitem = lnContadorNroItem
					lxTipocompcaracter = loItem.Tipocompcaracter
					lxLetra = loItem.Letra
					lxPuntodeventa = loItem.Puntodeventa
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxTotal = loItem.Total
					lxVendedor = loItem.Vendedor
					lxTipo = loItem.Tipo
					lxAfecta = loItem.Afecta
					lxInterviniente = loItem.Interviniente
					lxNombreentidad = loItem.Nombreentidad
					lxCodigoentidad = loItem.Codigoentidad
					lxOrigen = loItem.Origen
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompAfe("AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxTipocomprobante>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxFfch, lxFletra, lxFperson, lxZadsfw, lxFven, lxInfadicionalCodigo, lxFptoven, lxFcliente, lxEsttrans, lxFectrans, lxFnumcomp, lxFaltafw, lxHaltafw, lxFmodifw, lxHmodifw, lxFecimpo, lxHoraimpo, lxFecexpo, lxHoraexpo, lxUaltafw, lxUmodifw, lxSaltafw, lxSmodifw, lxBdaltafw, lxBdmodifw, lxValtafw, lxVmodifw, lxReferencia
				lxFfch =  .Fecha			lxFletra =  .Letra			lxFperson =  upper( .Cliente_PK ) 			lxZadsfw =  .Zadsfw			lxFven =  upper( .Vendedor_PK ) 			lxInfadicionalCodigo =  .Codigo			lxFptoven =  .Puntodeventa			lxFcliente =  .Clientedescripcion			lxEsttrans =  .Estadotransferencia			lxFectrans =  .Fechatransferencia			lxFnumcomp =  .Numero			lxFaltafw =  .Fechaaltafw			lxHaltafw =  .Horaaltafw			lxFmodifw =  .Fechamodificacionfw			lxHmodifw =  .Horamodificacionfw			lxFecimpo =  .Fechaimpo			lxHoraimpo =  .Horaimpo			lxFecexpo =  .Fechaexpo			lxHoraexpo =  .Horaexpo			lxUaltafw =  .Usuarioaltafw			lxUmodifw =  .Usuariomodificacionfw			lxSaltafw =  .Seriealtafw			lxSmodifw =  .Seriemodificacionfw			lxBdaltafw =  .Basededatosaltafw			lxBdmodifw =  .Basededatosmodificacionfw			lxValtafw =  .Versionaltafw			lxVmodifw =  .Versionmodificacionfw			lxReferencia =  .Referencia
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  INFADICIONAL.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.INFADICIONAL set "Codigo" = <<"'" + this.FormatearTextoSql( lxInfadicionalCodigo ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'INFADICIONAL' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Comprobantes
				if this.oEntidad.Comprobantes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipocomprobante = loItem.Tipocomprobante
					lxNroitem = lnContadorNroItem
					lxTipocompcaracter = loItem.Tipocompcaracter
					lxLetra = loItem.Letra
					lxPuntodeventa = loItem.Puntodeventa
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxTotal = loItem.Total
					lxVendedor = loItem.Vendedor
					lxTipo = loItem.Tipo
					lxAfecta = loItem.Afecta
					lxInterviniente = loItem.Interviniente
					lxNombreentidad = loItem.Nombreentidad
					lxCodigoentidad = loItem.Codigoentidad
					lxOrigen = loItem.Origen
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompAfe("AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxTipocomprobante>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  INFADICIONAL.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.INFADICIONAL where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'INFADICIONAL' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.INFADICIONAL where  INFADICIONAL.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.INFADICIONAL where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  INFADICIONAL.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'INFORMACIONADICIONALCOMPVTAS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.INFADICIONAL Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.INFADICIONAL set  Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 Codigo
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.INFADICIONAL ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'INFORMACIONADICIONALCOMPVTAS'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'Codigo','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','Codigo')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CompAfe Where CODIGO] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCOMPROBANTE'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CompAfe ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeComprob ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.afefecha   ) + "'" + ',' + transform( cDetallesExistentes.afetotal   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afevend    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afetipo    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Afecta     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DescInter  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NomInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Origen     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - : ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'INFORMACIONADICIONALCOMPVTAS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMPROBANTE'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_InfAdicional')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'INFORMACIONADICIONALCOMPVTAS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad INFORMACIONADICIONALCOMPVTAS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'INFORMACIONADICIONALCOMPVTAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'INFORMACIONADICIONALCOMPVTAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_InfAdicional') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_InfAdicional
Create Table ZooLogic.TablaTrabajo_InfAdicional ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"ffch" datetime  null, 
"fletra" char( 1 )  null, 
"fperson" char( 10 )  null, 
"zadsfw" varchar(max)  null, 
"fven" char( 10 )  null, 
"codigo" char( 38 )  null, 
"fptoven" numeric( 4, 0 )  null, 
"fcliente" char( 185 )  null, 
"esttrans" char( 20 )  null, 
"fectrans" datetime  null, 
"fnumcomp" numeric( 8, 0 )  null, 
"faltafw" datetime  null, 
"haltafw" char( 8 )  null, 
"fmodifw" datetime  null, 
"hmodifw" char( 8 )  null, 
"fecimpo" datetime  null, 
"horaimpo" char( 8 )  null, 
"fecexpo" datetime  null, 
"horaexpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"referencia" char( 150 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_InfAdicional' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_InfAdicional' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'INFORMACIONADICIONALCOMPVTAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('fven','fven')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('fcliente','fcliente')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('referencia','referencia')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_InfAdicional'
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
				Update t Set t.CODIGO = isnull( d.CODIGO, t.CODIGO )
					from ZooLogic.INFADICIONAL t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.INFADICIONAL(Codigo)
					Select isnull( d.CODIGO,'')
						From deleted d left join ZooLogic.INFADICIONAL pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CompAfe( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_INFADICIONAL_CompAfe
ON ZooLogic.TablaTrabajo_INFADICIONAL_CompAfe
AFTER DELETE
As
Begin
Update t Set 
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AFECOMPROB = isnull( d.AFECOMPROB, t.AFECOMPROB ),
t.AFELETRA = isnull( d.AFELETRA, t.AFELETRA ),
t.AFEPTOVEN = isnull( d.AFEPTOVEN, t.AFEPTOVEN ),
t.AFENUMCOM = isnull( d.AFENUMCOM, t.AFENUMCOM ),
t.AFEFECHA = isnull( d.AFEFECHA, t.AFEFECHA ),
t.AFETOTAL = isnull( d.AFETOTAL, t.AFETOTAL ),
t.AFEVEND = isnull( d.AFEVEND, t.AFEVEND ),
t.AFETIPO = isnull( d.AFETIPO, t.AFETIPO ),
t.AFECTA = isnull( d.AFECTA, t.AFECTA ),
t.DESCINTER = isnull( d.DESCINTER, t.DESCINTER ),
t.NOMINTER = isnull( d.NOMINTER, t.NOMINTER ),
t.CODINTER = isnull( d.CODINTER, t.CODINTER ),
t.ORIGEN = isnull( d.ORIGEN, t.ORIGEN )
from ZooLogic.CompAfe t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CompAfe
( 
"AFETIPOCOM",
"NROITEM",
"CODIGO",
"AFECOMPROB",
"AFELETRA",
"AFEPTOVEN",
"AFENUMCOM",
"AFEFECHA",
"AFETOTAL",
"AFEVEND",
"AFETIPO",
"AFECTA",
"DESCINTER",
"NOMINTER",
"CODINTER",
"ORIGEN"
 )
Select 
d.AFETIPOCOM,
d.NROITEM,
d.CODIGO,
d.AFECOMPROB,
d.AFELETRA,
d.AFEPTOVEN,
d.AFENUMCOM,
d.AFEFECHA,
d.AFETOTAL,
d.AFEVEND,
d.AFETIPO,
d.AFECTA,
d.DESCINTER,
d.NOMINTER,
d.CODINTER,
d.ORIGEN
From deleted d left join ZooLogic.CompAfe pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_InfAdicional') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_InfAdicional
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_INFORMACIONADICIONALCOMPVTAS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Comprobantes.Limpiar()
					.Comprobantes.SetearEsNavegacion( .lProcesando )
					.Comprobantes.Cargar()
					.Codigo = nvl( c_INFORMACIONADICIONALCOMPVTAS.Codigo, [] )
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
		
		loDetalle = this.oEntidad.Comprobantes
		for lnIndex = loDetalle.count to 1 step -1
			if !loDetalle.ValidarExistenciaCamposFijosItemPlano( loDetalle.Item[lnIndex].NroItem )
				loDetalle.Remove( lnIndex )
			endif
		endfor
		
		lnContadorNroItem = 1
		for each loItem in loDetalle foxObject
			loItem.NroItem = lnContadorNroItem
			lnContadorNroItem = lnContadorNroItem + 1
		endfor

	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_INFORMACIONADICIONALCOMPVTAS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.INFADICIONAL' )
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
								from ZooLogic.INFADICIONAL 
								Where   INFADICIONAL.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "INFADICIONAL", "", lcCursor, set("Datasession") )
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
			"Codigo" as "Codigo"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.INFADICIONAL 
								Where   INFADICIONAL.CODIGO != ''
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
	Tabla = 'INFADICIONAL'
	Filtro = " INFADICIONAL.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " INFADICIONAL.CODIGO != ''"
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
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="FECHA                                   " tabla="               " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="10" etiqueta="Fecha de la factura                                                                                                                                             " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="LETRA                                   " tabla="               " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Letra comprobante                                                                                                                                               " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="CLIENTE                                 " tabla="               " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cliente                                                                                                                                                         " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="ZADSFW                                  " tabla="               " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Acciones del sistema                                                                                                                                            " dominio="OBSERVACION4R                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="COMPROBANTES                            " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="5" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="VENDEDOR                                " tabla="               " campo="FVEN      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="CODIGO                                  " tabla="INFADICIONAL   " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="OBSERVACION                             " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="PUNTODEVENTA                            " tabla="               " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Pto. venta                                                                                                                                                      " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="CLIENTEDESCRIPCION                      " tabla="CLI            " campo="FCLIENTE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Cliente.Nombre                                                                                                                                                                                                                                                " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="NROOPECOMMERCE                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Nro. Op. Ecommerce                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="ESTADOTRANSFERENCIA                     " tabla="               " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Estado                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="FECHATRANSFERENCIA                      " tabla="               " campo="FECTRANS  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="NUMERO                                  " tabla="               " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="FECHAALTAFW                             " tabla="               " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Fecha de alta                                                                                                                                                   " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="HORAALTAFW                              " tabla="               " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="FECHAMODIFICACIONFW                     " tabla="               " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Fecha de modificación                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="HORAMODIFICACIONFW                      " tabla="               " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="FECHAIMPO                               " tabla="               " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Fecha de importación                                                                                                                                            " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="HORAIMPO                                " tabla="               " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="FECHAEXPO                               " tabla="               " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Fecha de exportación                                                                                                                                            " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="HORAEXPO                                " tabla="               " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="USUARIOALTAFW                           " tabla="               " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="USUARIOMODIFICACIONFW                   " tabla="               " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="SERIEALTAFW                             " tabla="               " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="SERIEMODIFICACIONFW                     " tabla="               " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="BASEDEDATOSALTAFW                       " tabla="               " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="               " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="VERSIONALTAFW                           " tabla="               " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="VERSIONMODIFICACIONFW                   " tabla="               " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="REFERENCIA                              " tabla="               " campo="REFERENCIA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Referencia                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMACIONADICIONALCOMPVTAS            " atributo="REFERENCIAVIRTUAL                       " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Referencias                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="5" subgrupo="0" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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