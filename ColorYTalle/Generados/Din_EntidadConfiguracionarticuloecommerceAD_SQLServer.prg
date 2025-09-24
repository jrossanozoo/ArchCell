
define class Din_EntidadCONFIGURACIONARTICULOECOMMERCEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CONFIGURACIONARTICULOECOMMERCE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_CEDPK'
	cTablaPrincipal = 'CFGARTECOM'
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
			local  lxCfgartecomFecexpo, lxCfgartecomFectrans, lxCfgartecomFecimpo, lxCfgartecomFaltafw, lxCfgartecomFmodifw, lxCfgartecomSmodifw, lxCfgartecomHmodifw, lxCfgartecomSaltafw, lxCfgartecomUaltafw, lxCfgartecomUmodifw, lxCfgartecomZadsfw, lxCfgartecomValtafw, lxCfgartecomVmodifw, lxCfgartecomHoraimpo, lxCfgartecomHaltafw, lxCfgartecomHoraexpo, lxCfgartecomBdmodifw, lxCfgartecomEsttrans, lxCfgartecomBdaltafw, lxCfgartecomCodigo, lxCfgartecomArtic, lxCfgartecomObs
				lxCfgartecomFecexpo =  .Fechaexpo			lxCfgartecomFectrans =  .Fechatransferencia			lxCfgartecomFecimpo =  .Fechaimpo			lxCfgartecomFaltafw =  .Fechaaltafw			lxCfgartecomFmodifw =  .Fechamodificacionfw			lxCfgartecomSmodifw =  .Seriemodificacionfw			lxCfgartecomHmodifw =  .Horamodificacionfw			lxCfgartecomSaltafw =  .Seriealtafw			lxCfgartecomUaltafw =  .Usuarioaltafw			lxCfgartecomUmodifw =  .Usuariomodificacionfw			lxCfgartecomZadsfw =  .Zadsfw			lxCfgartecomValtafw =  .Versionaltafw			lxCfgartecomVmodifw =  .Versionmodificacionfw			lxCfgartecomHoraimpo =  .Horaimpo			lxCfgartecomHaltafw =  .Horaaltafw			lxCfgartecomHoraexpo =  .Horaexpo			lxCfgartecomBdmodifw =  .Basededatosmodificacionfw			lxCfgartecomEsttrans =  .Estadotransferencia			lxCfgartecomBdaltafw =  .Basededatosaltafw			lxCfgartecomCodigo =  .Codigo			lxCfgartecomArtic =  upper( .Articulo_PK ) 			lxCfgartecomObs =  .Obs
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCfgartecomCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CFGARTECOM ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Smodifw","Hmodifw","Saltafw","Ualtafw","Umodifw","Zadsfw","Valtafw","Vmodifw","Horaimpo","Haltafw","Horaexpo","Bdmodifw","Esttrans","Bdaltafw","Codigo","Artic","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCfgartecomFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCfgartecomFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCfgartecomFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCfgartecomFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCfgartecomFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomArtic ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomObs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CategoriasEcom
				if this.oEntidad.CategoriasEcom.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodcategoria_PK = loItem.Codcategoria_PK
					lxDesccategoria = loItem.Desccategoria
					lxPlataforma_PK = loItem.Plataforma_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CfgArtEcomCat("NROITEM","Codigo","CodCat","DescCat","PlatafCat" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodcategoria_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDesccategoria ) + "'">>, <<"'" + this.FormatearTextoSql( lxPlataforma_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.EtiquetasEcom
				if this.oEntidad.EtiquetasEcom.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodetiqueta_PK = loItem.Codetiqueta_PK
					lxDescetiqueta = loItem.Descetiqueta
					lxPlataforma_PK = loItem.Plataforma_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CfgArtEcomEti("NROITEM","Codigo","CodEti","DescEti","PlatafEti" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodetiqueta_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescetiqueta ) + "'">>, <<"'" + this.FormatearTextoSql( lxPlataforma_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DimensionesEcom
				if this.oEntidad.DimensionesEcom.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxPeso = loItem.Peso
					lxLargo = loItem.Largo
					lxAncho = loItem.Ancho
					lxAlto = loItem.Alto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CfgArtEcomDim("NROITEM","Codigo","codColor","ColorDet","Talle","Peso","Largo","Ancho","Alto" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxPeso>>, <<lxLargo>>, <<lxAncho>>, <<lxAlto>> ) 
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
			local  lxCfgartecomFecexpo, lxCfgartecomFectrans, lxCfgartecomFecimpo, lxCfgartecomFaltafw, lxCfgartecomFmodifw, lxCfgartecomSmodifw, lxCfgartecomHmodifw, lxCfgartecomSaltafw, lxCfgartecomUaltafw, lxCfgartecomUmodifw, lxCfgartecomZadsfw, lxCfgartecomValtafw, lxCfgartecomVmodifw, lxCfgartecomHoraimpo, lxCfgartecomHaltafw, lxCfgartecomHoraexpo, lxCfgartecomBdmodifw, lxCfgartecomEsttrans, lxCfgartecomBdaltafw, lxCfgartecomCodigo, lxCfgartecomArtic, lxCfgartecomObs
				lxCfgartecomFecexpo =  .Fechaexpo			lxCfgartecomFectrans =  .Fechatransferencia			lxCfgartecomFecimpo =  .Fechaimpo			lxCfgartecomFaltafw =  .Fechaaltafw			lxCfgartecomFmodifw =  .Fechamodificacionfw			lxCfgartecomSmodifw =  .Seriemodificacionfw			lxCfgartecomHmodifw =  .Horamodificacionfw			lxCfgartecomSaltafw =  .Seriealtafw			lxCfgartecomUaltafw =  .Usuarioaltafw			lxCfgartecomUmodifw =  .Usuariomodificacionfw			lxCfgartecomZadsfw =  .Zadsfw			lxCfgartecomValtafw =  .Versionaltafw			lxCfgartecomVmodifw =  .Versionmodificacionfw			lxCfgartecomHoraimpo =  .Horaimpo			lxCfgartecomHaltafw =  .Horaaltafw			lxCfgartecomHoraexpo =  .Horaexpo			lxCfgartecomBdmodifw =  .Basededatosmodificacionfw			lxCfgartecomEsttrans =  .Estadotransferencia			lxCfgartecomBdaltafw =  .Basededatosaltafw			lxCfgartecomCodigo =  .Codigo			lxCfgartecomArtic =  upper( .Articulo_PK ) 			lxCfgartecomObs =  .Obs
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CFGARTECOM set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCfgartecomFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCfgartecomFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCfgartecomFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCfgartecomFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCfgartecomFmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCfgartecomSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCfgartecomHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCfgartecomSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCfgartecomUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCfgartecomUmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCfgartecomZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCfgartecomValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCfgartecomVmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCfgartecomHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCfgartecomHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCfgartecomHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCfgartecomBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCfgartecomEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCfgartecomBdaltafw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCfgartecomCodigo ) + "'">>,"Artic" = <<"'" + this.FormatearTextoSql( lxCfgartecomArtic ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxCfgartecomObs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCfgartecomCodigo ) + "'">> and  CFGARTECOM.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CfgArtEcomCat where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CfgArtEcomEti where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CfgArtEcomDim where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CategoriasEcom
				if this.oEntidad.CategoriasEcom.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodcategoria_PK = loItem.Codcategoria_PK
					lxDesccategoria = loItem.Desccategoria
					lxPlataforma_PK = loItem.Plataforma_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CfgArtEcomCat("NROITEM","Codigo","CodCat","DescCat","PlatafCat" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodcategoria_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDesccategoria ) + "'">>, <<"'" + this.FormatearTextoSql( lxPlataforma_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.EtiquetasEcom
				if this.oEntidad.EtiquetasEcom.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodetiqueta_PK = loItem.Codetiqueta_PK
					lxDescetiqueta = loItem.Descetiqueta
					lxPlataforma_PK = loItem.Plataforma_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CfgArtEcomEti("NROITEM","Codigo","CodEti","DescEti","PlatafEti" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodetiqueta_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescetiqueta ) + "'">>, <<"'" + this.FormatearTextoSql( lxPlataforma_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DimensionesEcom
				if this.oEntidad.DimensionesEcom.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxPeso = loItem.Peso
					lxLargo = loItem.Largo
					lxAncho = loItem.Ancho
					lxAlto = loItem.Alto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CfgArtEcomDim("NROITEM","Codigo","codColor","ColorDet","Talle","Peso","Largo","Ancho","Alto" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxPeso>>, <<lxLargo>>, <<lxAncho>>, <<lxAlto>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.CFGARTECOM where " + this.ConvertirFuncionesSql( " CFGARTECOM.CODIGO != ''" ) )
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
			Local lxCfgartecomCodigo
			lxCfgartecomCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Artic" as "Articulo", "Obs" as "Obs" from ZooLogic.CFGARTECOM where "Codigo" = <<"'" + this.FormatearTextoSql( lxCfgartecomCodigo ) + "'">> and  CFGARTECOM.CODIGO != ''
			endtext
			use in select('c_CONFIGURACIONARTICULOECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONFIGURACIONARTICULOECOMMERCE', set( 'Datasession' ) )

			if reccount( 'c_CONFIGURACIONARTICULOECOMMERCE' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codcat" as "Codcategoria", "Desccat" as "Desccategoria", "Platafcat" as "Plataforma" from ZooLogic.CfgArtEcomCat where Codigo = <<"'" + this.FormatearTextoSql( c_CONFIGURACIONARTICULOECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CategoriasEcom')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CategoriasEcom', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CategoriasEcom
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codeti" as "Codetiqueta", "Desceti" as "Descetiqueta", "Platafeti" as "Plataforma" from ZooLogic.CfgArtEcomEti where Codigo = <<"'" + this.FormatearTextoSql( c_CONFIGURACIONARTICULOECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_EtiquetasEcom')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EtiquetasEcom', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_EtiquetasEcom
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codcolor" as "Color", "Colordet" as "Colordetalle", "Talle" as "Talle", "Peso" as "Peso", "Largo" as "Largo", "Ancho" as "Ancho", "Alto" as "Alto" from ZooLogic.CfgArtEcomDim where Codigo = <<"'" + this.FormatearTextoSql( c_CONFIGURACIONARTICULOECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DimensionesEcom')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DimensionesEcom', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DimensionesEcom
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCfgartecomCodigo as Variant
		llRetorno = .t.
		lxCfgartecomCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CFGARTECOM where "Codigo" = <<"'" + this.FormatearTextoSql( lxCfgartecomCodigo ) + "'">> and  CFGARTECOM.CODIGO != ''
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
				lcOrden =  .Articulo_PK + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Artic" as "Articulo", "Obs" as "Obs" from ZooLogic.CFGARTECOM where  CFGARTECOM.CODIGO != '' order by Artic,Codigo
			endtext
			use in select('c_CONFIGURACIONARTICULOECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONFIGURACIONARTICULOECOMMERCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codcat" as "Codcategoria", "Desccat" as "Desccategoria", "Platafcat" as "Plataforma" from ZooLogic.CfgArtEcomCat where Codigo = <<"'" + this.FormatearTextoSql( c_CONFIGURACIONARTICULOECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CategoriasEcom')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CategoriasEcom', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CategoriasEcom
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codeti" as "Codetiqueta", "Desceti" as "Descetiqueta", "Platafeti" as "Plataforma" from ZooLogic.CfgArtEcomEti where Codigo = <<"'" + this.FormatearTextoSql( c_CONFIGURACIONARTICULOECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_EtiquetasEcom')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EtiquetasEcom', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_EtiquetasEcom
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codcolor" as "Color", "Colordet" as "Colordetalle", "Talle" as "Talle", "Peso" as "Peso", "Largo" as "Largo", "Ancho" as "Ancho", "Alto" as "Alto" from ZooLogic.CfgArtEcomDim where Codigo = <<"'" + this.FormatearTextoSql( c_CONFIGURACIONARTICULOECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DimensionesEcom')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DimensionesEcom', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DimensionesEcom
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
				lcOrden =  .Articulo_PK + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Artic" as "Articulo", "Obs" as "Obs" from ZooLogic.CFGARTECOM where  funciones.padr( Artic, 15, ' ' ) + funciones.padr( Codigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CFGARTECOM.CODIGO != '' order by Artic,Codigo
			endtext
			use in select('c_CONFIGURACIONARTICULOECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONFIGURACIONARTICULOECOMMERCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codcat" as "Codcategoria", "Desccat" as "Desccategoria", "Platafcat" as "Plataforma" from ZooLogic.CfgArtEcomCat where Codigo = <<"'" + this.FormatearTextoSql( c_CONFIGURACIONARTICULOECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CategoriasEcom')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CategoriasEcom', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CategoriasEcom
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codeti" as "Codetiqueta", "Desceti" as "Descetiqueta", "Platafeti" as "Plataforma" from ZooLogic.CfgArtEcomEti where Codigo = <<"'" + this.FormatearTextoSql( c_CONFIGURACIONARTICULOECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_EtiquetasEcom')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EtiquetasEcom', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_EtiquetasEcom
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codcolor" as "Color", "Colordet" as "Colordetalle", "Talle" as "Talle", "Peso" as "Peso", "Largo" as "Largo", "Ancho" as "Ancho", "Alto" as "Alto" from ZooLogic.CfgArtEcomDim where Codigo = <<"'" + this.FormatearTextoSql( c_CONFIGURACIONARTICULOECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DimensionesEcom')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DimensionesEcom', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DimensionesEcom
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
				lcOrden =  .Articulo_PK + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Artic" as "Articulo", "Obs" as "Obs" from ZooLogic.CFGARTECOM where  funciones.padr( Artic, 15, ' ' ) + funciones.padr( Codigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CFGARTECOM.CODIGO != '' order by Artic desc,Codigo desc
			endtext
			use in select('c_CONFIGURACIONARTICULOECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONFIGURACIONARTICULOECOMMERCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codcat" as "Codcategoria", "Desccat" as "Desccategoria", "Platafcat" as "Plataforma" from ZooLogic.CfgArtEcomCat where Codigo = <<"'" + this.FormatearTextoSql( c_CONFIGURACIONARTICULOECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CategoriasEcom')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CategoriasEcom', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CategoriasEcom
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codeti" as "Codetiqueta", "Desceti" as "Descetiqueta", "Platafeti" as "Plataforma" from ZooLogic.CfgArtEcomEti where Codigo = <<"'" + this.FormatearTextoSql( c_CONFIGURACIONARTICULOECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_EtiquetasEcom')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EtiquetasEcom', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_EtiquetasEcom
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codcolor" as "Color", "Colordet" as "Colordetalle", "Talle" as "Talle", "Peso" as "Peso", "Largo" as "Largo", "Ancho" as "Ancho", "Alto" as "Alto" from ZooLogic.CfgArtEcomDim where Codigo = <<"'" + this.FormatearTextoSql( c_CONFIGURACIONARTICULOECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DimensionesEcom')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DimensionesEcom', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DimensionesEcom
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
				lcOrden =  .Articulo_PK + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Artic" as "Articulo", "Obs" as "Obs" from ZooLogic.CFGARTECOM where  CFGARTECOM.CODIGO != '' order by Artic desc,Codigo desc
			endtext
			use in select('c_CONFIGURACIONARTICULOECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONFIGURACIONARTICULOECOMMERCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codcat" as "Codcategoria", "Desccat" as "Desccategoria", "Platafcat" as "Plataforma" from ZooLogic.CfgArtEcomCat where Codigo = <<"'" + this.FormatearTextoSql( c_CONFIGURACIONARTICULOECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CategoriasEcom')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CategoriasEcom', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CategoriasEcom
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codeti" as "Codetiqueta", "Desceti" as "Descetiqueta", "Platafeti" as "Plataforma" from ZooLogic.CfgArtEcomEti where Codigo = <<"'" + this.FormatearTextoSql( c_CONFIGURACIONARTICULOECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_EtiquetasEcom')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EtiquetasEcom', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_EtiquetasEcom
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codcolor" as "Color", "Colordet" as "Colordetalle", "Talle" as "Talle", "Peso" as "Peso", "Largo" as "Largo", "Ancho" as "Ancho", "Alto" as "Alto" from ZooLogic.CfgArtEcomDim where Codigo = <<"'" + this.FormatearTextoSql( c_CONFIGURACIONARTICULOECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DimensionesEcom')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DimensionesEcom', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DimensionesEcom
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Smodifw,Hmodifw,Saltafw,Ualtafw,Umodifw,Zadsfw,Valt" + ;
"afw,Vmodifw,Horaimpo,Haltafw,Horaexpo,Bdmodifw,Esttrans,Bdaltafw,Codigo,Artic,Obs" + ;
" from ZooLogic.CFGARTECOM where  CFGARTECOM.CODIGO != '' and " + lcFiltro )
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
			local  lxCfgartecomFecexpo, lxCfgartecomFectrans, lxCfgartecomFecimpo, lxCfgartecomFaltafw, lxCfgartecomFmodifw, lxCfgartecomSmodifw, lxCfgartecomHmodifw, lxCfgartecomSaltafw, lxCfgartecomUaltafw, lxCfgartecomUmodifw, lxCfgartecomZadsfw, lxCfgartecomValtafw, lxCfgartecomVmodifw, lxCfgartecomHoraimpo, lxCfgartecomHaltafw, lxCfgartecomHoraexpo, lxCfgartecomBdmodifw, lxCfgartecomEsttrans, lxCfgartecomBdaltafw, lxCfgartecomCodigo, lxCfgartecomArtic, lxCfgartecomObs
				lxCfgartecomFecexpo = ctod( '  /  /    ' )			lxCfgartecomFectrans = ctod( '  /  /    ' )			lxCfgartecomFecimpo = ctod( '  /  /    ' )			lxCfgartecomFaltafw = ctod( '  /  /    ' )			lxCfgartecomFmodifw = ctod( '  /  /    ' )			lxCfgartecomSmodifw = []			lxCfgartecomHmodifw = []			lxCfgartecomSaltafw = []			lxCfgartecomUaltafw = []			lxCfgartecomUmodifw = []			lxCfgartecomZadsfw = []			lxCfgartecomValtafw = []			lxCfgartecomVmodifw = []			lxCfgartecomHoraimpo = []			lxCfgartecomHaltafw = []			lxCfgartecomHoraexpo = []			lxCfgartecomBdmodifw = []			lxCfgartecomEsttrans = []			lxCfgartecomBdaltafw = []			lxCfgartecomCodigo = []			lxCfgartecomArtic = []			lxCfgartecomObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CfgArtEcomCat where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CfgArtEcomEti where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CfgArtEcomDim where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CFGARTECOM where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CFGARTECOM' + '_' + tcCampo
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
		lcWhere = " Where  CFGARTECOM.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Artic" as "Articulo", "Obs" as "Obs"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CFGARTECOM', '', tnTope )
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
	Function ObtenerDatosDetalleCategoriasEcom( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CFGARTECOMCAT.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codcat" as "Codcategoria", "Desccat" as "Desccategoria", "Platafcat" as "Plataforma"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleCategoriasEcom( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CfgArtEcomCat', 'CategoriasEcom', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleCategoriasEcom( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleCategoriasEcom( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleEtiquetasEcom( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CFGARTECOMETI.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codeti" as "Codetiqueta", "Desceti" as "Descetiqueta", "Platafeti" as "Plataforma"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleEtiquetasEcom( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CfgArtEcomEti', 'EtiquetasEcom', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleEtiquetasEcom( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleEtiquetasEcom( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleDimensionesEcom( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CFGARTECOMDIM.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codcolor" as "Color", "Colordet" as "Colordetalle", "Talle" as "Talle", "Peso" as "Peso", "Largo" as "Largo", "Ancho" as "Ancho", "Alto" as "Alto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDimensionesEcom( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CfgArtEcomDim', 'DimensionesEcom', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDimensionesEcom( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDimensionesEcom( lcAtributo )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTIC AS ARTICULO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleCategoriasEcom( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CODCATEGORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCAT AS CODCATEGORIA'
				Case lcAtributo == 'DESCCATEGORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCCAT AS DESCCATEGORIA'
				Case lcAtributo == 'PLATAFORMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PLATAFCAT AS PLATAFORMA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleEtiquetasEcom( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CODETIQUETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODETI AS CODETIQUETA'
				Case lcAtributo == 'DESCETIQUETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCETI AS DESCETIQUETA'
				Case lcAtributo == 'PLATAFORMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PLATAFETI AS PLATAFORMA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDimensionesEcom( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLORDET AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLE AS TALLE'
				Case lcAtributo == 'PESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PESO AS PESO'
				Case lcAtributo == 'LARGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LARGO AS LARGO'
				Case lcAtributo == 'ANCHO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANCHO AS ANCHO'
				Case lcAtributo == 'ALTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ALTO AS ALTO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'ARTIC'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleCategoriasEcom( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CODCATEGORIA'
				lcCampo = 'CODCAT'
			Case upper( alltrim( tcAtributo ) ) == 'DESCCATEGORIA'
				lcCampo = 'DESCCAT'
			Case upper( alltrim( tcAtributo ) ) == 'PLATAFORMA'
				lcCampo = 'PLATAFCAT'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleEtiquetasEcom( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CODETIQUETA'
				lcCampo = 'CODETI'
			Case upper( alltrim( tcAtributo ) ) == 'DESCETIQUETA'
				lcCampo = 'DESCETI'
			Case upper( alltrim( tcAtributo ) ) == 'PLATAFORMA'
				lcCampo = 'PLATAFETI'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDimensionesEcom( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CODCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'COLORDET'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'TALLE'
			Case upper( alltrim( tcAtributo ) ) == 'PESO'
				lcCampo = 'PESO'
			Case upper( alltrim( tcAtributo ) ) == 'LARGO'
				lcCampo = 'LARGO'
			Case upper( alltrim( tcAtributo ) ) == 'ANCHO'
				lcCampo = 'ANCHO'
			Case upper( alltrim( tcAtributo ) ) == 'ALTO'
				lcCampo = 'ALTO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'CATEGORIASECOM'
			lcRetorno = 'CFGARTECOMCAT'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'ETIQUETASECOM'
			lcRetorno = 'CFGARTECOMETI'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'DIMENSIONESECOM'
			lcRetorno = 'CFGARTECOMDIM'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCfgartecomFecexpo, lxCfgartecomFectrans, lxCfgartecomFecimpo, lxCfgartecomFaltafw, lxCfgartecomFmodifw, lxCfgartecomSmodifw, lxCfgartecomHmodifw, lxCfgartecomSaltafw, lxCfgartecomUaltafw, lxCfgartecomUmodifw, lxCfgartecomZadsfw, lxCfgartecomValtafw, lxCfgartecomVmodifw, lxCfgartecomHoraimpo, lxCfgartecomHaltafw, lxCfgartecomHoraexpo, lxCfgartecomBdmodifw, lxCfgartecomEsttrans, lxCfgartecomBdaltafw, lxCfgartecomCodigo, lxCfgartecomArtic, lxCfgartecomObs
				lxCfgartecomFecexpo =  .Fechaexpo			lxCfgartecomFectrans =  .Fechatransferencia			lxCfgartecomFecimpo =  .Fechaimpo			lxCfgartecomFaltafw =  .Fechaaltafw			lxCfgartecomFmodifw =  .Fechamodificacionfw			lxCfgartecomSmodifw =  .Seriemodificacionfw			lxCfgartecomHmodifw =  .Horamodificacionfw			lxCfgartecomSaltafw =  .Seriealtafw			lxCfgartecomUaltafw =  .Usuarioaltafw			lxCfgartecomUmodifw =  .Usuariomodificacionfw			lxCfgartecomZadsfw =  .Zadsfw			lxCfgartecomValtafw =  .Versionaltafw			lxCfgartecomVmodifw =  .Versionmodificacionfw			lxCfgartecomHoraimpo =  .Horaimpo			lxCfgartecomHaltafw =  .Horaaltafw			lxCfgartecomHoraexpo =  .Horaexpo			lxCfgartecomBdmodifw =  .Basededatosmodificacionfw			lxCfgartecomEsttrans =  .Estadotransferencia			lxCfgartecomBdaltafw =  .Basededatosaltafw			lxCfgartecomCodigo =  .Codigo			lxCfgartecomArtic =  upper( .Articulo_PK ) 			lxCfgartecomObs =  .Obs
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CFGARTECOM ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Smodifw","Hmodifw","Saltafw","Ualtafw","Umodifw","Zadsfw","Valtafw","Vmodifw","Horaimpo","Haltafw","Horaexpo","Bdmodifw","Esttrans","Bdaltafw","Codigo","Artic","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCfgartecomFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCfgartecomFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCfgartecomFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCfgartecomFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCfgartecomFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomArtic ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCfgartecomObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CFGARTECOM' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CategoriasEcom
				if this.oEntidad.CategoriasEcom.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodcategoria_PK = loItem.Codcategoria_PK
					lxDesccategoria = loItem.Desccategoria
					lxPlataforma_PK = loItem.Plataforma_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CfgArtEcomCat("NROITEM","Codigo","CodCat","DescCat","PlatafCat" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodcategoria_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDesccategoria ) + "'">>, <<"'" + this.FormatearTextoSql( lxPlataforma_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.EtiquetasEcom
				if this.oEntidad.EtiquetasEcom.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodetiqueta_PK = loItem.Codetiqueta_PK
					lxDescetiqueta = loItem.Descetiqueta
					lxPlataforma_PK = loItem.Plataforma_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CfgArtEcomEti("NROITEM","Codigo","CodEti","DescEti","PlatafEti" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodetiqueta_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescetiqueta ) + "'">>, <<"'" + this.FormatearTextoSql( lxPlataforma_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DimensionesEcom
				if this.oEntidad.DimensionesEcom.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxPeso = loItem.Peso
					lxLargo = loItem.Largo
					lxAncho = loItem.Ancho
					lxAlto = loItem.Alto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CfgArtEcomDim("NROITEM","Codigo","codColor","ColorDet","Talle","Peso","Largo","Ancho","Alto" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxPeso>>, <<lxLargo>>, <<lxAncho>>, <<lxAlto>> ) 
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
			local  lxCfgartecomFecexpo, lxCfgartecomFectrans, lxCfgartecomFecimpo, lxCfgartecomFaltafw, lxCfgartecomFmodifw, lxCfgartecomSmodifw, lxCfgartecomHmodifw, lxCfgartecomSaltafw, lxCfgartecomUaltafw, lxCfgartecomUmodifw, lxCfgartecomZadsfw, lxCfgartecomValtafw, lxCfgartecomVmodifw, lxCfgartecomHoraimpo, lxCfgartecomHaltafw, lxCfgartecomHoraexpo, lxCfgartecomBdmodifw, lxCfgartecomEsttrans, lxCfgartecomBdaltafw, lxCfgartecomCodigo, lxCfgartecomArtic, lxCfgartecomObs
				lxCfgartecomFecexpo =  .Fechaexpo			lxCfgartecomFectrans =  .Fechatransferencia			lxCfgartecomFecimpo =  .Fechaimpo			lxCfgartecomFaltafw =  .Fechaaltafw			lxCfgartecomFmodifw =  .Fechamodificacionfw			lxCfgartecomSmodifw =  .Seriemodificacionfw			lxCfgartecomHmodifw =  .Horamodificacionfw			lxCfgartecomSaltafw =  .Seriealtafw			lxCfgartecomUaltafw =  .Usuarioaltafw			lxCfgartecomUmodifw =  .Usuariomodificacionfw			lxCfgartecomZadsfw =  .Zadsfw			lxCfgartecomValtafw =  .Versionaltafw			lxCfgartecomVmodifw =  .Versionmodificacionfw			lxCfgartecomHoraimpo =  .Horaimpo			lxCfgartecomHaltafw =  .Horaaltafw			lxCfgartecomHoraexpo =  .Horaexpo			lxCfgartecomBdmodifw =  .Basededatosmodificacionfw			lxCfgartecomEsttrans =  .Estadotransferencia			lxCfgartecomBdaltafw =  .Basededatosaltafw			lxCfgartecomCodigo =  .Codigo			lxCfgartecomArtic =  upper( .Articulo_PK ) 			lxCfgartecomObs =  .Obs
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CFGARTECOM.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CFGARTECOM set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCfgartecomFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCfgartecomFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCfgartecomFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCfgartecomFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCfgartecomFmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCfgartecomSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCfgartecomHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCfgartecomSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCfgartecomUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCfgartecomUmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCfgartecomZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCfgartecomValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCfgartecomVmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCfgartecomHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCfgartecomHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCfgartecomHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCfgartecomBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCfgartecomEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCfgartecomBdaltafw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCfgartecomCodigo ) + "'">>, "Artic" = <<"'" + this.FormatearTextoSql( lxCfgartecomArtic ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxCfgartecomObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CFGARTECOM' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CfgArtEcomCat where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CfgArtEcomEti where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CfgArtEcomDim where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CategoriasEcom
				if this.oEntidad.CategoriasEcom.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodcategoria_PK = loItem.Codcategoria_PK
					lxDesccategoria = loItem.Desccategoria
					lxPlataforma_PK = loItem.Plataforma_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CfgArtEcomCat("NROITEM","Codigo","CodCat","DescCat","PlatafCat" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodcategoria_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDesccategoria ) + "'">>, <<"'" + this.FormatearTextoSql( lxPlataforma_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.EtiquetasEcom
				if this.oEntidad.EtiquetasEcom.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodetiqueta_PK = loItem.Codetiqueta_PK
					lxDescetiqueta = loItem.Descetiqueta
					lxPlataforma_PK = loItem.Plataforma_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CfgArtEcomEti("NROITEM","Codigo","CodEti","DescEti","PlatafEti" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodetiqueta_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescetiqueta ) + "'">>, <<"'" + this.FormatearTextoSql( lxPlataforma_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DimensionesEcom
				if this.oEntidad.DimensionesEcom.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxPeso = loItem.Peso
					lxLargo = loItem.Largo
					lxAncho = loItem.Ancho
					lxAlto = loItem.Alto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CfgArtEcomDim("NROITEM","Codigo","codColor","ColorDet","Talle","Peso","Largo","Ancho","Alto" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxPeso>>, <<lxLargo>>, <<lxAncho>>, <<lxAlto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CFGARTECOM.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.CFGARTECOM where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CfgArtEcomCat where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CfgArtEcomEti where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CfgArtEcomDim where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'CFGARTECOM' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CFGARTECOM where  CFGARTECOM.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CFGARTECOM where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CFGARTECOM.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CONFIGURACIONARTICULOECOMMERCE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CFGARTECOM Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CFGARTECOM set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Artic = ] + "'" + this.FormatearTextoSql( &lcCursor..Artic ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FECIMPO, FALTAFW, FMODIFW, SMODIFW, HMODIFW, SALTAFW, UALTAFW, UMODIFW, ZADSFW, VALTAFW, VMODIFW, HORAIMPO, HALTAFW, HORAEXPO, BDMODIFW, ESTTRANS, BDALTAFW, Codigo, Artic, Obs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Artic ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CFGARTECOM ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CONFIGURACIONARTICULOECOMMERCE'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CfgArtEcomCat Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CfgArtEcomEti Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CfgArtEcomDim Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCATEGORIASECOM'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","CodCat","DescCat","PlatafCat"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CfgArtEcomCat ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodCat     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DescCat    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.PlatafCat  ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMETIQUETASECOM'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","CodEti","DescEti","PlatafEti"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CfgArtEcomEti ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodEti     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DescEti    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.PlatafEti  ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMDIMENSIONESECOM'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","codColor","ColorDet","Talle","Peso","Largo","Ancho","Alto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CfgArtEcomDim ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ColorDet   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Talle      ) + "'" + ',' + transform( cDetallesExistentes.Peso       ) + ',' + transform( cDetallesExistentes.Largo      ) + ',' + transform( cDetallesExistentes.Ancho      ) + ',' + transform( cDetallesExistentes.Alto       ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
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
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CONFIGURACIONARTICULOECOMMERCE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CONFIGURACIONARTICULOECOMMERCE_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CONFIGURACIONARTICULOECOMMERCE_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCATEGORIASECOM'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMETIQUETASECOM'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMDIMENSIONESECOM'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CfgArtEcom')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CONFIGURACIONARTICULOECOMMERCE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CONFIGURACIONARTICULOECOMMERCE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CONFIGURACIONARTICULOECOMMERCE'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CONFIGURACIONARTICULOECOMMERCE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CfgArtEcom') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CfgArtEcom
Create Table ZooLogic.TablaTrabajo_CfgArtEcom ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"codigo" char( 38 )  null, 
"artic" char( 15 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CfgArtEcom' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CfgArtEcom' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CONFIGURACIONARTICULOECOMMERCE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('artic','artic')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CfgArtEcom'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.ARTIC = isnull( d.ARTIC, t.ARTIC ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.CFGARTECOM t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.CFGARTECOM(Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Smodifw,Hmodifw,Saltafw,Ualtafw,Umodifw,Zadsfw,Valtafw,Vmodifw,Horaimpo,Haltafw,Horaexpo,Bdmodifw,Esttrans,Bdaltafw,Codigo,Artic,Obs)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.CODIGO,''),isnull( d.ARTIC,''),isnull( d.OBS,'')
						From deleted d left join ZooLogic.CFGARTECOM pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CfgArtEcomCat( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CFGARTECOM_CfgArtEcomCat
ON ZooLogic.TablaTrabajo_CFGARTECOM_CfgArtEcomCat
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.CODCAT = isnull( d.CODCAT, t.CODCAT ),
t.DESCCAT = isnull( d.DESCCAT, t.DESCCAT ),
t.PLATAFCAT = isnull( d.PLATAFCAT, t.PLATAFCAT )
from ZooLogic.CfgArtEcomCat t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CfgArtEcomCat
( 
"NROITEM",
"CODIGO",
"CODCAT",
"DESCCAT",
"PLATAFCAT"
 )
Select 
d.NROITEM,
d.CODIGO,
d.CODCAT,
d.DESCCAT,
d.PLATAFCAT
From deleted d left join ZooLogic.CfgArtEcomCat pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CfgArtEcomEti( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CFGARTECOM_CfgArtEcomEti
ON ZooLogic.TablaTrabajo_CFGARTECOM_CfgArtEcomEti
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.CODETI = isnull( d.CODETI, t.CODETI ),
t.DESCETI = isnull( d.DESCETI, t.DESCETI ),
t.PLATAFETI = isnull( d.PLATAFETI, t.PLATAFETI )
from ZooLogic.CfgArtEcomEti t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CfgArtEcomEti
( 
"NROITEM",
"CODIGO",
"CODETI",
"DESCETI",
"PLATAFETI"
 )
Select 
d.NROITEM,
d.CODIGO,
d.CODETI,
d.DESCETI,
d.PLATAFETI
From deleted d left join ZooLogic.CfgArtEcomEti pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CfgArtEcomDim( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CFGARTECOM_CfgArtEcomDim
ON ZooLogic.TablaTrabajo_CFGARTECOM_CfgArtEcomDim
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.CODCOLOR = isnull( d.CODCOLOR, t.CODCOLOR ),
t.COLORDET = isnull( d.COLORDET, t.COLORDET ),
t.TALLE = isnull( d.TALLE, t.TALLE ),
t.PESO = isnull( d.PESO, t.PESO ),
t.LARGO = isnull( d.LARGO, t.LARGO ),
t.ANCHO = isnull( d.ANCHO, t.ANCHO ),
t.ALTO = isnull( d.ALTO, t.ALTO )
from ZooLogic.CfgArtEcomDim t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CfgArtEcomDim
( 
"NROITEM",
"CODIGO",
"CODCOLOR",
"COLORDET",
"TALLE",
"PESO",
"LARGO",
"ANCHO",
"ALTO"
 )
Select 
d.NROITEM,
d.CODIGO,
d.CODCOLOR,
d.COLORDET,
d.TALLE,
d.PESO,
d.LARGO,
d.ANCHO,
d.ALTO
From deleted d left join ZooLogic.CfgArtEcomDim pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CfgArtEcom') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CfgArtEcom
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CONFIGURACIONARTICULOECOMMERCE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONFIGURACIONARTICULOECOMMERCE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONFIGURACIONARTICULOECOMMERCE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONFIGURACIONARTICULOECOMMERCE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONFIGURACIONARTICULOECOMMERCE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONFIGURACIONARTICULOECOMMERCE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Seriemodificacionfw = nvl( c_CONFIGURACIONARTICULOECOMMERCE.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_CONFIGURACIONARTICULOECOMMERCE.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_CONFIGURACIONARTICULOECOMMERCE.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_CONFIGURACIONARTICULOECOMMERCE.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_CONFIGURACIONARTICULOECOMMERCE.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_CONFIGURACIONARTICULOECOMMERCE.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_CONFIGURACIONARTICULOECOMMERCE.Versionmodificacionfw, [] )
					.Horaimpo = nvl( c_CONFIGURACIONARTICULOECOMMERCE.Horaimpo, [] )
					.Horaaltafw = nvl( c_CONFIGURACIONARTICULOECOMMERCE.Horaaltafw, [] )
					.Horaexpo = nvl( c_CONFIGURACIONARTICULOECOMMERCE.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_CONFIGURACIONARTICULOECOMMERCE.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_CONFIGURACIONARTICULOECOMMERCE.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_CONFIGURACIONARTICULOECOMMERCE.Basededatosaltafw, [] )
					.Codigo = nvl( c_CONFIGURACIONARTICULOECOMMERCE.Codigo, [] )
					.Articulo_PK =  nvl( c_CONFIGURACIONARTICULOECOMMERCE.Articulo, [] )
					.Categoriasecom.Limpiar()
					.Categoriasecom.SetearEsNavegacion( .lProcesando )
					.Categoriasecom.Cargar()
					.Etiquetasecom.Limpiar()
					.Etiquetasecom.SetearEsNavegacion( .lProcesando )
					.Etiquetasecom.Cargar()
					.Dimensionesecom.Limpiar()
					.Dimensionesecom.SetearEsNavegacion( .lProcesando )
					.Dimensionesecom.Cargar()
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
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
		
		loDetalle = this.oEntidad.CategoriasEcom
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

		loDetalle = this.oEntidad.EtiquetasEcom
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

		loDetalle = this.oEntidad.DimensionesEcom
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
		return c_CONFIGURACIONARTICULOECOMMERCE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CFGARTECOM' )
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
								from ZooLogic.CFGARTECOM 
								Where   CFGARTECOM.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CFGARTECOM", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Artic" as "Articulo", "Obs" as "Obs"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CFGARTECOM 
								Where   CFGARTECOM.CODIGO != ''
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
	Tabla = 'CFGARTECOM'
	Filtro = " CFGARTECOM.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CFGARTECOM.CODIGO != ''"
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
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="FECHAEXPO                               " tabla="CFGARTECOM     " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="FECHATRANSFERENCIA                      " tabla="CFGARTECOM     " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="FECHAIMPO                               " tabla="CFGARTECOM     " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="FECHAALTAFW                             " tabla="CFGARTECOM     " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="FECHAMODIFICACIONFW                     " tabla="CFGARTECOM     " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="SERIEMODIFICACIONFW                     " tabla="CFGARTECOM     " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="HORAMODIFICACIONFW                      " tabla="CFGARTECOM     " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="SERIEALTAFW                             " tabla="CFGARTECOM     " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="USUARIOALTAFW                           " tabla="CFGARTECOM     " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="USUARIOMODIFICACIONFW                   " tabla="CFGARTECOM     " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="ZADSFW                                  " tabla="CFGARTECOM     " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="VERSIONALTAFW                           " tabla="CFGARTECOM     " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="VERSIONMODIFICACIONFW                   " tabla="CFGARTECOM     " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="HORAIMPO                                " tabla="CFGARTECOM     " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="HORAALTAFW                              " tabla="CFGARTECOM     " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="HORAEXPO                                " tabla="CFGARTECOM     " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CFGARTECOM     " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="ESTADOTRANSFERENCIA                     " tabla="CFGARTECOM     " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="BASEDEDATOSALTAFW                       " tabla="CFGARTECOM     " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="CODIGO                                  " tabla="CFGARTECOM     " campo="CODIGO    " claveprimaria="true" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="198" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="ARTICULO                                " tabla="CFGARTECOM     " campo="ARTIC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Artículo                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="CATEGORIASECOM                          " tabla="CFGARTECOMCAT  " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Categorías ecommerce                                                                                                                                            " dominio="DETALLEITEMCATEGORIASECOM     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="ETIQUETASECOM                           " tabla="CFGARTECOMETI  " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Etiquetas ecommerce                                                                                                                                             " dominio="DETALLEITEMETIQUETASECOM      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="DIMENSIONESECOM                         " tabla="CFGARTECOMDIM  " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Dimensiones ecommerce por variante                                                                                                                              " dominio="DETALLEITEMDIMENSIONESECOM    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONFIGURACIONARTICULOECOMMERCE          " atributo="OBS                                     " tabla="CFGARTECOM     " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On CFGARTECOM.ARTIC = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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