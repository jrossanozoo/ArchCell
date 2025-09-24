
define class Din_EntidadFILTRARCOMPROBANTESAINSERTARAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_FILTRARCOMPROBANTESAINSERTAR'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_FCIPK'
	cTablaPrincipal = 'COMPAINS'
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
			local  lxCompainsFaltafw, lxCompainsFectrans, lxCompainsFmodifw, lxCompainsFecimpo, lxCompainsFecexpo, lxCompainsHaltafw, lxCompainsHoraexpo, lxCompainsHmodifw, lxCompainsHoraimpo, lxCompainsVmodifw, lxCompainsZadsfw, lxCompainsValtafw, lxCompainsUmodifw, lxCompainsSmodifw, lxCompainsUaltafw, lxCompainsSaltafw, lxCompainsBdmodifw, lxCompainsBdaltafw, lxCompainsEsttrans, lxCompainsCodigo, lxCompainsDescrip, lxCompainsCliedesde, lxCompainsCliehasta, lxCompainsFecomdesde, lxCompainsFecomhasta, lxCompainsVendesde, lxCompainsVenhasta, lxCompainsNumdesde, lxCompainsNumhasta, lxCompainsMotidesde, lxCompainsMotihasta, lxCompainsTrandesde, lxCompainsTranhasta, lxCompainsObs
				lxCompainsFaltafw =  .Fechaaltafw			lxCompainsFectrans =  .Fechatransferencia			lxCompainsFmodifw =  .Fechamodificacionfw			lxCompainsFecimpo =  .Fechaimpo			lxCompainsFecexpo =  .Fechaexpo			lxCompainsHaltafw =  .Horaaltafw			lxCompainsHoraexpo =  .Horaexpo			lxCompainsHmodifw =  .Horamodificacionfw			lxCompainsHoraimpo =  .Horaimpo			lxCompainsVmodifw =  .Versionmodificacionfw			lxCompainsZadsfw =  .Zadsfw			lxCompainsValtafw =  .Versionaltafw			lxCompainsUmodifw =  .Usuariomodificacionfw			lxCompainsSmodifw =  .Seriemodificacionfw			lxCompainsUaltafw =  .Usuarioaltafw			lxCompainsSaltafw =  .Seriealtafw			lxCompainsBdmodifw =  .Basededatosmodificacionfw			lxCompainsBdaltafw =  .Basededatosaltafw			lxCompainsEsttrans =  .Estadotransferencia			lxCompainsCodigo =  .Codigo			lxCompainsDescrip =  .Descripcion			lxCompainsCliedesde =  upper( .ClienteDesde_PK ) 			lxCompainsCliehasta =  upper( .ClienteHasta_PK ) 			lxCompainsFecomdesde =  .Fechacomprobantedesde			lxCompainsFecomhasta =  .Fechacomprobantehasta			lxCompainsVendesde =  upper( .VendedorDesde_PK ) 			lxCompainsVenhasta =  upper( .VendedorHasta_PK ) 			lxCompainsNumdesde =  .Numerocomprobantedesde			lxCompainsNumhasta =  .Numerocomprobantehasta			lxCompainsMotidesde =  upper( .MotivoDesde_PK ) 			lxCompainsMotihasta =  upper( .MotivoHasta_PK ) 			lxCompainsTrandesde =  upper( .TransportistaDesde_PK ) 			lxCompainsTranhasta =  upper( .TransportistaHasta_PK ) 			lxCompainsObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCompainsCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.COMPAINS ( "Faltafw","Fectrans","Fmodifw","Fecimpo","Fecexpo","Haltafw","Horaexpo","Hmodifw","Horaimpo","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Saltafw","Bdmodifw","Bdaltafw","Esttrans","Codigo","Descrip","Cliedesde","Cliehasta","Fecomdesde","Fecomhasta","Vendesde","Venhasta","Numdesde","Numhasta","Motidesde","Motihasta","Trandesde","Tranhasta","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCompainsFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompainsFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompainsFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompainsFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompainsFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsCliedesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsCliehasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompainsFecomdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompainsFecomhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsVendesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsVenhasta ) + "'" >>, <<lxCompainsNumdesde >>, <<lxCompainsNumhasta >>, <<"'" + this.FormatearTextoSql( lxCompainsMotidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsMotihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsTrandesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsTranhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsObs ) + "'" >> )
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
			local  lxCompainsFaltafw, lxCompainsFectrans, lxCompainsFmodifw, lxCompainsFecimpo, lxCompainsFecexpo, lxCompainsHaltafw, lxCompainsHoraexpo, lxCompainsHmodifw, lxCompainsHoraimpo, lxCompainsVmodifw, lxCompainsZadsfw, lxCompainsValtafw, lxCompainsUmodifw, lxCompainsSmodifw, lxCompainsUaltafw, lxCompainsSaltafw, lxCompainsBdmodifw, lxCompainsBdaltafw, lxCompainsEsttrans, lxCompainsCodigo, lxCompainsDescrip, lxCompainsCliedesde, lxCompainsCliehasta, lxCompainsFecomdesde, lxCompainsFecomhasta, lxCompainsVendesde, lxCompainsVenhasta, lxCompainsNumdesde, lxCompainsNumhasta, lxCompainsMotidesde, lxCompainsMotihasta, lxCompainsTrandesde, lxCompainsTranhasta, lxCompainsObs
				lxCompainsFaltafw =  .Fechaaltafw			lxCompainsFectrans =  .Fechatransferencia			lxCompainsFmodifw =  .Fechamodificacionfw			lxCompainsFecimpo =  .Fechaimpo			lxCompainsFecexpo =  .Fechaexpo			lxCompainsHaltafw =  .Horaaltafw			lxCompainsHoraexpo =  .Horaexpo			lxCompainsHmodifw =  .Horamodificacionfw			lxCompainsHoraimpo =  .Horaimpo			lxCompainsVmodifw =  .Versionmodificacionfw			lxCompainsZadsfw =  .Zadsfw			lxCompainsValtafw =  .Versionaltafw			lxCompainsUmodifw =  .Usuariomodificacionfw			lxCompainsSmodifw =  .Seriemodificacionfw			lxCompainsUaltafw =  .Usuarioaltafw			lxCompainsSaltafw =  .Seriealtafw			lxCompainsBdmodifw =  .Basededatosmodificacionfw			lxCompainsBdaltafw =  .Basededatosaltafw			lxCompainsEsttrans =  .Estadotransferencia			lxCompainsCodigo =  .Codigo			lxCompainsDescrip =  .Descripcion			lxCompainsCliedesde =  upper( .ClienteDesde_PK ) 			lxCompainsCliehasta =  upper( .ClienteHasta_PK ) 			lxCompainsFecomdesde =  .Fechacomprobantedesde			lxCompainsFecomhasta =  .Fechacomprobantehasta			lxCompainsVendesde =  upper( .VendedorDesde_PK ) 			lxCompainsVenhasta =  upper( .VendedorHasta_PK ) 			lxCompainsNumdesde =  .Numerocomprobantedesde			lxCompainsNumhasta =  .Numerocomprobantehasta			lxCompainsMotidesde =  upper( .MotivoDesde_PK ) 			lxCompainsMotihasta =  upper( .MotivoHasta_PK ) 			lxCompainsTrandesde =  upper( .TransportistaDesde_PK ) 			lxCompainsTranhasta =  upper( .TransportistaHasta_PK ) 			lxCompainsObs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.COMPAINS set "Faltafw" = <<"'" + this.ConvertirDateSql( lxCompainsFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCompainsFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCompainsFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCompainsFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCompainsFecexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCompainsHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCompainsHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCompainsHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCompainsHoraimpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCompainsVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCompainsZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCompainsValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCompainsUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCompainsSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCompainsUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCompainsSaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCompainsBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCompainsBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCompainsEsttrans ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCompainsCodigo ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxCompainsDescrip ) + "'">>,"Cliedesde" = <<"'" + this.FormatearTextoSql( lxCompainsCliedesde ) + "'">>,"Cliehasta" = <<"'" + this.FormatearTextoSql( lxCompainsCliehasta ) + "'">>,"Fecomdesde" = <<"'" + this.ConvertirDateSql( lxCompainsFecomdesde ) + "'">>,"Fecomhasta" = <<"'" + this.ConvertirDateSql( lxCompainsFecomhasta ) + "'">>,"Vendesde" = <<"'" + this.FormatearTextoSql( lxCompainsVendesde ) + "'">>,"Venhasta" = <<"'" + this.FormatearTextoSql( lxCompainsVenhasta ) + "'">>,"Numdesde" = <<lxCompainsNumdesde>>,"Numhasta" = <<lxCompainsNumhasta>>,"Motidesde" = <<"'" + this.FormatearTextoSql( lxCompainsMotidesde ) + "'">>,"Motihasta" = <<"'" + this.FormatearTextoSql( lxCompainsMotihasta ) + "'">>,"Trandesde" = <<"'" + this.FormatearTextoSql( lxCompainsTrandesde ) + "'">>,"Tranhasta" = <<"'" + this.FormatearTextoSql( lxCompainsTranhasta ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxCompainsObs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCompainsCodigo ) + "'">> and  COMPAINS.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.COMPAINS where " + this.ConvertirFuncionesSql( " COMPAINS.CODIGO != ''" ) )
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
			Local lxCompainsCodigo
			lxCompainsCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Cliedesde" as "Clientedesde", "Cliehasta" as "Clientehasta", "Fecomdesde" as "Fechacomprobantedesde", "Fecomhasta" as "Fechacomprobantehasta", "Vendesde" as "Vendedordesde", "Venhasta" as "Vendedorhasta", "Numdesde" as "Numerocomprobantedesde", "Numhasta" as "Numerocomprobantehasta", "Motidesde" as "Motivodesde", "Motihasta" as "Motivohasta", "Trandesde" as "Transportistadesde", "Tranhasta" as "Transportistahasta", "Obs" as "Observacion" from ZooLogic.COMPAINS where "Codigo" = <<"'" + this.FormatearTextoSql( lxCompainsCodigo ) + "'">> and  COMPAINS.CODIGO != ''
			endtext
			use in select('c_FILTRARCOMPROBANTESAINSERTAR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FILTRARCOMPROBANTESAINSERTAR', set( 'Datasession' ) )

			if reccount( 'c_FILTRARCOMPROBANTESAINSERTAR' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCompainsCodigo as Variant
		llRetorno = .t.
		lxCompainsCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.COMPAINS where "Codigo" = <<"'" + this.FormatearTextoSql( lxCompainsCodigo ) + "'">> and  COMPAINS.CODIGO != ''
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Cliedesde" as "Clientedesde", "Cliehasta" as "Clientehasta", "Fecomdesde" as "Fechacomprobantedesde", "Fecomhasta" as "Fechacomprobantehasta", "Vendesde" as "Vendedordesde", "Venhasta" as "Vendedorhasta", "Numdesde" as "Numerocomprobantedesde", "Numhasta" as "Numerocomprobantehasta", "Motidesde" as "Motivodesde", "Motihasta" as "Motivohasta", "Trandesde" as "Transportistadesde", "Tranhasta" as "Transportistahasta", "Obs" as "Observacion" from ZooLogic.COMPAINS where  COMPAINS.CODIGO != '' order by Codigo
			endtext
			use in select('c_FILTRARCOMPROBANTESAINSERTAR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FILTRARCOMPROBANTESAINSERTAR', set( 'Datasession' ) )
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Cliedesde" as "Clientedesde", "Cliehasta" as "Clientehasta", "Fecomdesde" as "Fechacomprobantedesde", "Fecomhasta" as "Fechacomprobantehasta", "Vendesde" as "Vendedordesde", "Venhasta" as "Vendedorhasta", "Numdesde" as "Numerocomprobantedesde", "Numhasta" as "Numerocomprobantehasta", "Motidesde" as "Motivodesde", "Motihasta" as "Motivohasta", "Trandesde" as "Transportistadesde", "Tranhasta" as "Transportistahasta", "Obs" as "Observacion" from ZooLogic.COMPAINS where  funciones.padr( Codigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPAINS.CODIGO != '' order by Codigo
			endtext
			use in select('c_FILTRARCOMPROBANTESAINSERTAR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FILTRARCOMPROBANTESAINSERTAR', set( 'Datasession' ) )
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Cliedesde" as "Clientedesde", "Cliehasta" as "Clientehasta", "Fecomdesde" as "Fechacomprobantedesde", "Fecomhasta" as "Fechacomprobantehasta", "Vendesde" as "Vendedordesde", "Venhasta" as "Vendedorhasta", "Numdesde" as "Numerocomprobantedesde", "Numhasta" as "Numerocomprobantehasta", "Motidesde" as "Motivodesde", "Motihasta" as "Motivohasta", "Trandesde" as "Transportistadesde", "Tranhasta" as "Transportistahasta", "Obs" as "Observacion" from ZooLogic.COMPAINS where  funciones.padr( Codigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPAINS.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_FILTRARCOMPROBANTESAINSERTAR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FILTRARCOMPROBANTESAINSERTAR', set( 'Datasession' ) )
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Cliedesde" as "Clientedesde", "Cliehasta" as "Clientehasta", "Fecomdesde" as "Fechacomprobantedesde", "Fecomhasta" as "Fechacomprobantehasta", "Vendesde" as "Vendedordesde", "Venhasta" as "Vendedorhasta", "Numdesde" as "Numerocomprobantedesde", "Numhasta" as "Numerocomprobantehasta", "Motidesde" as "Motivodesde", "Motihasta" as "Motivohasta", "Trandesde" as "Transportistadesde", "Tranhasta" as "Transportistahasta", "Obs" as "Observacion" from ZooLogic.COMPAINS where  COMPAINS.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_FILTRARCOMPROBANTESAINSERTAR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FILTRARCOMPROBANTESAINSERTAR', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Faltafw,Fectrans,Fmodifw,Fecimpo,Fecexpo,Haltafw,Horaexpo,Hmodifw,Horaimpo,Vmodifw,Zadsfw,Va" + ;
"ltafw,Umodifw,Smodifw,Ualtafw,Saltafw,Bdmodifw,Bdaltafw,Esttrans,Codigo,Descrip,Cliedesde,Cliehasta," + ;
"Fecomdesde,Fecomhasta,Vendesde,Venhasta,Numdesde,Numhasta,Motidesde,Motihasta,Trandesde,Tranhasta,Ob" + ;
"s" + ;
" from ZooLogic.COMPAINS where  COMPAINS.CODIGO != '' and " + lcFiltro )
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
			local  lxCompainsFaltafw, lxCompainsFectrans, lxCompainsFmodifw, lxCompainsFecimpo, lxCompainsFecexpo, lxCompainsHaltafw, lxCompainsHoraexpo, lxCompainsHmodifw, lxCompainsHoraimpo, lxCompainsVmodifw, lxCompainsZadsfw, lxCompainsValtafw, lxCompainsUmodifw, lxCompainsSmodifw, lxCompainsUaltafw, lxCompainsSaltafw, lxCompainsBdmodifw, lxCompainsBdaltafw, lxCompainsEsttrans, lxCompainsCodigo, lxCompainsDescrip, lxCompainsCliedesde, lxCompainsCliehasta, lxCompainsFecomdesde, lxCompainsFecomhasta, lxCompainsVendesde, lxCompainsVenhasta, lxCompainsNumdesde, lxCompainsNumhasta, lxCompainsMotidesde, lxCompainsMotihasta, lxCompainsTrandesde, lxCompainsTranhasta, lxCompainsObs
				lxCompainsFaltafw = ctod( '  /  /    ' )			lxCompainsFectrans = ctod( '  /  /    ' )			lxCompainsFmodifw = ctod( '  /  /    ' )			lxCompainsFecimpo = ctod( '  /  /    ' )			lxCompainsFecexpo = ctod( '  /  /    ' )			lxCompainsHaltafw = []			lxCompainsHoraexpo = []			lxCompainsHmodifw = []			lxCompainsHoraimpo = []			lxCompainsVmodifw = []			lxCompainsZadsfw = []			lxCompainsValtafw = []			lxCompainsUmodifw = []			lxCompainsSmodifw = []			lxCompainsUaltafw = []			lxCompainsSaltafw = []			lxCompainsBdmodifw = []			lxCompainsBdaltafw = []			lxCompainsEsttrans = []			lxCompainsCodigo = []			lxCompainsDescrip = []			lxCompainsCliedesde = []			lxCompainsCliehasta = []			lxCompainsFecomdesde = ctod( '  /  /    ' )			lxCompainsFecomhasta = ctod( '  /  /    ' )			lxCompainsVendesde = []			lxCompainsVenhasta = []			lxCompainsNumdesde = 0			lxCompainsNumhasta = 0			lxCompainsMotidesde = []			lxCompainsMotihasta = []			lxCompainsTrandesde = []			lxCompainsTranhasta = []			lxCompainsObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.COMPAINS where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'COMPAINS' + '_' + tcCampo
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
		lcWhere = " Where  COMPAINS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Cliedesde" as "Clientedesde", "Cliehasta" as "Clientehasta", "Fecomdesde" as "Fechacomprobantedesde", "Fecomhasta" as "Fechacomprobantehasta", "Vendesde" as "Vendedordesde", "Venhasta" as "Vendedorhasta", "Numdesde" as "Numerocomprobantedesde", "Numhasta" as "Numerocomprobantehasta", "Motidesde" as "Motivodesde", "Motihasta" as "Motivohasta", "Trandesde" as "Transportistadesde", "Tranhasta" as "Transportistahasta", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COMPAINS', '', tnTope )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'CLIENTEDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIEDESDE AS CLIENTEDESDE'
				Case lcAtributo == 'CLIENTEHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIEHASTA AS CLIENTEHASTA'
				Case lcAtributo == 'FECHACOMPROBANTEDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECOMDESDE AS FECHACOMPROBANTEDESDE'
				Case lcAtributo == 'FECHACOMPROBANTEHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECOMHASTA AS FECHACOMPROBANTEHASTA'
				Case lcAtributo == 'VENDEDORDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDESDE AS VENDEDORDESDE'
				Case lcAtributo == 'VENDEDORHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENHASTA AS VENDEDORHASTA'
				Case lcAtributo == 'NUMEROCOMPROBANTEDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMDESDE AS NUMEROCOMPROBANTEDESDE'
				Case lcAtributo == 'NUMEROCOMPROBANTEHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMHASTA AS NUMEROCOMPROBANTEHASTA'
				Case lcAtributo == 'MOTIVODESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIDESDE AS MOTIVODESDE'
				Case lcAtributo == 'MOTIVOHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIHASTA AS MOTIVOHASTA'
				Case lcAtributo == 'TRANSPORTISTADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRANDESDE AS TRANSPORTISTADESDE'
				Case lcAtributo == 'TRANSPORTISTAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRANHASTA AS TRANSPORTISTAHASTA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESDE'
				lcCampo = 'CLIEDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEHASTA'
				lcCampo = 'CLIEHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMPROBANTEDESDE'
				lcCampo = 'FECOMDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMPROBANTEHASTA'
				lcCampo = 'FECOMHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDORDESDE'
				lcCampo = 'VENDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDORHASTA'
				lcCampo = 'VENHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCOMPROBANTEDESDE'
				lcCampo = 'NUMDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCOMPROBANTEHASTA'
				lcCampo = 'NUMHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVODESDE'
				lcCampo = 'MOTIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVOHASTA'
				lcCampo = 'MOTIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'TRANSPORTISTADESDE'
				lcCampo = 'TRANDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'TRANSPORTISTAHASTA'
				lcCampo = 'TRANHASTA'
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
			local  lxCompainsFaltafw, lxCompainsFectrans, lxCompainsFmodifw, lxCompainsFecimpo, lxCompainsFecexpo, lxCompainsHaltafw, lxCompainsHoraexpo, lxCompainsHmodifw, lxCompainsHoraimpo, lxCompainsVmodifw, lxCompainsZadsfw, lxCompainsValtafw, lxCompainsUmodifw, lxCompainsSmodifw, lxCompainsUaltafw, lxCompainsSaltafw, lxCompainsBdmodifw, lxCompainsBdaltafw, lxCompainsEsttrans, lxCompainsCodigo, lxCompainsDescrip, lxCompainsCliedesde, lxCompainsCliehasta, lxCompainsFecomdesde, lxCompainsFecomhasta, lxCompainsVendesde, lxCompainsVenhasta, lxCompainsNumdesde, lxCompainsNumhasta, lxCompainsMotidesde, lxCompainsMotihasta, lxCompainsTrandesde, lxCompainsTranhasta, lxCompainsObs
				lxCompainsFaltafw =  .Fechaaltafw			lxCompainsFectrans =  .Fechatransferencia			lxCompainsFmodifw =  .Fechamodificacionfw			lxCompainsFecimpo =  .Fechaimpo			lxCompainsFecexpo =  .Fechaexpo			lxCompainsHaltafw =  .Horaaltafw			lxCompainsHoraexpo =  .Horaexpo			lxCompainsHmodifw =  .Horamodificacionfw			lxCompainsHoraimpo =  .Horaimpo			lxCompainsVmodifw =  .Versionmodificacionfw			lxCompainsZadsfw =  .Zadsfw			lxCompainsValtafw =  .Versionaltafw			lxCompainsUmodifw =  .Usuariomodificacionfw			lxCompainsSmodifw =  .Seriemodificacionfw			lxCompainsUaltafw =  .Usuarioaltafw			lxCompainsSaltafw =  .Seriealtafw			lxCompainsBdmodifw =  .Basededatosmodificacionfw			lxCompainsBdaltafw =  .Basededatosaltafw			lxCompainsEsttrans =  .Estadotransferencia			lxCompainsCodigo =  .Codigo			lxCompainsDescrip =  .Descripcion			lxCompainsCliedesde =  upper( .ClienteDesde_PK ) 			lxCompainsCliehasta =  upper( .ClienteHasta_PK ) 			lxCompainsFecomdesde =  .Fechacomprobantedesde			lxCompainsFecomhasta =  .Fechacomprobantehasta			lxCompainsVendesde =  upper( .VendedorDesde_PK ) 			lxCompainsVenhasta =  upper( .VendedorHasta_PK ) 			lxCompainsNumdesde =  .Numerocomprobantedesde			lxCompainsNumhasta =  .Numerocomprobantehasta			lxCompainsMotidesde =  upper( .MotivoDesde_PK ) 			lxCompainsMotihasta =  upper( .MotivoHasta_PK ) 			lxCompainsTrandesde =  upper( .TransportistaDesde_PK ) 			lxCompainsTranhasta =  upper( .TransportistaHasta_PK ) 			lxCompainsObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.COMPAINS ( "Faltafw","Fectrans","Fmodifw","Fecimpo","Fecexpo","Haltafw","Horaexpo","Hmodifw","Horaimpo","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Saltafw","Bdmodifw","Bdaltafw","Esttrans","Codigo","Descrip","Cliedesde","Cliehasta","Fecomdesde","Fecomhasta","Vendesde","Venhasta","Numdesde","Numhasta","Motidesde","Motihasta","Trandesde","Tranhasta","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCompainsFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompainsFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompainsFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompainsFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompainsFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsCliedesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsCliehasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompainsFecomdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompainsFecomhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsVendesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsVenhasta ) + "'" >>, <<lxCompainsNumdesde >>, <<lxCompainsNumhasta >>, <<"'" + this.FormatearTextoSql( lxCompainsMotidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsMotihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsTrandesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsTranhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompainsObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'COMPAINS' 
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
			local  lxCompainsFaltafw, lxCompainsFectrans, lxCompainsFmodifw, lxCompainsFecimpo, lxCompainsFecexpo, lxCompainsHaltafw, lxCompainsHoraexpo, lxCompainsHmodifw, lxCompainsHoraimpo, lxCompainsVmodifw, lxCompainsZadsfw, lxCompainsValtafw, lxCompainsUmodifw, lxCompainsSmodifw, lxCompainsUaltafw, lxCompainsSaltafw, lxCompainsBdmodifw, lxCompainsBdaltafw, lxCompainsEsttrans, lxCompainsCodigo, lxCompainsDescrip, lxCompainsCliedesde, lxCompainsCliehasta, lxCompainsFecomdesde, lxCompainsFecomhasta, lxCompainsVendesde, lxCompainsVenhasta, lxCompainsNumdesde, lxCompainsNumhasta, lxCompainsMotidesde, lxCompainsMotihasta, lxCompainsTrandesde, lxCompainsTranhasta, lxCompainsObs
				lxCompainsFaltafw =  .Fechaaltafw			lxCompainsFectrans =  .Fechatransferencia			lxCompainsFmodifw =  .Fechamodificacionfw			lxCompainsFecimpo =  .Fechaimpo			lxCompainsFecexpo =  .Fechaexpo			lxCompainsHaltafw =  .Horaaltafw			lxCompainsHoraexpo =  .Horaexpo			lxCompainsHmodifw =  .Horamodificacionfw			lxCompainsHoraimpo =  .Horaimpo			lxCompainsVmodifw =  .Versionmodificacionfw			lxCompainsZadsfw =  .Zadsfw			lxCompainsValtafw =  .Versionaltafw			lxCompainsUmodifw =  .Usuariomodificacionfw			lxCompainsSmodifw =  .Seriemodificacionfw			lxCompainsUaltafw =  .Usuarioaltafw			lxCompainsSaltafw =  .Seriealtafw			lxCompainsBdmodifw =  .Basededatosmodificacionfw			lxCompainsBdaltafw =  .Basededatosaltafw			lxCompainsEsttrans =  .Estadotransferencia			lxCompainsCodigo =  .Codigo			lxCompainsDescrip =  .Descripcion			lxCompainsCliedesde =  upper( .ClienteDesde_PK ) 			lxCompainsCliehasta =  upper( .ClienteHasta_PK ) 			lxCompainsFecomdesde =  .Fechacomprobantedesde			lxCompainsFecomhasta =  .Fechacomprobantehasta			lxCompainsVendesde =  upper( .VendedorDesde_PK ) 			lxCompainsVenhasta =  upper( .VendedorHasta_PK ) 			lxCompainsNumdesde =  .Numerocomprobantedesde			lxCompainsNumhasta =  .Numerocomprobantehasta			lxCompainsMotidesde =  upper( .MotivoDesde_PK ) 			lxCompainsMotihasta =  upper( .MotivoHasta_PK ) 			lxCompainsTrandesde =  upper( .TransportistaDesde_PK ) 			lxCompainsTranhasta =  upper( .TransportistaHasta_PK ) 			lxCompainsObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPAINS.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.COMPAINS set "Faltafw" = <<"'" + this.ConvertirDateSql( lxCompainsFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCompainsFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCompainsFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCompainsFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCompainsFecexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCompainsHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCompainsHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCompainsHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCompainsHoraimpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCompainsVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCompainsZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCompainsValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCompainsUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCompainsSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCompainsUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCompainsSaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCompainsBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCompainsBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCompainsEsttrans ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCompainsCodigo ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxCompainsDescrip ) + "'">>, "Cliedesde" = <<"'" + this.FormatearTextoSql( lxCompainsCliedesde ) + "'">>, "Cliehasta" = <<"'" + this.FormatearTextoSql( lxCompainsCliehasta ) + "'">>, "Fecomdesde" = <<"'" + this.ConvertirDateSql( lxCompainsFecomdesde ) + "'">>, "Fecomhasta" = <<"'" + this.ConvertirDateSql( lxCompainsFecomhasta ) + "'">>, "Vendesde" = <<"'" + this.FormatearTextoSql( lxCompainsVendesde ) + "'">>, "Venhasta" = <<"'" + this.FormatearTextoSql( lxCompainsVenhasta ) + "'">>, "Numdesde" = <<lxCompainsNumdesde>>, "Numhasta" = <<lxCompainsNumhasta>>, "Motidesde" = <<"'" + this.FormatearTextoSql( lxCompainsMotidesde ) + "'">>, "Motihasta" = <<"'" + this.FormatearTextoSql( lxCompainsMotihasta ) + "'">>, "Trandesde" = <<"'" + this.FormatearTextoSql( lxCompainsTrandesde ) + "'">>, "Tranhasta" = <<"'" + this.FormatearTextoSql( lxCompainsTranhasta ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxCompainsObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COMPAINS' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPAINS.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.COMPAINS where ' + lcFiltro )
			loColeccion.cTabla = 'COMPAINS' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.COMPAINS where  COMPAINS.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.COMPAINS where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  COMPAINS.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'FILTRARCOMPROBANTESAINSERTAR'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.COMPAINS Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.COMPAINS set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, ClieDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ClieDesde ) + "'"+ [, ClieHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ClieHasta ) + "'"+ [, FeComDesde = ] + "'" + this.ConvertirDateSql( &lcCursor..FeComDesde ) + "'"+ [, FeComHasta = ] + "'" + this.ConvertirDateSql( &lcCursor..FeComHasta ) + "'"+ [, VenDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..VenDesde ) + "'"+ [, VenHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..VenHasta ) + "'"+ [, NumDesde = ] + transform( &lcCursor..NumDesde )+ [, NumHasta = ] + transform( &lcCursor..NumHasta )+ [, MotiDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..MotiDesde ) + "'"+ [, MotiHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..MotiHasta ) + "'"+ [, TranDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TranDesde ) + "'"+ [, TranHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TranHasta ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FALTAFW, FECTRANS, FMODIFW, FECIMPO, FECEXPO, HALTAFW, HORAEXPO, HMODIFW, HORAIMPO, VMODIFW, ZADSFW, VALTAFW, UMODIFW, SMODIFW, UALTAFW, SALTAFW, BDMODIFW, BDALTAFW, ESTTRANS, Codigo, Descrip, ClieDesde, ClieHasta, FeComDesde, FeComHasta, VenDesde, VenHasta, NumDesde, NumHasta, MotiDesde, MotiHasta, TranDesde, TranHasta, Obs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClieDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClieHasta ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FeComDesde ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FeComHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VenDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VenHasta ) + "'" + ',' + transform( &lcCursor..NumDesde )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..NumHasta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..MotiDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MotiHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TranDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TranHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.COMPAINS ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'FILTRARCOMPROBANTESAINSERTAR'
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
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'FILTRARCOMPROBANTESAINSERTAR'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'FILTRARCOMPROBANTESAINSERTAR_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'FILTRARCOMPROBANTESAINSERTAR_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_COMPAINS')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'FILTRARCOMPROBANTESAINSERTAR'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad FILTRARCOMPROBANTESAINSERTAR. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FILTRARCOMPROBANTESAINSERTAR'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FILTRARCOMPROBANTESAINSERTAR'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FeComDesde
		* Validar ANTERIORES A 1/1/1753  FeComHasta
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COMPAINS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COMPAINS
Create Table ZooLogic.TablaTrabajo_COMPAINS ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"codigo" char( 38 )  null, 
"descrip" char( 1 )  null, 
"cliedesde" char( 5 )  null, 
"cliehasta" char( 5 )  null, 
"fecomdesde" datetime  null, 
"fecomhasta" datetime  null, 
"vendesde" char( 5 )  null, 
"venhasta" char( 5 )  null, 
"numdesde" numeric( 8, 0 )  null, 
"numhasta" numeric( 8, 0 )  null, 
"motidesde" char( 3 )  null, 
"motihasta" char( 3 )  null, 
"trandesde" char( 6 )  null, 
"tranhasta" char( 6 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_COMPAINS' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_COMPAINS' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FILTRARCOMPROBANTESAINSERTAR'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('cliedesde','cliedesde')
			.AgregarMapeo('cliehasta','cliehasta')
			.AgregarMapeo('fecomdesde','fecomdesde')
			.AgregarMapeo('fecomhasta','fecomhasta')
			.AgregarMapeo('vendesde','vendesde')
			.AgregarMapeo('venhasta','venhasta')
			.AgregarMapeo('numdesde','numdesde')
			.AgregarMapeo('numhasta','numhasta')
			.AgregarMapeo('motidesde','motidesde')
			.AgregarMapeo('motihasta','motihasta')
			.AgregarMapeo('trandesde','trandesde')
			.AgregarMapeo('tranhasta','tranhasta')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_COMPAINS'
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
				Update t Set t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.CLIEDESDE = isnull( d.CLIEDESDE, t.CLIEDESDE ),t.CLIEHASTA = isnull( d.CLIEHASTA, t.CLIEHASTA ),t.FECOMDESDE = isnull( d.FECOMDESDE, t.FECOMDESDE ),t.FECOMHASTA = isnull( d.FECOMHASTA, t.FECOMHASTA ),t.VENDESDE = isnull( d.VENDESDE, t.VENDESDE ),t.VENHASTA = isnull( d.VENHASTA, t.VENHASTA ),t.NUMDESDE = isnull( d.NUMDESDE, t.NUMDESDE ),t.NUMHASTA = isnull( d.NUMHASTA, t.NUMHASTA ),t.MOTIDESDE = isnull( d.MOTIDESDE, t.MOTIDESDE ),t.MOTIHASTA = isnull( d.MOTIHASTA, t.MOTIHASTA ),t.TRANDESDE = isnull( d.TRANDESDE, t.TRANDESDE ),t.TRANHASTA = isnull( d.TRANHASTA, t.TRANHASTA ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.COMPAINS t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.COMPAINS(Faltafw,Fectrans,Fmodifw,Fecimpo,Fecexpo,Haltafw,Horaexpo,Hmodifw,Horaimpo,Vmodifw,Zadsfw,Valtafw,Umodifw,Smodifw,Ualtafw,Saltafw,Bdmodifw,Bdaltafw,Esttrans,Codigo,Descrip,Cliedesde,Cliehasta,Fecomdesde,Fecomhasta,Vendesde,Venhasta,Numdesde,Numhasta,Motidesde,Motihasta,Trandesde,Tranhasta,Obs)
					Select CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.CODIGO,''),isnull( d.DESCRIP,''),isnull( d.CLIEDESDE,''),isnull( d.CLIEHASTA,''),isnull( d.FECOMDESDE,''),isnull( d.FECOMHASTA,''),isnull( d.VENDESDE,''),isnull( d.VENHASTA,''),isnull( d.NUMDESDE,0),isnull( d.NUMHASTA,0),isnull( d.MOTIDESDE,''),isnull( d.MOTIHASTA,''),isnull( d.TRANDESDE,''),isnull( d.TRANHASTA,''),isnull( d.OBS,'')
						From deleted d left join ZooLogic.COMPAINS pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COMPAINS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COMPAINS
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_FILTRARCOMPROBANTESAINSERTAR' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARCOMPROBANTESAINSERTAR.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARCOMPROBANTESAINSERTAR.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARCOMPROBANTESAINSERTAR.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARCOMPROBANTESAINSERTAR.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARCOMPROBANTESAINSERTAR.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_FILTRARCOMPROBANTESAINSERTAR.Horaaltafw, [] )
					.Horaexpo = nvl( c_FILTRARCOMPROBANTESAINSERTAR.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_FILTRARCOMPROBANTESAINSERTAR.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_FILTRARCOMPROBANTESAINSERTAR.Horaimpo, [] )
					.Versionmodificacionfw = nvl( c_FILTRARCOMPROBANTESAINSERTAR.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_FILTRARCOMPROBANTESAINSERTAR.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_FILTRARCOMPROBANTESAINSERTAR.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_FILTRARCOMPROBANTESAINSERTAR.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_FILTRARCOMPROBANTESAINSERTAR.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_FILTRARCOMPROBANTESAINSERTAR.Seriealtafw, [] )
					.Basededatosmodificacionfw = nvl( c_FILTRARCOMPROBANTESAINSERTAR.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_FILTRARCOMPROBANTESAINSERTAR.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_FILTRARCOMPROBANTESAINSERTAR.Estadotransferencia, [] )
					.Codigo = nvl( c_FILTRARCOMPROBANTESAINSERTAR.Codigo, [] )
					.Descripcion = nvl( c_FILTRARCOMPROBANTESAINSERTAR.Descripcion, [] )
					.Clientedesde_PK =  nvl( c_FILTRARCOMPROBANTESAINSERTAR.Clientedesde, [] )
					.Clientehasta_PK =  nvl( c_FILTRARCOMPROBANTESAINSERTAR.Clientehasta, [] )
					.Fechacomprobantedesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARCOMPROBANTESAINSERTAR.Fechacomprobantedesde, ctod( '  /  /    ' ) ) )
					.Fechacomprobantehasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARCOMPROBANTESAINSERTAR.Fechacomprobantehasta, ctod( '  /  /    ' ) ) )
					.Vendedordesde_PK =  nvl( c_FILTRARCOMPROBANTESAINSERTAR.Vendedordesde, [] )
					.Vendedorhasta_PK =  nvl( c_FILTRARCOMPROBANTESAINSERTAR.Vendedorhasta, [] )
					.Numerocomprobantedesde = nvl( c_FILTRARCOMPROBANTESAINSERTAR.Numerocomprobantedesde, 0 )
					.Numerocomprobantehasta = nvl( c_FILTRARCOMPROBANTESAINSERTAR.Numerocomprobantehasta, 0 )
					.Motivodesde_PK =  nvl( c_FILTRARCOMPROBANTESAINSERTAR.Motivodesde, [] )
					.Motivohasta_PK =  nvl( c_FILTRARCOMPROBANTESAINSERTAR.Motivohasta, [] )
					.Transportistadesde_PK =  nvl( c_FILTRARCOMPROBANTESAINSERTAR.Transportistadesde, [] )
					.Transportistahasta_PK =  nvl( c_FILTRARCOMPROBANTESAINSERTAR.Transportistahasta, [] )
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
		return c_FILTRARCOMPROBANTESAINSERTAR.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.COMPAINS' )
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
								from ZooLogic.COMPAINS 
								Where   COMPAINS.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "COMPAINS", "", lcCursor, set("Datasession") )
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
			"Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Cliedesde" as "Clientedesde", "Cliehasta" as "Clientehasta", "Fecomdesde" as "Fechacomprobantedesde", "Fecomhasta" as "Fechacomprobantehasta", "Vendesde" as "Vendedordesde", "Venhasta" as "Vendedorhasta", "Numdesde" as "Numerocomprobantedesde", "Numhasta" as "Numerocomprobantehasta", "Motidesde" as "Motivodesde", "Motihasta" as "Motivohasta", "Trandesde" as "Transportistadesde", "Tranhasta" as "Transportistahasta", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.COMPAINS 
								Where   COMPAINS.CODIGO != ''
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
	Tabla = 'COMPAINS'
	Filtro = " COMPAINS.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " COMPAINS.CODIGO != ''"
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
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="FECHAALTAFW                             " tabla="COMPAINS       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="FECHATRANSFERENCIA                      " tabla="COMPAINS       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="FECHAMODIFICACIONFW                     " tabla="COMPAINS       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="FECHAIMPO                               " tabla="COMPAINS       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="FECHAEXPO                               " tabla="COMPAINS       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="HORAALTAFW                              " tabla="COMPAINS       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="HORAEXPO                                " tabla="COMPAINS       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="HORAMODIFICACIONFW                      " tabla="COMPAINS       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="HORAIMPO                                " tabla="COMPAINS       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="VERSIONMODIFICACIONFW                   " tabla="COMPAINS       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="ZADSFW                                  " tabla="COMPAINS       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="VERSIONALTAFW                           " tabla="COMPAINS       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="USUARIOMODIFICACIONFW                   " tabla="COMPAINS       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="SERIEMODIFICACIONFW                     " tabla="COMPAINS       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="USUARIOALTAFW                           " tabla="COMPAINS       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="SERIEALTAFW                             " tabla="COMPAINS       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COMPAINS       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="BASEDEDATOSALTAFW                       " tabla="COMPAINS       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="ESTADOTRANSFERENCIA                     " tabla="COMPAINS       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="CODIGO                                  " tabla="COMPAINS       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="DESCRIPCION                             " tabla="COMPAINS       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="CLIENTEDESDE                            " tabla="COMPAINS       " campo="CLIEDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Cliente desde                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="CLIENTEHASTA                            " tabla="COMPAINS       " campo="CLIEHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="402" etiqueta="Cliente hasta                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="FECHACOMPROBANTEDESDE                   " tabla="COMPAINS       " campo="FECOMDESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Fecha de comprobante desde                                                                                                                                      " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="35" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="FECHACOMPROBANTEHASTA                   " tabla="COMPAINS       " campo="FECOMHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="406" etiqueta="Fecha de comprobante hasta                                                                                                                                      " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="VENDEDORDESDE                           " tabla="COMPAINS       " campo="VENDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Vendedor desde                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="55" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="VENDEDORHASTA                           " tabla="COMPAINS       " campo="VENHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="410" etiqueta="Vendedor hasta                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="NUMEROCOMPROBANTEDESDE                  " tabla="COMPAINS       " campo="NUMDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Número de comprobante desde                                                                                                                                     " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="65" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="NUMEROCOMPROBANTEHASTA                  " tabla="COMPAINS       " campo="NUMHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="99999999                                                                                                                                                                                                                                                      " obligatorio="false" admitebusqueda="414" etiqueta="Número de comprobante hasta                                                                                                                                     " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="70" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="MOTIVODESDE                             " tabla="COMPAINS       " campo="MOTIDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVO                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Motivo desde                                                                                                                                                    " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="75" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="MOTIVOHASTA                             " tabla="COMPAINS       " campo="MOTIHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVO                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="ZZZ                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="0" etiqueta="Motivo hasta                                                                                                                                                    " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="80" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="TRANSPORTISTADESDE                      " tabla="COMPAINS       " campo="TRANDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TRANSPORTISTA                           " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Transportista desde                                                                                                                                             " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="85" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="TRANSPORTISTAHASTA                      " tabla="COMPAINS       " campo="TRANHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TRANSPORTISTA                           " tipodato="C         " longitud="6" decimales="0" valorsugerido="ZZZZZZZZZZZZZZZ                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="0" etiqueta="Transportista hasta                                                                                                                                             " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="90" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESAINSERTAR            " atributo="OBSERVACION                             " tabla="COMPAINS       " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="99" subgrupo="99" orden="99" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="401" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On COMPAINS.CLIEDESDE = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="403" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On COMPAINS.CLIEHASTA = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On COMPAINS.VENDESDE = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On COMPAINS.VENHASTA = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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