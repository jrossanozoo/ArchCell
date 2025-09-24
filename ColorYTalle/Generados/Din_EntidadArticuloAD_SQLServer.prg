
define class Din_EntidadARTICULOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ARTICULO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_ARTPK'
	cTablaPrincipal = 'ART'
	cCampoCodigoWH = 'ARTCOD'
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
			local  lxArtFecimpo, lxArtFectrans, lxArtFmodifw, lxArtFaltafw, lxArtFecexpo, lxArtHoraexpo, lxArtEsttrans, lxArtHaltafw, lxArtBdaltafw, lxArtSaltafw, lxArtVmodifw, lxArtDescfw, lxArtZadsfw, lxArtValtafw, lxArtUmodifw, lxArtHoraimpo, lxArtHmodifw, lxArtBdmodifw, lxArtUaltafw, lxArtSmodifw, lxArtTimestamp, lxArtTipagrupub, lxArtBloqreg, lxArtImportado, lxArtArimagen, lxArtPalcol, lxArtArtcod, lxArtNocom, lxArtDeseco, lxArtArtpeso, lxArtEsimpdes, lxArtArtdes, lxArtCurtall, lxArtDesecohtml, lxArtArtdesadic, lxArtArtfab, lxArtArtlargo, lxArtArtnodevo, lxArtAstock, lxArtUnimed, lxArtArtancho, lxArtArtsindes, lxArtAtemporada, lxArtArtalto, lxArtArtrest, lxArtAno, lxArtReqccosto, lxArtMarca, lxArtPubecom, lxArtPromoykit, lxArtFamilia, lxArtMat, lxArtLinea, lxArtGrupo, lxArtCatearti, lxArtClasifart, lxArtTipoarti, lxArtArtconiva, lxArtArtporiva, lxArtArtiva, lxArtAnx2, lxArtImpinterno, lxArtArtnarba, lxArtArtpercep, lxArtAobs
				lxArtFecimpo =  .Fechaimpo			lxArtFectrans =  .Fechatransferencia			lxArtFmodifw =  .Fechamodificacionfw			lxArtFaltafw =  .Fechaaltafw			lxArtFecexpo =  .Fechaexpo			lxArtHoraexpo =  .Horaexpo			lxArtEsttrans =  .Estadotransferencia			lxArtHaltafw =  .Horaaltafw			lxArtBdaltafw =  .Basededatosaltafw			lxArtSaltafw =  .Seriealtafw			lxArtVmodifw =  .Versionmodificacionfw			lxArtDescfw =  .Descripcionfw			lxArtZadsfw =  .Zadsfw			lxArtValtafw =  .Versionaltafw			lxArtUmodifw =  .Usuariomodificacionfw			lxArtHoraimpo =  .Horaimpo			lxArtHmodifw =  .Horamodificacionfw			lxArtBdmodifw =  .Basededatosmodificacionfw			lxArtUaltafw =  .Usuarioaltafw			lxArtSmodifw =  .Seriemodificacionfw			lxArtTimestamp = goLibrerias.ObtenerTimestamp()			lxArtTipagrupub =  .Tipoagrupamientopublicaciones			lxArtBloqreg =  .Bloquearregistro			lxArtImportado =  .Importado			lxArtArimagen =  .Imagen			lxArtPalcol =  upper( .Paletadecolores_PK ) 			lxArtArtcod =  .Codigo			lxArtNocom =  .Nocomercializable			lxArtDeseco =  .Descecommerce			lxArtArtpeso =  .Peso			lxArtEsimpdes =  .Imprimedespacho			lxArtArtdes =  .Descripcion			lxArtCurtall =  upper( .Curvadetalles_PK ) 			lxArtDesecohtml =  .Descecommercehtml			lxArtArtdesadic =  .Descripcionadicional			lxArtArtfab =  upper( .Proveedor_PK ) 			lxArtArtlargo =  .Largo			lxArtArtnodevo =  .Nopermitedevoluciones			lxArtAstock =  .Comportamiento			lxArtUnimed =  upper( .UnidadDeMedida_PK ) 			lxArtArtancho =  .Ancho			lxArtArtsindes =  .Restringirdescuentos			lxArtAtemporada =  upper( .Temporada_PK ) 			lxArtArtalto =  .Alto			lxArtArtrest =  .Restringirarticulo			lxArtAno =  .Ano			lxArtReqccosto =  .Requiereccosto			lxArtMarca =  upper( .Marca_PK ) 			lxArtPubecom =  .Nopublicarenecommerce			lxArtPromoykit =  .Solopromoykit			lxArtFamilia =  upper( .Familia_PK ) 			lxArtMat =  upper( .Material_PK ) 			lxArtLinea =  upper( .Linea_PK ) 			lxArtGrupo =  upper( .Grupo_PK ) 			lxArtCatearti =  upper( .CategoriaDeArticulo_PK ) 			lxArtClasifart =  upper( .Clasificacion_PK ) 			lxArtTipoarti =  upper( .TipodeArticulo_PK ) 			lxArtArtconiva =  .Condicionivaventas			lxArtArtporiva =  .Porcentajeivaventas			lxArtArtiva =  .Condicionivacompras			lxArtAnx2 =  .Porcentajeivacompras			lxArtImpinterno =  .Porcentajeimpuestointerno			lxArtArtnarba =  upper( .Nomenclador_PK ) 			lxArtArtpercep =  .Percepcionivarg5329			lxArtAobs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxArtArtcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ART ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Horaexpo","Esttrans","Haltafw","Bdaltafw","Saltafw","Vmodifw","Descfw","Zadsfw","Valtafw","Umodifw","Horaimpo","Hmodifw","Bdmodifw","Ualtafw","Smodifw","Timestamp","Tipagrupub","Bloqreg","Importado","Arimagen","Palcol","Artcod","Nocom","Deseco","Artpeso","Esimpdes","Artdes","Curtall","Desecohtml","Artdesadic","Artfab","Artlargo","Artnodevo","Astock","Unimed","Artancho","Artsindes","Atemporada","Artalto","Artrest","Ano","Reqccosto","Marca","Pubecom","Promoykit","Familia","Mat","Linea","Grupo","Catearti","Clasifart","Tipoarti","Artconiva","Artporiva","Artiva","Anx2","Impinterno","Artnarba","Artpercep","Aobs" ) values ( <<"'" + this.ConvertirDateSql( lxArtFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtSmodifw ) + "'" >>, <<lxArtTimestamp >>, <<lxArtTipagrupub >>, <<iif( lxArtBloqreg, 1, 0 ) >>, <<iif( lxArtImportado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxArtArimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtPalcol ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtArtcod ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtNocom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtDeseco ) + "'" >>, <<lxArtArtpeso >>, <<iif( lxArtEsimpdes, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxArtArtdes ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtCurtall ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtDesecohtml ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtArtdesadic ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtArtfab ) + "'" >>, <<lxArtArtlargo >>, <<iif( lxArtArtnodevo, 1, 0 ) >>, <<lxArtAstock >>, <<"'" + this.FormatearTextoSql( lxArtUnimed ) + "'" >>, <<lxArtArtancho >>, <<iif( lxArtArtsindes, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxArtAtemporada ) + "'" >>, <<lxArtArtalto >>, <<"'" + this.ConvertirDateSql( lxArtArtrest ) + "'" >>, <<lxArtAno >>, <<lxArtReqccosto >>, <<"'" + this.FormatearTextoSql( lxArtMarca ) + "'" >>, <<iif( lxArtPubecom, 1, 0 ) >>, <<iif( lxArtPromoykit, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxArtFamilia ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtMat ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtLinea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtGrupo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtCatearti ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtClasifart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtTipoarti ) + "'" >>, <<lxArtArtconiva >>, <<lxArtArtporiva >>, <<lxArtArtiva >>, <<lxArtAnx2 >>, <<lxArtImpinterno >>, <<"'" + this.FormatearTextoSql( lxArtArtnarba ) + "'" >>, <<lxArtArtpercep >>, <<"'" + this.FormatearTextoSql( lxArtAobs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubART("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ParticipantesDetalle
				if this.oEntidad.ParticipantesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.KitPartDet("NROITEM","COMP","BLOQREG","CODIGO","IPPART","ARTDET","IPCOLOR","COLDET","IPTALLE","CANT" ) values ( <<lxNroitem>>, <<lxComportamiento>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>> ) 
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
		this.oEntidad.Timestamp = lxArtTimestamp
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
			local  lxArtFecimpo, lxArtFectrans, lxArtFmodifw, lxArtFaltafw, lxArtFecexpo, lxArtHoraexpo, lxArtEsttrans, lxArtHaltafw, lxArtBdaltafw, lxArtSaltafw, lxArtVmodifw, lxArtDescfw, lxArtZadsfw, lxArtValtafw, lxArtUmodifw, lxArtHoraimpo, lxArtHmodifw, lxArtBdmodifw, lxArtUaltafw, lxArtSmodifw, lxArtTimestamp, lxArtTipagrupub, lxArtBloqreg, lxArtImportado, lxArtArimagen, lxArtPalcol, lxArtArtcod, lxArtNocom, lxArtDeseco, lxArtArtpeso, lxArtEsimpdes, lxArtArtdes, lxArtCurtall, lxArtDesecohtml, lxArtArtdesadic, lxArtArtfab, lxArtArtlargo, lxArtArtnodevo, lxArtAstock, lxArtUnimed, lxArtArtancho, lxArtArtsindes, lxArtAtemporada, lxArtArtalto, lxArtArtrest, lxArtAno, lxArtReqccosto, lxArtMarca, lxArtPubecom, lxArtPromoykit, lxArtFamilia, lxArtMat, lxArtLinea, lxArtGrupo, lxArtCatearti, lxArtClasifart, lxArtTipoarti, lxArtArtconiva, lxArtArtporiva, lxArtArtiva, lxArtAnx2, lxArtImpinterno, lxArtArtnarba, lxArtArtpercep, lxArtAobs
				lxArtFecimpo =  .Fechaimpo			lxArtFectrans =  .Fechatransferencia			lxArtFmodifw =  .Fechamodificacionfw			lxArtFaltafw =  .Fechaaltafw			lxArtFecexpo =  .Fechaexpo			lxArtHoraexpo =  .Horaexpo			lxArtEsttrans =  .Estadotransferencia			lxArtHaltafw =  .Horaaltafw			lxArtBdaltafw =  .Basededatosaltafw			lxArtSaltafw =  .Seriealtafw			lxArtVmodifw =  .Versionmodificacionfw			lxArtDescfw =  .Descripcionfw			lxArtZadsfw =  .Zadsfw			lxArtValtafw =  .Versionaltafw			lxArtUmodifw =  .Usuariomodificacionfw			lxArtHoraimpo =  .Horaimpo			lxArtHmodifw =  .Horamodificacionfw			lxArtBdmodifw =  .Basededatosmodificacionfw			lxArtUaltafw =  .Usuarioaltafw			lxArtSmodifw =  .Seriemodificacionfw			lxArtTimestamp = goLibrerias.ObtenerTimestamp()			lxArtTipagrupub =  .Tipoagrupamientopublicaciones			lxArtBloqreg =  .Bloquearregistro			lxArtImportado =  .Importado			lxArtArimagen =  .Imagen			lxArtPalcol =  upper( .Paletadecolores_PK ) 			lxArtArtcod =  .Codigo			lxArtNocom =  .Nocomercializable			lxArtDeseco =  .Descecommerce			lxArtArtpeso =  .Peso			lxArtEsimpdes =  .Imprimedespacho			lxArtArtdes =  .Descripcion			lxArtCurtall =  upper( .Curvadetalles_PK ) 			lxArtDesecohtml =  .Descecommercehtml			lxArtArtdesadic =  .Descripcionadicional			lxArtArtfab =  upper( .Proveedor_PK ) 			lxArtArtlargo =  .Largo			lxArtArtnodevo =  .Nopermitedevoluciones			lxArtAstock =  .Comportamiento			lxArtUnimed =  upper( .UnidadDeMedida_PK ) 			lxArtArtancho =  .Ancho			lxArtArtsindes =  .Restringirdescuentos			lxArtAtemporada =  upper( .Temporada_PK ) 			lxArtArtalto =  .Alto			lxArtArtrest =  .Restringirarticulo			lxArtAno =  .Ano			lxArtReqccosto =  .Requiereccosto			lxArtMarca =  upper( .Marca_PK ) 			lxArtPubecom =  .Nopublicarenecommerce			lxArtPromoykit =  .Solopromoykit			lxArtFamilia =  upper( .Familia_PK ) 			lxArtMat =  upper( .Material_PK ) 			lxArtLinea =  upper( .Linea_PK ) 			lxArtGrupo =  upper( .Grupo_PK ) 			lxArtCatearti =  upper( .CategoriaDeArticulo_PK ) 			lxArtClasifart =  upper( .Clasificacion_PK ) 			lxArtTipoarti =  upper( .TipodeArticulo_PK ) 			lxArtArtconiva =  .Condicionivaventas			lxArtArtporiva =  .Porcentajeivaventas			lxArtArtiva =  .Condicionivacompras			lxArtAnx2 =  .Porcentajeivacompras			lxArtImpinterno =  .Porcentajeimpuestointerno			lxArtArtnarba =  upper( .Nomenclador_PK ) 			lxArtArtpercep =  .Percepcionivarg5329			lxArtAobs =  .Observacion
		endwith
		
		if this.oEntidad.VerificarContexto( 'CB' )
		else
			this.ValidarTimestamp()
		endif
		with this
		Try
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  this.ConvertirDateSql( .oEntidad.oAtributosAuditoria.NoComercializable) != this.ConvertirDateSql( .oEntidad.NoComercializable) or  this.ConvertirDateSql( .oEntidad.oAtributosAuditoria.RestringirArticulo) != this.ConvertirDateSql( .oEntidad.RestringirArticulo) )
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ART set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxArtFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxArtFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxArtFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxArtFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxArtFecexpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxArtHoraexpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxArtEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxArtHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxArtBdaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxArtSaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxArtVmodifw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxArtDescfw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxArtZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxArtValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxArtUmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxArtHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxArtHmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxArtBdmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxArtUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxArtSmodifw ) + "'">>,"Timestamp" = <<lxArtTimestamp>>,"Tipagrupub" = <<lxArtTipagrupub>>,"Bloqreg" = <<iif( lxArtBloqreg, 1, 0 )>>,"Importado" = <<iif( lxArtImportado, 1, 0 )>>,"Arimagen" = <<"'" + this.FormatearTextoSql( lxArtArimagen ) + "'">>,"Palcol" = <<"'" + this.FormatearTextoSql( lxArtPalcol ) + "'">>,"Artcod" = <<"'" + this.FormatearTextoSql( lxArtArtcod ) + "'">>,"Nocom" = <<"'" + this.ConvertirDateSql( lxArtNocom ) + "'">>,"Deseco" = <<"'" + this.FormatearTextoSql( lxArtDeseco ) + "'">>,"Artpeso" = <<lxArtArtpeso>>,"Esimpdes" = <<iif( lxArtEsimpdes, 1, 0 )>>,"Artdes" = <<"'" + this.FormatearTextoSql( lxArtArtdes ) + "'">>,"Curtall" = <<"'" + this.FormatearTextoSql( lxArtCurtall ) + "'">>,"Desecohtml" = <<"'" + this.FormatearTextoSql( lxArtDesecohtml ) + "'">>,"Artdesadic" = <<"'" + this.FormatearTextoSql( lxArtArtdesadic ) + "'">>,"Artfab" = <<"'" + this.FormatearTextoSql( lxArtArtfab ) + "'">>,"Artlargo" = <<lxArtArtlargo>>,"Artnodevo" = <<iif( lxArtArtnodevo, 1, 0 )>>,"Astock" = <<lxArtAstock>>,"Unimed" = <<"'" + this.FormatearTextoSql( lxArtUnimed ) + "'">>,"Artancho" = <<lxArtArtancho>>,"Artsindes" = <<iif( lxArtArtsindes, 1, 0 )>>,"Atemporada" = <<"'" + this.FormatearTextoSql( lxArtAtemporada ) + "'">>,"Artalto" = <<lxArtArtalto>>,"Artrest" = <<"'" + this.ConvertirDateSql( lxArtArtrest ) + "'">>,"Ano" = <<lxArtAno>>,"Reqccosto" = <<lxArtReqccosto>>,"Marca" = <<"'" + this.FormatearTextoSql( lxArtMarca ) + "'">>,"Pubecom" = <<iif( lxArtPubecom, 1, 0 )>>,"Promoykit" = <<iif( lxArtPromoykit, 1, 0 )>>,"Familia" = <<"'" + this.FormatearTextoSql( lxArtFamilia ) + "'">>,"Mat" = <<"'" + this.FormatearTextoSql( lxArtMat ) + "'">>,"Linea" = <<"'" + this.FormatearTextoSql( lxArtLinea ) + "'">>,"Grupo" = <<"'" + this.FormatearTextoSql( lxArtGrupo ) + "'">>,"Catearti" = <<"'" + this.FormatearTextoSql( lxArtCatearti ) + "'">>,"Clasifart" = <<"'" + this.FormatearTextoSql( lxArtClasifart ) + "'">>,"Tipoarti" = <<"'" + this.FormatearTextoSql( lxArtTipoarti ) + "'">>,"Artconiva" = <<lxArtArtconiva>>,"Artporiva" = <<lxArtArtporiva>>,"Artiva" = <<lxArtArtiva>>,"Anx2" = <<lxArtAnx2>>,"Impinterno" = <<lxArtImpinterno>>,"Artnarba" = <<"'" + this.FormatearTextoSql( lxArtArtnarba ) + "'">>,"Artpercep" = <<lxArtArtpercep>>,"Aobs" = <<"'" + this.FormatearTextoSql( lxArtAobs ) + "'">> where "Artcod" = <<"'" + this.FormatearTextoSql( lxArtArtcod ) + "'">> and  ART.ARTCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			If llInsertarAuditoria
				lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			EndIf
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubART where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.KitPartDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubART("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ParticipantesDetalle
				if this.oEntidad.ParticipantesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.KitPartDet("NROITEM","COMP","BLOQREG","CODIGO","IPPART","ARTDET","IPCOLOR","COLDET","IPTALLE","CANT" ) values ( <<lxNroitem>>, <<lxComportamiento>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>> ) 
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
		this.oEntidad.Timestamp = lxArtTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 ARTCOD from ZooLogic.ART where " + this.ConvertirFuncionesSql( " ART.ARTCOD != ''" ) )
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
			Local lxArtArtcod
			lxArtArtcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Bloqreg" as "Bloquearregistro", "Importado" as "Importado", "Arimagen" as "Imagen", "Palcol" as "Paletadecolores", "Artcod" as "Codigo", "Nocom" as "Nocomercializable", "Deseco" as "Descecommerce", "Artpeso" as "Peso", "Esimpdes" as "Imprimedespacho", "Artdes" as "Descripcion", "Curtall" as "Curvadetalles", "Desecohtml" as "Descecommercehtml", "Artdesadic" as "Descripcionadicional", "Artfab" as "Proveedor", "Artlargo" as "Largo", "Artnodevo" as "Nopermitedevoluciones", "Astock" as "Comportamiento", "Unimed" as "Unidaddemedida", "Artancho" as "Ancho", "Artsindes" as "Restringirdescuentos", "Atemporada" as "Temporada", "Artalto" as "Alto", "Artrest" as "Restringirarticulo", "Ano" as "Ano", "Reqccosto" as "Requiereccosto", "Marca" as "Marca", "Pubecom" as "Nopublicarenecommerce", "Promoykit" as "Solopromoykit", "Familia" as "Familia", "Mat" as "Material", "Linea" as "Linea", "Grupo" as "Grupo", "Catearti" as "Categoriadearticulo", "Clasifart" as "Clasificacion", "Tipoarti" as "Tipodearticulo", "Artconiva" as "Condicionivaventas", "Artporiva" as "Porcentajeivaventas", "Artiva" as "Condicionivacompras", "Anx2" as "Porcentajeivacompras", "Impinterno" as "Porcentajeimpuestointerno", "Artnarba" as "Nomenclador", "Artpercep" as "Percepcionivarg5329", "Aobs" as "Observacion" from ZooLogic.ART where "Artcod" = <<"'" + this.FormatearTextoSql( lxArtArtcod ) + "'">> and  ART.ARTCOD != ''
			endtext
			use in select('c_ARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ARTICULO', set( 'Datasession' ) )

			if reccount( 'c_ARTICULO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubART where Codigo = <<"'" + this.FormatearTextoSql( c_ARTICULO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Ippart" as "Articulo", "Artdet" as "Articulodetalle", "Ipcolor" as "Color", "Coldet" as "Colordetalle", "Iptalle" as "Talle", "Cant" as "Cantidad" from ZooLogic.KitPartDet where CODIGO = <<"'" + this.FormatearTextoSql( c_ARTICULO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ParticipantesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ParticipantesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ParticipantesDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxArtArtcod as Variant
		llRetorno = .t.
		lxArtArtcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ART where "Artcod" = <<"'" + this.FormatearTextoSql( lxArtArtcod ) + "'">> and  ART.ARTCOD != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Bloqreg" as "Bloquearregistro", "Importado" as "Importado", "Arimagen" as "Imagen", "Palcol" as "Paletadecolores", "Artcod" as "Codigo", "Nocom" as "Nocomercializable", "Deseco" as "Descecommerce", "Artpeso" as "Peso", "Esimpdes" as "Imprimedespacho", "Artdes" as "Descripcion", "Curtall" as "Curvadetalles", "Desecohtml" as "Descecommercehtml", "Artdesadic" as "Descripcionadicional", "Artfab" as "Proveedor", "Artlargo" as "Largo", "Artnodevo" as "Nopermitedevoluciones", "Astock" as "Comportamiento", "Unimed" as "Unidaddemedida", "Artancho" as "Ancho", "Artsindes" as "Restringirdescuentos", "Atemporada" as "Temporada", "Artalto" as "Alto", "Artrest" as "Restringirarticulo", "Ano" as "Ano", "Reqccosto" as "Requiereccosto", "Marca" as "Marca", "Pubecom" as "Nopublicarenecommerce", "Promoykit" as "Solopromoykit", "Familia" as "Familia", "Mat" as "Material", "Linea" as "Linea", "Grupo" as "Grupo", "Catearti" as "Categoriadearticulo", "Clasifart" as "Clasificacion", "Tipoarti" as "Tipodearticulo", "Artconiva" as "Condicionivaventas", "Artporiva" as "Porcentajeivaventas", "Artiva" as "Condicionivacompras", "Anx2" as "Porcentajeivacompras", "Impinterno" as "Porcentajeimpuestointerno", "Artnarba" as "Nomenclador", "Artpercep" as "Percepcionivarg5329", "Aobs" as "Observacion" from ZooLogic.ART where  ART.ARTCOD != '' order by ARTCOD
			endtext
			use in select('c_ARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ARTICULO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubART where Codigo = <<"'" + this.FormatearTextoSql( c_ARTICULO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Ippart" as "Articulo", "Artdet" as "Articulodetalle", "Ipcolor" as "Color", "Coldet" as "Colordetalle", "Iptalle" as "Talle", "Cant" as "Cantidad" from ZooLogic.KitPartDet where CODIGO = <<"'" + this.FormatearTextoSql( c_ARTICULO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ParticipantesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ParticipantesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ParticipantesDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Bloqreg" as "Bloquearregistro", "Importado" as "Importado", "Arimagen" as "Imagen", "Palcol" as "Paletadecolores", "Artcod" as "Codigo", "Nocom" as "Nocomercializable", "Deseco" as "Descecommerce", "Artpeso" as "Peso", "Esimpdes" as "Imprimedespacho", "Artdes" as "Descripcion", "Curtall" as "Curvadetalles", "Desecohtml" as "Descecommercehtml", "Artdesadic" as "Descripcionadicional", "Artfab" as "Proveedor", "Artlargo" as "Largo", "Artnodevo" as "Nopermitedevoluciones", "Astock" as "Comportamiento", "Unimed" as "Unidaddemedida", "Artancho" as "Ancho", "Artsindes" as "Restringirdescuentos", "Atemporada" as "Temporada", "Artalto" as "Alto", "Artrest" as "Restringirarticulo", "Ano" as "Ano", "Reqccosto" as "Requiereccosto", "Marca" as "Marca", "Pubecom" as "Nopublicarenecommerce", "Promoykit" as "Solopromoykit", "Familia" as "Familia", "Mat" as "Material", "Linea" as "Linea", "Grupo" as "Grupo", "Catearti" as "Categoriadearticulo", "Clasifart" as "Clasificacion", "Tipoarti" as "Tipodearticulo", "Artconiva" as "Condicionivaventas", "Artporiva" as "Porcentajeivaventas", "Artiva" as "Condicionivacompras", "Anx2" as "Porcentajeivacompras", "Impinterno" as "Porcentajeimpuestointerno", "Artnarba" as "Nomenclador", "Artpercep" as "Percepcionivarg5329", "Aobs" as "Observacion" from ZooLogic.ART where  funciones.padr( ARTCOD, 15, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ART.ARTCOD != '' order by ARTCOD
			endtext
			use in select('c_ARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ARTICULO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubART where Codigo = <<"'" + this.FormatearTextoSql( c_ARTICULO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Ippart" as "Articulo", "Artdet" as "Articulodetalle", "Ipcolor" as "Color", "Coldet" as "Colordetalle", "Iptalle" as "Talle", "Cant" as "Cantidad" from ZooLogic.KitPartDet where CODIGO = <<"'" + this.FormatearTextoSql( c_ARTICULO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ParticipantesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ParticipantesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ParticipantesDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Bloqreg" as "Bloquearregistro", "Importado" as "Importado", "Arimagen" as "Imagen", "Palcol" as "Paletadecolores", "Artcod" as "Codigo", "Nocom" as "Nocomercializable", "Deseco" as "Descecommerce", "Artpeso" as "Peso", "Esimpdes" as "Imprimedespacho", "Artdes" as "Descripcion", "Curtall" as "Curvadetalles", "Desecohtml" as "Descecommercehtml", "Artdesadic" as "Descripcionadicional", "Artfab" as "Proveedor", "Artlargo" as "Largo", "Artnodevo" as "Nopermitedevoluciones", "Astock" as "Comportamiento", "Unimed" as "Unidaddemedida", "Artancho" as "Ancho", "Artsindes" as "Restringirdescuentos", "Atemporada" as "Temporada", "Artalto" as "Alto", "Artrest" as "Restringirarticulo", "Ano" as "Ano", "Reqccosto" as "Requiereccosto", "Marca" as "Marca", "Pubecom" as "Nopublicarenecommerce", "Promoykit" as "Solopromoykit", "Familia" as "Familia", "Mat" as "Material", "Linea" as "Linea", "Grupo" as "Grupo", "Catearti" as "Categoriadearticulo", "Clasifart" as "Clasificacion", "Tipoarti" as "Tipodearticulo", "Artconiva" as "Condicionivaventas", "Artporiva" as "Porcentajeivaventas", "Artiva" as "Condicionivacompras", "Anx2" as "Porcentajeivacompras", "Impinterno" as "Porcentajeimpuestointerno", "Artnarba" as "Nomenclador", "Artpercep" as "Percepcionivarg5329", "Aobs" as "Observacion" from ZooLogic.ART where  funciones.padr( ARTCOD, 15, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ART.ARTCOD != '' order by ARTCOD desc
			endtext
			use in select('c_ARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ARTICULO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubART where Codigo = <<"'" + this.FormatearTextoSql( c_ARTICULO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Ippart" as "Articulo", "Artdet" as "Articulodetalle", "Ipcolor" as "Color", "Coldet" as "Colordetalle", "Iptalle" as "Talle", "Cant" as "Cantidad" from ZooLogic.KitPartDet where CODIGO = <<"'" + this.FormatearTextoSql( c_ARTICULO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ParticipantesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ParticipantesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ParticipantesDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Bloqreg" as "Bloquearregistro", "Importado" as "Importado", "Arimagen" as "Imagen", "Palcol" as "Paletadecolores", "Artcod" as "Codigo", "Nocom" as "Nocomercializable", "Deseco" as "Descecommerce", "Artpeso" as "Peso", "Esimpdes" as "Imprimedespacho", "Artdes" as "Descripcion", "Curtall" as "Curvadetalles", "Desecohtml" as "Descecommercehtml", "Artdesadic" as "Descripcionadicional", "Artfab" as "Proveedor", "Artlargo" as "Largo", "Artnodevo" as "Nopermitedevoluciones", "Astock" as "Comportamiento", "Unimed" as "Unidaddemedida", "Artancho" as "Ancho", "Artsindes" as "Restringirdescuentos", "Atemporada" as "Temporada", "Artalto" as "Alto", "Artrest" as "Restringirarticulo", "Ano" as "Ano", "Reqccosto" as "Requiereccosto", "Marca" as "Marca", "Pubecom" as "Nopublicarenecommerce", "Promoykit" as "Solopromoykit", "Familia" as "Familia", "Mat" as "Material", "Linea" as "Linea", "Grupo" as "Grupo", "Catearti" as "Categoriadearticulo", "Clasifart" as "Clasificacion", "Tipoarti" as "Tipodearticulo", "Artconiva" as "Condicionivaventas", "Artporiva" as "Porcentajeivaventas", "Artiva" as "Condicionivacompras", "Anx2" as "Porcentajeivacompras", "Impinterno" as "Porcentajeimpuestointerno", "Artnarba" as "Nomenclador", "Artpercep" as "Percepcionivarg5329", "Aobs" as "Observacion" from ZooLogic.ART where  ART.ARTCOD != '' order by ARTCOD desc
			endtext
			use in select('c_ARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ARTICULO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubART where Codigo = <<"'" + this.FormatearTextoSql( c_ARTICULO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Ippart" as "Articulo", "Artdet" as "Articulodetalle", "Ipcolor" as "Color", "Coldet" as "Colordetalle", "Iptalle" as "Talle", "Cant" as "Cantidad" from ZooLogic.KitPartDet where CODIGO = <<"'" + this.FormatearTextoSql( c_ARTICULO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ParticipantesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ParticipantesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ParticipantesDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Horaexpo,Esttrans,Haltafw,Bdaltafw,Saltafw,Vmodifw," + ;
"Descfw,Zadsfw,Valtafw,Umodifw,Horaimpo,Hmodifw,Bdmodifw,Ualtafw,Smodifw,Timestamp,Tipagrupub,Bloqreg" + ;
",Importado,Arimagen,Palcol,Artcod,Nocom,Deseco,Artpeso,Esimpdes,Artdes,Curtall,Desecohtml,Artdesadic" + ;
",Artfab,Artlargo,Artnodevo,Astock,Unimed,Artancho,Artsindes,Atemporada,Artalto,Artrest,Ano,Reqccosto" + ;
",Marca,Pubecom,Promoykit,Familia,Mat,Linea,Grupo,Catearti,Clasifart,Tipoarti,Artconiva,Artporiva,Art" + ;
"iva,Anx2,Impinterno,Artnarba,Artpercep,Aobs" + ;
" from ZooLogic.ART where  ART.ARTCOD != '' and " + lcFiltro )
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
			local  lxArtFecimpo, lxArtFectrans, lxArtFmodifw, lxArtFaltafw, lxArtFecexpo, lxArtHoraexpo, lxArtEsttrans, lxArtHaltafw, lxArtBdaltafw, lxArtSaltafw, lxArtVmodifw, lxArtDescfw, lxArtZadsfw, lxArtValtafw, lxArtUmodifw, lxArtHoraimpo, lxArtHmodifw, lxArtBdmodifw, lxArtUaltafw, lxArtSmodifw, lxArtTimestamp, lxArtTipagrupub, lxArtBloqreg, lxArtImportado, lxArtArimagen, lxArtPalcol, lxArtArtcod, lxArtNocom, lxArtDeseco, lxArtArtpeso, lxArtEsimpdes, lxArtArtdes, lxArtCurtall, lxArtDesecohtml, lxArtArtdesadic, lxArtArtfab, lxArtArtlargo, lxArtArtnodevo, lxArtAstock, lxArtUnimed, lxArtArtancho, lxArtArtsindes, lxArtAtemporada, lxArtArtalto, lxArtArtrest, lxArtAno, lxArtReqccosto, lxArtMarca, lxArtPubecom, lxArtPromoykit, lxArtFamilia, lxArtMat, lxArtLinea, lxArtGrupo, lxArtCatearti, lxArtClasifart, lxArtTipoarti, lxArtArtconiva, lxArtArtporiva, lxArtArtiva, lxArtAnx2, lxArtImpinterno, lxArtArtnarba, lxArtArtpercep, lxArtAobs
				lxArtFecimpo = ctod( '  /  /    ' )			lxArtFectrans = ctod( '  /  /    ' )			lxArtFmodifw = ctod( '  /  /    ' )			lxArtFaltafw = ctod( '  /  /    ' )			lxArtFecexpo = ctod( '  /  /    ' )			lxArtHoraexpo = []			lxArtEsttrans = []			lxArtHaltafw = []			lxArtBdaltafw = []			lxArtSaltafw = []			lxArtVmodifw = []			lxArtDescfw = []			lxArtZadsfw = []			lxArtValtafw = []			lxArtUmodifw = []			lxArtHoraimpo = []			lxArtHmodifw = []			lxArtBdmodifw = []			lxArtUaltafw = []			lxArtSmodifw = []			lxArtTimestamp = goLibrerias.ObtenerTimestamp()			lxArtTipagrupub = 0			lxArtBloqreg = .F.			lxArtImportado = .F.			lxArtArimagen = []			lxArtPalcol = []			lxArtArtcod = []			lxArtNocom = ctod( '  /  /    ' )			lxArtDeseco = []			lxArtArtpeso = 0			lxArtEsimpdes = .F.			lxArtArtdes = []			lxArtCurtall = []			lxArtDesecohtml = []			lxArtArtdesadic = []			lxArtArtfab = []			lxArtArtlargo = 0			lxArtArtnodevo = .F.			lxArtAstock = 0			lxArtUnimed = []			lxArtArtancho = 0			lxArtArtsindes = .F.			lxArtAtemporada = []			lxArtArtalto = 0			lxArtArtrest = ctod( '  /  /    ' )			lxArtAno = 0			lxArtReqccosto = 0			lxArtMarca = []			lxArtPubecom = .F.			lxArtPromoykit = .F.			lxArtFamilia = []			lxArtMat = []			lxArtLinea = []			lxArtGrupo = []			lxArtCatearti = []			lxArtClasifart = []			lxArtTipoarti = []			lxArtArtconiva = 0			lxArtArtporiva = 0			lxArtArtiva = 0			lxArtAnx2 = 0			lxArtImpinterno = 0			lxArtArtnarba = []			lxArtArtpercep = 0			lxArtAobs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubART where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.KitPartDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ART where "ARTCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'ART' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where ARTCOD = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(ARTCOD, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ART.ARTCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Bloqreg" as "Bloquearregistro", "Importado" as "Importado", "Arimagen" as "Imagen", "Palcol" as "Paletadecolores", "Artcod" as "Codigo", "Nocom" as "Nocomercializable", "Deseco" as "Descecommerce", "Artpeso" as "Peso", "Esimpdes" as "Imprimedespacho", "Artdes" as "Descripcion", "Curtall" as "Curvadetalles", "Desecohtml" as "Descecommercehtml", "Artdesadic" as "Descripcionadicional", "Artfab" as "Proveedor", "Artlargo" as "Largo", "Artnodevo" as "Nopermitedevoluciones", "Astock" as "Comportamiento", "Unimed" as "Unidaddemedida", "Artancho" as "Ancho", "Artsindes" as "Restringirdescuentos", "Atemporada" as "Temporada", "Artalto" as "Alto", "Artrest" as "Restringirarticulo", "Ano" as "Ano", "Reqccosto" as "Requiereccosto", "Marca" as "Marca", "Pubecom" as "Nopublicarenecommerce", "Promoykit" as "Solopromoykit", "Familia" as "Familia", "Mat" as "Material", "Linea" as "Linea", "Grupo" as "Grupo", "Catearti" as "Categoriadearticulo", "Clasifart" as "Clasificacion", "Tipoarti" as "Tipodearticulo", "Artconiva" as "Condicionivaventas", "Artporiva" as "Porcentajeivaventas", "Artiva" as "Condicionivacompras", "Anx2" as "Porcentajeivacompras", "Impinterno" as "Porcentajeimpuestointerno", "Artnarba" as "Nomenclador", "Artpercep" as "Percepcionivarg5329", "Aobs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ART', '', tnTope )
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
	Function ObtenerDatosDetalleAgruPubliDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AGRUPUBART.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAgruPubliDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgruPubART', 'AgruPubliDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleAgruPubliDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleAgruPubliDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleParticipantesDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  KITPARTDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Ippart" as "Articulo", "Artdet" as "Articulodetalle", "Ipcolor" as "Color", "Coldet" as "Colordetalle", "Iptalle" as "Talle", "Cant" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleParticipantesDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'KitPartDet', 'ParticipantesDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleParticipantesDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleParticipantesDetalle( lcAtributo )
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
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'TIPOAGRUPAMIENTOPUBLICACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPAGRUPUB AS TIPOAGRUPAMIENTOPUBLICACIONES'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'IMPORTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPORTADO AS IMPORTADO'
				Case lcAtributo == 'IMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARIMAGEN AS IMAGEN'
				Case lcAtributo == 'PALETADECOLORES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PALCOL AS PALETADECOLORES'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTCOD AS CODIGO'
				Case lcAtributo == 'NOCOMERCIALIZABLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOCOM AS NOCOMERCIALIZABLE'
				Case lcAtributo == 'DESCECOMMERCE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESECO AS DESCECOMMERCE'
				Case lcAtributo == 'PESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTPESO AS PESO'
				Case lcAtributo == 'IMPRIMEDESPACHO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESIMPDES AS IMPRIMEDESPACHO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTDES AS DESCRIPCION'
				Case lcAtributo == 'CURVADETALLES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CURTALL AS CURVADETALLES'
				Case lcAtributo == 'DESCECOMMERCEHTML'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESECOHTML AS DESCECOMMERCEHTML'
				Case lcAtributo == 'DESCRIPCIONADICIONAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTDESADIC AS DESCRIPCIONADICIONAL'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTFAB AS PROVEEDOR'
				Case lcAtributo == 'LARGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTLARGO AS LARGO'
				Case lcAtributo == 'NOPERMITEDEVOLUCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTNODEVO AS NOPERMITEDEVOLUCIONES'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ASTOCK AS COMPORTAMIENTO'
				Case lcAtributo == 'UNIDADDEMEDIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIMED AS UNIDADDEMEDIDA'
				Case lcAtributo == 'ANCHO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTANCHO AS ANCHO'
				Case lcAtributo == 'RESTRINGIRDESCUENTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTSINDES AS RESTRINGIRDESCUENTOS'
				Case lcAtributo == 'TEMPORADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ATEMPORADA AS TEMPORADA'
				Case lcAtributo == 'ALTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTALTO AS ALTO'
				Case lcAtributo == 'RESTRINGIRARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTREST AS RESTRINGIRARTICULO'
				Case lcAtributo == 'ANO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANO AS ANO'
				Case lcAtributo == 'REQUIERECCOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REQCCOSTO AS REQUIERECCOSTO'
				Case lcAtributo == 'MARCA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MARCA AS MARCA'
				Case lcAtributo == 'NOPUBLICARENECOMMERCE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PUBECOM AS NOPUBLICARENECOMMERCE'
				Case lcAtributo == 'SOLOPROMOYKIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROMOYKIT AS SOLOPROMOYKIT'
				Case lcAtributo == 'FAMILIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMILIA AS FAMILIA'
				Case lcAtributo == 'MATERIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MAT AS MATERIAL'
				Case lcAtributo == 'LINEA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LINEA AS LINEA'
				Case lcAtributo == 'GRUPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GRUPO AS GRUPO'
				Case lcAtributo == 'CATEGORIADEARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATEARTI AS CATEGORIADEARTICULO'
				Case lcAtributo == 'CLASIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLASIFART AS CLASIFICACION'
				Case lcAtributo == 'TIPODEARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOARTI AS TIPODEARTICULO'
				Case lcAtributo == 'CONDICIONIVAVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTCONIVA AS CONDICIONIVAVENTAS'
				Case lcAtributo == 'PORCENTAJEIVAVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTPORIVA AS PORCENTAJEIVAVENTAS'
				Case lcAtributo == 'CONDICIONIVACOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTIVA AS CONDICIONIVACOMPRAS'
				Case lcAtributo == 'PORCENTAJEIVACOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANX2 AS PORCENTAJEIVACOMPRAS'
				Case lcAtributo == 'PORCENTAJEIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPINTERNO AS PORCENTAJEIMPUESTOINTERNO'
				Case lcAtributo == 'NOMENCLADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTNARBA AS NOMENCLADOR'
				Case lcAtributo == 'PERCEPCIONIVARG5329'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTPERCEP AS PERCEPCIONIVARG5329'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AOBS AS OBSERVACION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleAgruPubliDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'AGRUPAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUP AS AGRUPAMIENTO'
				Case lcAtributo == 'AGRUPAMIENTODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUPDES AS AGRUPAMIENTODETALLE'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleParticipantesDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IPPART AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTDET AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IPCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLDET AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IPTALLE AS TALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANT AS CANTIDAD'
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
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOAGRUPAMIENTOPUBLICACIONES'
				lcCampo = 'TIPAGRUPUB'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'IMPORTADO'
				lcCampo = 'IMPORTADO'
			Case upper( alltrim( tcAtributo ) ) == 'IMAGEN'
				lcCampo = 'ARIMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'PALETADECOLORES'
				lcCampo = 'PALCOL'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'ARTCOD'
			Case upper( alltrim( tcAtributo ) ) == 'NOCOMERCIALIZABLE'
				lcCampo = 'NOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'DESCECOMMERCE'
				lcCampo = 'DESECO'
			Case upper( alltrim( tcAtributo ) ) == 'PESO'
				lcCampo = 'ARTPESO'
			Case upper( alltrim( tcAtributo ) ) == 'IMPRIMEDESPACHO'
				lcCampo = 'ESIMPDES'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'ARTDES'
			Case upper( alltrim( tcAtributo ) ) == 'CURVADETALLES'
				lcCampo = 'CURTALL'
			Case upper( alltrim( tcAtributo ) ) == 'DESCECOMMERCEHTML'
				lcCampo = 'DESECOHTML'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONADICIONAL'
				lcCampo = 'ARTDESADIC'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'ARTFAB'
			Case upper( alltrim( tcAtributo ) ) == 'LARGO'
				lcCampo = 'ARTLARGO'
			Case upper( alltrim( tcAtributo ) ) == 'NOPERMITEDEVOLUCIONES'
				lcCampo = 'ARTNODEVO'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'ASTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDADDEMEDIDA'
				lcCampo = 'UNIMED'
			Case upper( alltrim( tcAtributo ) ) == 'ANCHO'
				lcCampo = 'ARTANCHO'
			Case upper( alltrim( tcAtributo ) ) == 'RESTRINGIRDESCUENTOS'
				lcCampo = 'ARTSINDES'
			Case upper( alltrim( tcAtributo ) ) == 'TEMPORADA'
				lcCampo = 'ATEMPORADA'
			Case upper( alltrim( tcAtributo ) ) == 'ALTO'
				lcCampo = 'ARTALTO'
			Case upper( alltrim( tcAtributo ) ) == 'RESTRINGIRARTICULO'
				lcCampo = 'ARTREST'
			Case upper( alltrim( tcAtributo ) ) == 'ANO'
				lcCampo = 'ANO'
			Case upper( alltrim( tcAtributo ) ) == 'REQUIERECCOSTO'
				lcCampo = 'REQCCOSTO'
			Case upper( alltrim( tcAtributo ) ) == 'MARCA'
				lcCampo = 'MARCA'
			Case upper( alltrim( tcAtributo ) ) == 'NOPUBLICARENECOMMERCE'
				lcCampo = 'PUBECOM'
			Case upper( alltrim( tcAtributo ) ) == 'SOLOPROMOYKIT'
				lcCampo = 'PROMOYKIT'
			Case upper( alltrim( tcAtributo ) ) == 'FAMILIA'
				lcCampo = 'FAMILIA'
			Case upper( alltrim( tcAtributo ) ) == 'MATERIAL'
				lcCampo = 'MAT'
			Case upper( alltrim( tcAtributo ) ) == 'LINEA'
				lcCampo = 'LINEA'
			Case upper( alltrim( tcAtributo ) ) == 'GRUPO'
				lcCampo = 'GRUPO'
			Case upper( alltrim( tcAtributo ) ) == 'CATEGORIADEARTICULO'
				lcCampo = 'CATEARTI'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACION'
				lcCampo = 'CLASIFART'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODEARTICULO'
				lcCampo = 'TIPOARTI'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVAVENTAS'
				lcCampo = 'ARTCONIVA'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIVAVENTAS'
				lcCampo = 'ARTPORIVA'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVACOMPRAS'
				lcCampo = 'ARTIVA'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIVACOMPRAS'
				lcCampo = 'ANX2'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIMPUESTOINTERNO'
				lcCampo = 'IMPINTERNO'
			Case upper( alltrim( tcAtributo ) ) == 'NOMENCLADOR'
				lcCampo = 'ARTNARBA'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONIVARG5329'
				lcCampo = 'ARTPERCEP'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'AOBS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleAgruPubliDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPAMIENTO'
				lcCampo = 'AGRUP'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPAMIENTODETALLE'
				lcCampo = 'AGRUPDES'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleParticipantesDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'IPPART'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'ARTDET'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'IPCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'COLDET'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'IPTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANT'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'AGRUPUBLIDETALLE'
			lcRetorno = 'AGRUPUBART'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'PARTICIPANTESDETALLE'
			lcRetorno = 'KITPARTDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxArtFecimpo, lxArtFectrans, lxArtFmodifw, lxArtFaltafw, lxArtFecexpo, lxArtHoraexpo, lxArtEsttrans, lxArtHaltafw, lxArtBdaltafw, lxArtSaltafw, lxArtVmodifw, lxArtDescfw, lxArtZadsfw, lxArtValtafw, lxArtUmodifw, lxArtHoraimpo, lxArtHmodifw, lxArtBdmodifw, lxArtUaltafw, lxArtSmodifw, lxArtTimestamp, lxArtTipagrupub, lxArtBloqreg, lxArtImportado, lxArtArimagen, lxArtPalcol, lxArtArtcod, lxArtNocom, lxArtDeseco, lxArtArtpeso, lxArtEsimpdes, lxArtArtdes, lxArtCurtall, lxArtDesecohtml, lxArtArtdesadic, lxArtArtfab, lxArtArtlargo, lxArtArtnodevo, lxArtAstock, lxArtUnimed, lxArtArtancho, lxArtArtsindes, lxArtAtemporada, lxArtArtalto, lxArtArtrest, lxArtAno, lxArtReqccosto, lxArtMarca, lxArtPubecom, lxArtPromoykit, lxArtFamilia, lxArtMat, lxArtLinea, lxArtGrupo, lxArtCatearti, lxArtClasifart, lxArtTipoarti, lxArtArtconiva, lxArtArtporiva, lxArtArtiva, lxArtAnx2, lxArtImpinterno, lxArtArtnarba, lxArtArtpercep, lxArtAobs
				lxArtFecimpo =  .Fechaimpo			lxArtFectrans =  .Fechatransferencia			lxArtFmodifw =  .Fechamodificacionfw			lxArtFaltafw =  .Fechaaltafw			lxArtFecexpo =  .Fechaexpo			lxArtHoraexpo =  .Horaexpo			lxArtEsttrans =  .Estadotransferencia			lxArtHaltafw =  .Horaaltafw			lxArtBdaltafw =  .Basededatosaltafw			lxArtSaltafw =  .Seriealtafw			lxArtVmodifw =  .Versionmodificacionfw			lxArtDescfw =  .Descripcionfw			lxArtZadsfw =  .Zadsfw			lxArtValtafw =  .Versionaltafw			lxArtUmodifw =  .Usuariomodificacionfw			lxArtHoraimpo =  .Horaimpo			lxArtHmodifw =  .Horamodificacionfw			lxArtBdmodifw =  .Basededatosmodificacionfw			lxArtUaltafw =  .Usuarioaltafw			lxArtSmodifw =  .Seriemodificacionfw			lxArtTimestamp = goLibrerias.ObtenerTimestamp()			lxArtTipagrupub =  .Tipoagrupamientopublicaciones			lxArtBloqreg =  .Bloquearregistro			lxArtImportado =  .Importado			lxArtArimagen =  .Imagen			lxArtPalcol =  upper( .Paletadecolores_PK ) 			lxArtArtcod =  .Codigo			lxArtNocom =  .Nocomercializable			lxArtDeseco =  .Descecommerce			lxArtArtpeso =  .Peso			lxArtEsimpdes =  .Imprimedespacho			lxArtArtdes =  .Descripcion			lxArtCurtall =  upper( .Curvadetalles_PK ) 			lxArtDesecohtml =  .Descecommercehtml			lxArtArtdesadic =  .Descripcionadicional			lxArtArtfab =  upper( .Proveedor_PK ) 			lxArtArtlargo =  .Largo			lxArtArtnodevo =  .Nopermitedevoluciones			lxArtAstock =  .Comportamiento			lxArtUnimed =  upper( .UnidadDeMedida_PK ) 			lxArtArtancho =  .Ancho			lxArtArtsindes =  .Restringirdescuentos			lxArtAtemporada =  upper( .Temporada_PK ) 			lxArtArtalto =  .Alto			lxArtArtrest =  .Restringirarticulo			lxArtAno =  .Ano			lxArtReqccosto =  .Requiereccosto			lxArtMarca =  upper( .Marca_PK ) 			lxArtPubecom =  .Nopublicarenecommerce			lxArtPromoykit =  .Solopromoykit			lxArtFamilia =  upper( .Familia_PK ) 			lxArtMat =  upper( .Material_PK ) 			lxArtLinea =  upper( .Linea_PK ) 			lxArtGrupo =  upper( .Grupo_PK ) 			lxArtCatearti =  upper( .CategoriaDeArticulo_PK ) 			lxArtClasifart =  upper( .Clasificacion_PK ) 			lxArtTipoarti =  upper( .TipodeArticulo_PK ) 			lxArtArtconiva =  .Condicionivaventas			lxArtArtporiva =  .Porcentajeivaventas			lxArtArtiva =  .Condicionivacompras			lxArtAnx2 =  .Porcentajeivacompras			lxArtImpinterno =  .Porcentajeimpuestointerno			lxArtArtnarba =  upper( .Nomenclador_PK ) 			lxArtArtpercep =  .Percepcionivarg5329			lxArtAobs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ART ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Horaexpo","Esttrans","Haltafw","Bdaltafw","Saltafw","Vmodifw","Descfw","Zadsfw","Valtafw","Umodifw","Horaimpo","Hmodifw","Bdmodifw","Ualtafw","Smodifw","Timestamp","Tipagrupub","Bloqreg","Importado","Arimagen","Palcol","Artcod","Nocom","Deseco","Artpeso","Esimpdes","Artdes","Curtall","Desecohtml","Artdesadic","Artfab","Artlargo","Artnodevo","Astock","Unimed","Artancho","Artsindes","Atemporada","Artalto","Artrest","Ano","Reqccosto","Marca","Pubecom","Promoykit","Familia","Mat","Linea","Grupo","Catearti","Clasifart","Tipoarti","Artconiva","Artporiva","Artiva","Anx2","Impinterno","Artnarba","Artpercep","Aobs" ) values ( <<"'" + this.ConvertirDateSql( lxArtFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtSmodifw ) + "'" >>, <<lxArtTimestamp >>, <<lxArtTipagrupub >>, <<iif( lxArtBloqreg, 1, 0 ) >>, <<iif( lxArtImportado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxArtArimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtPalcol ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtArtcod ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtNocom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtDeseco ) + "'" >>, <<lxArtArtpeso >>, <<iif( lxArtEsimpdes, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxArtArtdes ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtCurtall ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtDesecohtml ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtArtdesadic ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtArtfab ) + "'" >>, <<lxArtArtlargo >>, <<iif( lxArtArtnodevo, 1, 0 ) >>, <<lxArtAstock >>, <<"'" + this.FormatearTextoSql( lxArtUnimed ) + "'" >>, <<lxArtArtancho >>, <<iif( lxArtArtsindes, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxArtAtemporada ) + "'" >>, <<lxArtArtalto >>, <<"'" + this.ConvertirDateSql( lxArtArtrest ) + "'" >>, <<lxArtAno >>, <<lxArtReqccosto >>, <<"'" + this.FormatearTextoSql( lxArtMarca ) + "'" >>, <<iif( lxArtPubecom, 1, 0 ) >>, <<iif( lxArtPromoykit, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxArtFamilia ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtMat ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtLinea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtGrupo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtCatearti ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtClasifart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtTipoarti ) + "'" >>, <<lxArtArtconiva >>, <<lxArtArtporiva >>, <<lxArtArtiva >>, <<lxArtAnx2 >>, <<lxArtImpinterno >>, <<"'" + this.FormatearTextoSql( lxArtArtnarba ) + "'" >>, <<lxArtArtpercep >>, <<"'" + this.FormatearTextoSql( lxArtAobs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ART' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubART("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ParticipantesDetalle
				if this.oEntidad.ParticipantesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.KitPartDet("NROITEM","COMP","BLOQREG","CODIGO","IPPART","ARTDET","IPCOLOR","COLDET","IPTALLE","CANT" ) values ( <<lxNroitem>>, <<lxComportamiento>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>> ) 
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
			local  lxArtFecimpo, lxArtFectrans, lxArtFmodifw, lxArtFaltafw, lxArtFecexpo, lxArtHoraexpo, lxArtEsttrans, lxArtHaltafw, lxArtBdaltafw, lxArtSaltafw, lxArtVmodifw, lxArtDescfw, lxArtZadsfw, lxArtValtafw, lxArtUmodifw, lxArtHoraimpo, lxArtHmodifw, lxArtBdmodifw, lxArtUaltafw, lxArtSmodifw, lxArtTimestamp, lxArtTipagrupub, lxArtBloqreg, lxArtImportado, lxArtArimagen, lxArtPalcol, lxArtArtcod, lxArtNocom, lxArtDeseco, lxArtArtpeso, lxArtEsimpdes, lxArtArtdes, lxArtCurtall, lxArtDesecohtml, lxArtArtdesadic, lxArtArtfab, lxArtArtlargo, lxArtArtnodevo, lxArtAstock, lxArtUnimed, lxArtArtancho, lxArtArtsindes, lxArtAtemporada, lxArtArtalto, lxArtArtrest, lxArtAno, lxArtReqccosto, lxArtMarca, lxArtPubecom, lxArtPromoykit, lxArtFamilia, lxArtMat, lxArtLinea, lxArtGrupo, lxArtCatearti, lxArtClasifart, lxArtTipoarti, lxArtArtconiva, lxArtArtporiva, lxArtArtiva, lxArtAnx2, lxArtImpinterno, lxArtArtnarba, lxArtArtpercep, lxArtAobs
				lxArtFecimpo =  .Fechaimpo			lxArtFectrans =  .Fechatransferencia			lxArtFmodifw =  .Fechamodificacionfw			lxArtFaltafw =  .Fechaaltafw			lxArtFecexpo =  .Fechaexpo			lxArtHoraexpo =  .Horaexpo			lxArtEsttrans =  .Estadotransferencia			lxArtHaltafw =  .Horaaltafw			lxArtBdaltafw =  .Basededatosaltafw			lxArtSaltafw =  .Seriealtafw			lxArtVmodifw =  .Versionmodificacionfw			lxArtDescfw =  .Descripcionfw			lxArtZadsfw =  .Zadsfw			lxArtValtafw =  .Versionaltafw			lxArtUmodifw =  .Usuariomodificacionfw			lxArtHoraimpo =  .Horaimpo			lxArtHmodifw =  .Horamodificacionfw			lxArtBdmodifw =  .Basededatosmodificacionfw			lxArtUaltafw =  .Usuarioaltafw			lxArtSmodifw =  .Seriemodificacionfw			lxArtTimestamp = goLibrerias.ObtenerTimestamp()			lxArtTipagrupub =  .Tipoagrupamientopublicaciones			lxArtBloqreg =  .Bloquearregistro			lxArtImportado =  .Importado			lxArtArimagen =  .Imagen			lxArtPalcol =  upper( .Paletadecolores_PK ) 			lxArtArtcod =  .Codigo			lxArtNocom =  .Nocomercializable			lxArtDeseco =  .Descecommerce			lxArtArtpeso =  .Peso			lxArtEsimpdes =  .Imprimedespacho			lxArtArtdes =  .Descripcion			lxArtCurtall =  upper( .Curvadetalles_PK ) 			lxArtDesecohtml =  .Descecommercehtml			lxArtArtdesadic =  .Descripcionadicional			lxArtArtfab =  upper( .Proveedor_PK ) 			lxArtArtlargo =  .Largo			lxArtArtnodevo =  .Nopermitedevoluciones			lxArtAstock =  .Comportamiento			lxArtUnimed =  upper( .UnidadDeMedida_PK ) 			lxArtArtancho =  .Ancho			lxArtArtsindes =  .Restringirdescuentos			lxArtAtemporada =  upper( .Temporada_PK ) 			lxArtArtalto =  .Alto			lxArtArtrest =  .Restringirarticulo			lxArtAno =  .Ano			lxArtReqccosto =  .Requiereccosto			lxArtMarca =  upper( .Marca_PK ) 			lxArtPubecom =  .Nopublicarenecommerce			lxArtPromoykit =  .Solopromoykit			lxArtFamilia =  upper( .Familia_PK ) 			lxArtMat =  upper( .Material_PK ) 			lxArtLinea =  upper( .Linea_PK ) 			lxArtGrupo =  upper( .Grupo_PK ) 			lxArtCatearti =  upper( .CategoriaDeArticulo_PK ) 			lxArtClasifart =  upper( .Clasificacion_PK ) 			lxArtTipoarti =  upper( .TipodeArticulo_PK ) 			lxArtArtconiva =  .Condicionivaventas			lxArtArtporiva =  .Porcentajeivaventas			lxArtArtiva =  .Condicionivacompras			lxArtAnx2 =  .Porcentajeivacompras			lxArtImpinterno =  .Porcentajeimpuestointerno			lxArtArtnarba =  upper( .Nomenclador_PK ) 			lxArtArtpercep =  .Percepcionivarg5329			lxArtAobs =  .Observacion
		endwith
		With this
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  this.ConvertirDateSql( .oEntidad.oAtributosAuditoria.NoComercializable) != this.ConvertirDateSql( .oEntidad.NoComercializable) or  this.ConvertirDateSql( .oEntidad.oAtributosAuditoria.RestringirArticulo) != this.ConvertirDateSql( .oEntidad.RestringirArticulo) )
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Artcod" = ] + lcValorClavePrimariaString  + [ and  ART.ARTCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ART set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxArtFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxArtFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxArtFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxArtFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxArtFecexpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxArtHoraexpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxArtEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxArtHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxArtBdaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxArtSaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxArtVmodifw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxArtDescfw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxArtZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxArtValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxArtUmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxArtHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxArtHmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxArtBdmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxArtUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxArtSmodifw ) + "'">>, "Timestamp" = <<lxArtTimestamp>>, "Tipagrupub" = <<lxArtTipagrupub>>, "Bloqreg" = <<iif( lxArtBloqreg, 1, 0 )>>, "Importado" = <<iif( lxArtImportado, 1, 0 )>>, "Arimagen" = <<"'" + this.FormatearTextoSql( lxArtArimagen ) + "'">>, "Palcol" = <<"'" + this.FormatearTextoSql( lxArtPalcol ) + "'">>, "Artcod" = <<"'" + this.FormatearTextoSql( lxArtArtcod ) + "'">>, "Nocom" = <<"'" + this.ConvertirDateSql( lxArtNocom ) + "'">>, "Deseco" = <<"'" + this.FormatearTextoSql( lxArtDeseco ) + "'">>, "Artpeso" = <<lxArtArtpeso>>, "Esimpdes" = <<iif( lxArtEsimpdes, 1, 0 )>>, "Artdes" = <<"'" + this.FormatearTextoSql( lxArtArtdes ) + "'">>, "Curtall" = <<"'" + this.FormatearTextoSql( lxArtCurtall ) + "'">>, "Desecohtml" = <<"'" + this.FormatearTextoSql( lxArtDesecohtml ) + "'">>, "Artdesadic" = <<"'" + this.FormatearTextoSql( lxArtArtdesadic ) + "'">>, "Artfab" = <<"'" + this.FormatearTextoSql( lxArtArtfab ) + "'">>, "Artlargo" = <<lxArtArtlargo>>, "Artnodevo" = <<iif( lxArtArtnodevo, 1, 0 )>>, "Astock" = <<lxArtAstock>>, "Unimed" = <<"'" + this.FormatearTextoSql( lxArtUnimed ) + "'">>, "Artancho" = <<lxArtArtancho>>, "Artsindes" = <<iif( lxArtArtsindes, 1, 0 )>>, "Atemporada" = <<"'" + this.FormatearTextoSql( lxArtAtemporada ) + "'">>, "Artalto" = <<lxArtArtalto>>, "Artrest" = <<"'" + this.ConvertirDateSql( lxArtArtrest ) + "'">>, "Ano" = <<lxArtAno>>, "Reqccosto" = <<lxArtReqccosto>>, "Marca" = <<"'" + this.FormatearTextoSql( lxArtMarca ) + "'">>, "Pubecom" = <<iif( lxArtPubecom, 1, 0 )>>, "Promoykit" = <<iif( lxArtPromoykit, 1, 0 )>>, "Familia" = <<"'" + this.FormatearTextoSql( lxArtFamilia ) + "'">>, "Mat" = <<"'" + this.FormatearTextoSql( lxArtMat ) + "'">>, "Linea" = <<"'" + this.FormatearTextoSql( lxArtLinea ) + "'">>, "Grupo" = <<"'" + this.FormatearTextoSql( lxArtGrupo ) + "'">>, "Catearti" = <<"'" + this.FormatearTextoSql( lxArtCatearti ) + "'">>, "Clasifart" = <<"'" + this.FormatearTextoSql( lxArtClasifart ) + "'">>, "Tipoarti" = <<"'" + this.FormatearTextoSql( lxArtTipoarti ) + "'">>, "Artconiva" = <<lxArtArtconiva>>, "Artporiva" = <<lxArtArtporiva>>, "Artiva" = <<lxArtArtiva>>, "Anx2" = <<lxArtAnx2>>, "Impinterno" = <<lxArtImpinterno>>, "Artnarba" = <<"'" + this.FormatearTextoSql( lxArtArtnarba ) + "'">>, "Artpercep" = <<lxArtArtpercep>>, "Aobs" = <<"'" + this.FormatearTextoSql( lxArtAobs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ART' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
		If llInsertarAuditoria
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		EndIf
			loColeccion.Agregar([delete from ZooLogic.AgruPubART where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.KitPartDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubART("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ParticipantesDetalle
				if this.oEntidad.ParticipantesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.KitPartDet("NROITEM","COMP","BLOQREG","CODIGO","IPPART","ARTDET","IPCOLOR","COLDET","IPTALLE","CANT" ) values ( <<lxNroitem>>, <<lxComportamiento>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>> ) 
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

			lcFiltro = ["Artcod" = ] + lcValorClavePrimariaString  + [ and  ART.ARTCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.ART where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.AgruPubART where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.KitPartDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'ART' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ART where  ART.ARTCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ART where ARTCOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  ART.ARTCOD != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxARTNOCOM as variant, lxARTArtRest as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ARTICULO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ART Where ARTCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTCOD ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					local llInsertarAuditoria as boolean
					llInsertarAuditoria = (  iif( isnull( ( curSeek.NOCOM != &lcCursor..NOCOM ) and ( !empty( goServicios.Librerias.ObtenerFechaFormateada( curSeek.NOCOM ) ) or !empty( goServicios.Librerias.ObtenerFechaFormateada( &lcCursor..NOCOM ) ) ) ), .F., ( curSeek.NOCOM != &lcCursor..NOCOM ) and ( !empty( goServicios.Librerias.ObtenerFechaFormateada( curSeek.NOCOM ) ) or !empty( goServicios.Librerias.ObtenerFechaFormateada( &lcCursor..NOCOM ) ) ) ) or  iif( isnull( ( curSeek.ArtRest != &lcCursor..ArtRest ) and ( !empty( goServicios.Librerias.ObtenerFechaFormateada( curSeek.ArtRest ) ) or !empty( goServicios.Librerias.ObtenerFechaFormateada( &lcCursor..ArtRest ) ) ) ), .F., ( curSeek.ArtRest != &lcCursor..ArtRest ) and ( !empty( goServicios.Librerias.ObtenerFechaFormateada( curSeek.ArtRest ) ) or !empty( goServicios.Librerias.ObtenerFechaFormateada( &lcCursor..ArtRest ) ) ) ) )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					if this.oentidad.lActualizarSoloEquivalenciasDeLince
						local lcCadena as String, lnPos as integer
						lnPos = recno(lcCursor)
						afields( laEst, lcCursor )
						lcCadena = [Replace in &lcCursor ]
						if empty( this.oEntidad.CamposEquivalenciaLince )
							this.oEntidad.CamposEquivalenciaLince = this.oEntidad.ObtenerCamposSegunEquivalencia(@laEst)
						endif 
						lcCadena = lcCadena + this.oEntidad.CamposEquivalenciaLince
						lcCadena = lcCadena + [ for ARTCOD= curseek.ARTCOD]
						&lcCadena.
						select( lcCursor )
						go lnPos
					endif
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.ART set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, tipagrupub = ] + transform( &lcCursor..tipagrupub )+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, Importado = ] + Transform( iif( &lcCursor..Importado, 1, 0 ))+ [, ARIMAGEN = ] + "'" + this.FormatearTextoSql( &lcCursor..ARIMAGEN ) + "'"+ [, PalCol = ] + "'" + this.FormatearTextoSql( &lcCursor..PalCol ) + "'"+ [, ARTCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTCOD ) + "'"+ [, NOCOM = ] + "'" + this.ConvertirDateSql( &lcCursor..NOCOM ) + "'"+ [, DesEco = ] + "'" + this.FormatearTextoSql( &lcCursor..DesEco ) + "'"+ [, ARTPESO = ] + transform( &lcCursor..ARTPESO )+ [, EsImpDes = ] + Transform( iif( &lcCursor..EsImpDes, 1, 0 ))+ [, ARTDES = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTDES ) + "'"+ [, Curtall = ] + "'" + this.FormatearTextoSql( &lcCursor..Curtall ) + "'"+ [, DesEcoHTML = ] + "'" + this.FormatearTextoSql( &lcCursor..DesEcoHTML ) + "'"+ [, ARTDESADIC = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTDESADIC ) + "'"+ [, ARTFAB = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTFAB ) + "'"+ [, ARTLARGO = ] + transform( &lcCursor..ARTLARGO )+ [, ARTNODEVO = ] + Transform( iif( &lcCursor..ARTNODEVO, 1, 0 ))+ [, ASTOCK = ] + transform( &lcCursor..ASTOCK )+ [, UniMed = ] + "'" + this.FormatearTextoSql( &lcCursor..UniMed ) + "'"+ [, ARTANCHO = ] + transform( &lcCursor..ARTANCHO )+ [, ArtSinDes = ] + Transform( iif( &lcCursor..ArtSinDes, 1, 0 ))+ [, ATEMPORADA = ] + "'" + this.FormatearTextoSql( &lcCursor..ATEMPORADA ) + "'"+ [, ARTALTO = ] + transform( &lcCursor..ARTALTO )+ [, ArtRest = ] + "'" + this.ConvertirDateSql( &lcCursor..ArtRest ) + "'"+ [, Ano = ] + transform( &lcCursor..Ano )+ [, ReqCCosto = ] + transform( &lcCursor..ReqCCosto )+ [, Marca = ] + "'" + this.FormatearTextoSql( &lcCursor..Marca ) + "'"+ [, PubEcom = ] + Transform( iif( &lcCursor..PubEcom, 1, 0 ))+ [, PromoYKit = ] + Transform( iif( &lcCursor..PromoYKit, 1, 0 ))+ [, Familia = ] + "'" + this.FormatearTextoSql( &lcCursor..Familia ) + "'"+ [, Mat = ] + "'" + this.FormatearTextoSql( &lcCursor..Mat ) + "'"+ [, Linea = ] + "'" + this.FormatearTextoSql( &lcCursor..Linea ) + "'"+ [, Grupo = ] + "'" + this.FormatearTextoSql( &lcCursor..Grupo ) + "'"+ [, CateArti = ] + "'" + this.FormatearTextoSql( &lcCursor..CateArti ) + "'"+ [, ClasifArt = ] + "'" + this.FormatearTextoSql( &lcCursor..ClasifArt ) + "'"+ [, TipoArti = ] + "'" + this.FormatearTextoSql( &lcCursor..TipoArti ) + "'"+ [, ARTCONIVA = ] + transform( &lcCursor..ARTCONIVA )+ [, ARTPORIVA = ] + transform( &lcCursor..ARTPORIVA )+ [, ARTIVA = ] + transform( &lcCursor..ARTIVA )+ [, ANX2 = ] + transform( &lcCursor..ANX2 )+ [, impinterno = ] + transform( &lcCursor..impinterno )+ [, ARTNARBA = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTNARBA ) + "'"+ [, ArtPercep = ] + transform( &lcCursor..ArtPercep )+ [, AObs = ] + "'" + this.FormatearTextoSql( &lcCursor..AObs ) + "'" + [ Where ARTCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTCOD ) + "'" )
					lcCampo = lcCursor + '.' + this.cCampoCodigoWH
					this.AgregarMensajeWebHook( 'MODIFICAR', &lcCampo )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					if llInsertarAuditoria
						lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
						this.oConexion.EjecutarSql( lcSentencia )
					EndIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FALTAFW, FECEXPO, HORAEXPO, ESTTRANS, HALTAFW, BDALTAFW, SALTAFW, VMODIFW, DescFW, ZADSFW, VALTAFW, UMODIFW, HORAIMPO, HMODIFW, BDMODIFW, UALTAFW, SMODIFW, TIMESTAMP, tipagrupub, BLOQREG, Importado, ARIMAGEN, PalCol, ARTCOD, NOCOM, DesEco, ARTPESO, EsImpDes, ARTDES, Curtall, DesEcoHTML, ARTDESADIC, ARTFAB, ARTLARGO, ARTNODEVO, ASTOCK, UniMed, ARTANCHO, ArtSinDes, ATEMPORADA, ARTALTO, ArtRest, Ano, ReqCCosto, Marca, PubEcom, PromoYKit, Familia, Mat, Linea, Grupo, CateArti, ClasifArt, TipoArti, ARTCONIVA, ARTPORIVA, ARTIVA, ANX2, impinterno, ARTNARBA, ArtPercep, AObs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..tipagrupub ) + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 )) + ',' + Transform( iif( &lcCursor..Importado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ARIMAGEN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PalCol ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ARTCOD ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..NOCOM ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..DesEco ) + "'" + ',' + transform( &lcCursor..ARTPESO ) + ',' + Transform( iif( &lcCursor..EsImpDes, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ARTDES ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Curtall ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DesEcoHTML ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ARTDESADIC ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ARTFAB ) + "'" + ',' + transform( &lcCursor..ARTLARGO ) + ',' + Transform( iif( &lcCursor..ARTNODEVO, 1, 0 )) + ',' + transform( &lcCursor..ASTOCK ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..UniMed ) + "'" + ',' + transform( &lcCursor..ARTANCHO ) + ',' + Transform( iif( &lcCursor..ArtSinDes, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ATEMPORADA ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..ARTALTO ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..ArtRest ) + "'" + ',' + transform( &lcCursor..Ano ) + ',' + transform( &lcCursor..ReqCCosto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Marca ) + "'" + ',' + Transform( iif( &lcCursor..PubEcom, 1, 0 )) + ',' + Transform( iif( &lcCursor..PromoYKit, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Familia ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Mat ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Linea ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Grupo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CateArti ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClasifArt ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipoArti ) + "'" + ',' + transform( &lcCursor..ARTCONIVA )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..ARTPORIVA ) + ',' + transform( &lcCursor..ARTIVA ) + ',' + transform( &lcCursor..ANX2 ) + ',' + transform( &lcCursor..impinterno ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ARTNARBA ) + "'" + ',' + transform( &lcCursor..ArtPercep ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..AObs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.ART ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
				this.oConexion.EjecutarSql( lcSentencia )
				lcCampo = lcCursor + '.' + this.cCampoCodigoWH
				this.AgregarMensajeWebHook( 'INGRESAR', &lcCampo )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ARTICULO'
		if This.ActualizaEnRecepcion()
			if !This.oEntidad.lActualizarSoloEquivalenciasDeLince
				Local lcIn as String, lcCantRegistros as Integer
				Select( lcCursor )
				Count to lcCantRegistros
				If lcCantRegistros > 0
					lcIn = This.ObtenerInSqlServer( lcCursor, 'ARTCOD','C')
					lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
					loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','ARTCOD')
					llEjecutaEnTransaccion = loIn.count > 0
					if llEjecutaEnTransaccion
						this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
					endif
					for i = 1 to loIn.count step lnFragmento
						lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
					this.oConexion.EjecutarSql( [Delete From ZooLogic.AgruPubART Where Codigo] + lcIn  )
					this.oConexion.EjecutarSql( [Delete From ZooLogic.KitPartDet Where CODIGO] + lcIn  )
					endfor
					if llEjecutaEnTransaccion
						this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
					endif
				EndIf
			endif
			lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPAPUBLICART'
			Select * From &lcDetalle into cursor cDetallesExistentes ;
				where Codigo in ( select ARTCOD from &lcCursor )
			select cDetallesExistentes
			Scan All
				Text to lcCamposInsert noShow
					"NROITEM","Codigo","Agrup","AgrupDes"
				endText
				this.oConexion.EjecutarSql( [Insert into ZooLogic.AgruPubART ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Agrup      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AgrupDes   ) + "'" + ' )'  )
				select cDetallesExistentes
			EndScan
			Use in select( 'cDetallesExistentes' )
			lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMPARTICIPANTES'
			Select * From &lcDetalle into cursor cDetallesExistentes ;
				where CODIGO in ( select ARTCOD from &lcCursor )
			select cDetallesExistentes
			Scan All
				Text to lcCamposInsert noShow
					"NROITEM","COMP","BLOQREG","CODIGO","IPPART","ARTDET","IPCOLOR","COLDET","IPTALLE","CANT"
				endText
				this.oConexion.EjecutarSql( [Insert into ZooLogic.KitPartDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + Transform( iif( cDetallesExistentes.BLOQREG   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IPPART     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ARTDET     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IPCOLOR    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.COLDET     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IPTALLE    ) + "'" + ',' + transform( cDetallesExistentes.CANT       ) + ' )'  )
				select cDetallesExistentes
			EndScan
			Use in select( 'cDetallesExistentes' )
			Use in select( 'cExistentes' )
		endif
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( ARTCOD C (15) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..ARTCOD     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function AgregarMensajeWebHook( tcEvento as String, tcCodigo as String ) As Void

		if ( alltrim( tcEvento ) = 'MODIFICAR' and this.oEntidad.lWHModificar ) or ( alltrim( tcEvento ) = 'INGRESAR' and this.oEntidad.lWHIngresar )
			goServicios.WebHook.AgregarMensajeALaCola( tcEvento, tcCodigo, this.oEntidad.cNombre )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function EnviarColaWebHook() As Void
		goServicios.WebHook.EnviarColaDeMensajes( this.oEntidad.cNombre )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'ARTICULO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ARTICULO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ARTICULO_DESECO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ARTICULO_DESECOHTML'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ARTICULO_AOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAGRUPAPUBLICART'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMPARTICIPANTES'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ART')

				if this.oMensajesConexion.Count>0
					goServicios.Errores.LevantarExcepcion( this.ObtenerMensajesConexion() )
				endif

			enddo
		catch to loError
			goServicios.Errores.LevantarExcepcion( loError )
		endtry
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	protected function AplicarReglaDeNegocioTablaDeTrabajo( toConexion as Object ) As Void
		local llEjecutarRollback as Boolean, lcCursor as String, llNoVienePorDiseño as Boolean
		llEjecutarRollback = .F.
		try
			
			toConexion.EjecutarNonQuery( 'DISABLE TRIGGER ALL ON ZooLogic.TablaTrabajo_ART' )
			
			lcCursor = this.oentidad.cprefijoimportar + this.oentidad.cnombre
			this.AbrirCursores( PcXmlDatos, this.oEntidad.cPrefijoImportar )
			select (lcCursor)
			
			*** Valor sugerido Importado
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "Importado" )
			llNoVienePorDiseño = isnull(&lcCursor..Importado ) &&El atributo no está definido en el diseño de importación. Ésta condicion es solamente para atributos boleanos
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) ) and llNoVienePorDiseño 
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET Importado = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( Importado ) = 1" )
			endif
			
			*** Valor sugerido Imagen
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "Imagen" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET ARIMAGEN = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( ARIMAGEN ) = 1" )
			endif
			
			*** Valor sugerido NoComercializable
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "NoComercializable" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET NOCOM = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( NOCOM ) = 1" )
			endif
			
			*** Valor sugerido DescEcommerce
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "DescEcommerce" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET DesEco = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( DesEco ) = 1" )
			endif
			
			*** Valor sugerido Peso
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "Peso" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET ARTPESO = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( ARTPESO ) = 1" )
			endif
			
			*** Valor sugerido ImprimeDespacho
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "ImprimeDespacho" )
			llNoVienePorDiseño = isnull(&lcCursor..EsImpDes ) &&El atributo no está definido en el diseño de importación. Ésta condicion es solamente para atributos boleanos
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) ) and llNoVienePorDiseño 
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET EsImpDes = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( EsImpDes ) = 1" )
			endif
			
			*** Valor sugerido Descripcion
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "Descripcion" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET ARTDES = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( ARTDES ) = 1" )
			endif
			
			*** Valor sugerido DescEcommerceHTML
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "DescEcommerceHTML" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET DesEcoHTML = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( DesEcoHTML ) = 1" )
			endif
			
			*** Valor sugerido DescripcionAdicional
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "DescripcionAdicional" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET ARTDESADIC = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( ARTDESADIC ) = 1" )
			endif
			
			*** Valor sugerido Largo
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "Largo" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET ARTLARGO = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( ARTLARGO ) = 1" )
			endif
			
			*** Valor sugerido NoPermiteDevoluciones
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "NoPermiteDevoluciones" )
			llNoVienePorDiseño = isnull(&lcCursor..ARTNODEVO ) &&El atributo no está definido en el diseño de importación. Ésta condicion es solamente para atributos boleanos
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) ) and llNoVienePorDiseño 
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET ARTNODEVO = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( ARTNODEVO ) = 1" )
			endif
			
			*** Valor sugerido Comportamiento
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "Comportamiento" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET ASTOCK = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( ASTOCK ) = 1" )
			endif
			
			*** Valor sugerido Ancho
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "Ancho" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET ARTANCHO = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( ARTANCHO ) = 1" )
			endif
			
			*** Valor sugerido RestringirDescuentos
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "RestringirDescuentos" )
			llNoVienePorDiseño = isnull(&lcCursor..ArtSinDes ) &&El atributo no está definido en el diseño de importación. Ésta condicion es solamente para atributos boleanos
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) ) and llNoVienePorDiseño 
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET ArtSinDes = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( ArtSinDes ) = 1" )
			endif
			
			*** Valor sugerido Alto
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "Alto" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET ARTALTO = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( ARTALTO ) = 1" )
			endif
			
			*** Valor sugerido RestringirArticulo
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "RestringirArticulo" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET ArtRest = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( ArtRest ) = 1" )
			endif
			
			*** Valor sugerido Ano
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "Ano" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET Ano = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( Ano ) = 1" )
			endif
			
			*** Valor sugerido RequiereCCosto
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "RequiereCCosto" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET ReqCCosto = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( ReqCCosto ) = 1" )
			endif
			
			*** Valor sugerido NoPublicarEnEcommerce
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "NoPublicarEnEcommerce" )
			llNoVienePorDiseño = isnull(&lcCursor..PubEcom ) &&El atributo no está definido en el diseño de importación. Ésta condicion es solamente para atributos boleanos
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) ) and llNoVienePorDiseño 
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET PubEcom = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( PubEcom ) = 1" )
			endif
			
			*** Valor sugerido SoloPromoYKit
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "SoloPromoYKit" )
			llNoVienePorDiseño = isnull(&lcCursor..PromoYKit ) &&El atributo no está definido en el diseño de importación. Ésta condicion es solamente para atributos boleanos
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) ) and llNoVienePorDiseño 
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET PromoYKit = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( PromoYKit ) = 1" )
			endif
			
			*** Valor sugerido CondicionIvaVentas
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "CondicionIvaVentas" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET ARTCONIVA = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( ARTCONIVA ) = 1" )
			endif
			
			*** Valor sugerido PorcentajeIvaVentas
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "PorcentajeIvaVentas" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET ARTPORIVA = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( ARTPORIVA ) = 1" )
			endif
			
			*** Valor sugerido CondicionIvaCompras
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "CondicionIvaCompras" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET ARTIVA = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( ARTIVA ) = 1" )
			endif
			
			*** Valor sugerido PorcentajeIvaCompras
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "PorcentajeIvaCompras" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET ANX2 = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( ANX2 ) = 1" )
			endif
			
			*** Valor sugerido PorcentajeImpuestoInterno
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "PorcentajeImpuestoInterno" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET impinterno = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( impinterno ) = 1" )
			endif
			
			*** Valor sugerido PercepcionIvaRG5329
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "PercepcionIvaRG5329" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET ArtPercep = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( ArtPercep ) = 1" )
			endif
			
			*** Valor sugerido Observacion
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ARTICULO", "", "Observacion" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_ART SET AObs = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( AObs ) = 1" )
			endif
			
			use in ( lcCursor )
			
			lcInsertBaseLogueo = [INSERT INTO ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, EstadoDelSistema, Aplicacion, Version, Serie, Usuario, NombrePc, UsuarioPc, OrigenLogueo, Mensaje, Excepcion ) ]
			lcCamposLogueo = [Fecha, Nivel, Logger, Accion, BaseDeDatos, EstadoDelSistema, Aplicacion, Version, Serie, Usuario, NombrePc, UsuarioPc, OrigenLogueo, Excepcion, Mensaje]
			lcBD = goServicios.Seguridad.cBaseDeDatosSeleccionada
			lcApp = _Screen.Zoo.App.Nombre
			lcVersion = _Screen.Zoo.App.ObtenerVersion()
			lcSerie = _Screen.Zoo.App.cSerie
			lcUsuario = goServicios.Seguridad.cUsuarioLogueado
			lcValuesLogueoComunes = [SELECT GetDate(), 'INFO', '', 'Validacion IMPO','] + lcBD + [',0,'] + lcApp + [','] + lcVersion + [','] + lcSerie  + [','] + lcUsuario +[','NOMBREPC','USUARIOPC','ORIGENLOGUEO','',]
			
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fecha( 'ZooLogic.TablaTrabajo_ART','ZooLogic.TablaTrabajoErroresValidacion_ART', 'FECIMPO', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fecha( 'ZooLogic.TablaTrabajo_ART','ZooLogic.TablaTrabajoErroresValidacion_ART', 'FECTRANS', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fecha( 'ZooLogic.TablaTrabajo_ART','ZooLogic.TablaTrabajoErroresValidacion_ART', 'FMODIFW', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fecha( 'ZooLogic.TablaTrabajo_ART','ZooLogic.TablaTrabajoErroresValidacion_ART', 'FALTAFW', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fecha( 'ZooLogic.TablaTrabajo_ART','ZooLogic.TablaTrabajoErroresValidacion_ART', 'FECEXPO', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fechacalendario( 'ZooLogic.TablaTrabajo_ART','ZooLogic.TablaTrabajoErroresValidacion_ART', 'NOCOM', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fechacalendario( 'ZooLogic.TablaTrabajo_ART','ZooLogic.TablaTrabajoErroresValidacion_ART', 'ArtRest', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Numericononegativo( 'ZooLogic.TablaTrabajo_ART','ZooLogic.TablaTrabajoErroresValidacion_ART', 'ARTPORIVA', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Numericononegativo( 'ZooLogic.TablaTrabajo_ART','ZooLogic.TablaTrabajoErroresValidacion_ART', 'ANX2', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Impuestointerno( 'ZooLogic.TablaTrabajo_ART','ZooLogic.TablaTrabajoErroresValidacion_ART', 'impinterno', toConexion )

			* CategoriaDeArticulo FK 
			lcWhere = 'WHERE Funciones.Empty( CateArti ) = 0 AND  CateArti NOT IN ( SELECT Cod FROM ZooLogic.CATEGART )'
			lcExpresionMensaje  = ['El dato buscado ' + RTRIM( CAST( CateArti AS VARCHAR(255) ) ) + ' de la entidad CATEGORIADEARTICULO no existe.']
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_ART ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			
			* Clasificacion FK 
			lcWhere = 'WHERE Funciones.Empty( ClasifArt ) = 0 AND  ClasifArt NOT IN ( SELECT CODIGO FROM ZooLogic.CLASIFART )'
			lcExpresionMensaje  = ['El dato buscado ' + RTRIM( CAST( ClasifArt AS VARCHAR(255) ) ) + ' de la entidad CLASIFICACIONARTICULO no existe.']
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_ART ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			
			* Curvadetalles FK 
			lcWhere = 'WHERE Funciones.Empty( Curtall ) = 0 AND  Curtall NOT IN ( SELECT Codigo FROM ZooLogic.CTALLE )'
			lcExpresionMensaje  = ['El dato buscado ' + RTRIM( CAST( Curtall AS VARCHAR(255) ) ) + ' de la entidad CURVADETALLES no existe.']
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_ART ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			
			* Familia FK 
			lcWhere = 'WHERE Funciones.Empty( Familia ) = 0 AND  Familia NOT IN ( SELECT Cod FROM ZooLogic.FAMILIA )'
			lcExpresionMensaje  = ['El dato buscado ' + RTRIM( CAST( Familia AS VARCHAR(255) ) ) + ' de la entidad FAMILIA no existe.']
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_ART ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			
			* Grupo FK 
			lcWhere = 'WHERE Funciones.Empty( Grupo ) = 0 AND  Grupo NOT IN ( SELECT Cod FROM ZooLogic.Grupo )'
			lcExpresionMensaje  = ['El dato buscado ' + RTRIM( CAST( Grupo AS VARCHAR(255) ) ) + ' de la entidad GRUPO no existe.']
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_ART ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			
			* Linea FK 
			lcWhere = 'WHERE Funciones.Empty( Linea ) = 0 AND  Linea NOT IN ( SELECT Cod FROM ZooLogic.Linea )'
			lcExpresionMensaje  = ['El dato buscado ' + RTRIM( CAST( Linea AS VARCHAR(255) ) ) + ' de la entidad LINEA no existe.']
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_ART ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			
			* Marca FK 
			lcWhere = 'WHERE Funciones.Empty( Marca ) = 0 AND  Marca NOT IN ( SELECT Codigo FROM ZooLogic.MARCAS )'
			lcExpresionMensaje  = ['El dato buscado ' + RTRIM( CAST( Marca AS VARCHAR(255) ) ) + ' de la entidad MARCA no existe.']
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_ART ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			
			* Material FK 
			lcWhere = 'WHERE Funciones.Empty( Mat ) = 0 AND  Mat NOT IN ( SELECT MATCOD FROM ZooLogic.MAT )'
			lcExpresionMensaje  = ['El dato buscado ' + RTRIM( CAST( Mat AS VARCHAR(255) ) ) + ' de la entidad MATERIAL no existe.']
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_ART ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			
			* Nomenclador FK 
			lcWhere = 'WHERE Funciones.Empty( ARTNARBA ) = 0 AND  ARTNARBA NOT IN ( SELECT NMCCOD FROM ZooLogic.NMCARBA )'
			lcExpresionMensaje  = ['El dato buscado ' + RTRIM( CAST( ARTNARBA AS VARCHAR(255) ) ) + ' de la entidad NOMENCLADORARBA no existe.']
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_ART ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			
			* Paletadecolores FK 
			lcWhere = 'WHERE Funciones.Empty( PalCol ) = 0 AND  PalCol NOT IN ( SELECT Codigo FROM ZooLogic.PCOLOR )'
			lcExpresionMensaje  = ['El dato buscado ' + RTRIM( CAST( PalCol AS VARCHAR(255) ) ) + ' de la entidad PALETADECOLORES no existe.']
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_ART ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			
			* Proveedor FK 
			lcWhere = 'WHERE Funciones.Empty( ARTFAB ) = 0 AND  ARTFAB NOT IN ( SELECT CLCOD FROM ZooLogic.PROV )'
			lcExpresionMensaje  = ['El dato buscado ' + RTRIM( CAST( ARTFAB AS VARCHAR(255) ) ) + ' de la entidad PROVEEDOR no existe.']
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_ART ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			
			* Temporada FK 
			lcWhere = 'WHERE Funciones.Empty( ATEMPORADA ) = 0 AND  ATEMPORADA NOT IN ( SELECT TCOD FROM ZooLogic.Temporada )'
			lcExpresionMensaje  = ['El dato buscado ' + RTRIM( CAST( ATEMPORADA AS VARCHAR(255) ) ) + ' de la entidad TEMPORADA no existe.']
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_ART ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			
			* TipodeArticulo FK 
			lcWhere = 'WHERE Funciones.Empty( TipoArti ) = 0 AND  TipoArti NOT IN ( SELECT Cod FROM ZooLogic.TIPOART )'
			lcExpresionMensaje  = ['El dato buscado ' + RTRIM( CAST( TipoArti AS VARCHAR(255) ) ) + ' de la entidad TIPODEARTICULO no existe.']
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_ART ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			
			* UnidadDeMedida FK 
			lcWhere = 'WHERE Funciones.Empty( UniMed ) = 0 AND  UniMed NOT IN ( SELECT Cod FROM ZooLogic.Unmed )'
			lcExpresionMensaje  = ['El dato buscado ' + RTRIM( CAST( UniMed AS VARCHAR(255) ) ) + ' de la entidad UNIDADDEMEDIDA no existe.']
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_ART ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_ART ] + lcWhere )
			
			this.oEntidad.EjecutarReglaDeNegocioPersonalizadaImportacion( toConexion )
			toConexion.EjecutarNonQuery( 'ENABLE TRIGGER ALL ON ZooLogic.TablaTrabajo_ART' )
		catch to loError
			goServicios.Errores.LevantarExcepcion( loError )
		endtry
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	*--------------------------------------------------------------------------------------------------------
	protected function ValidarDatosAImportar() as boolean
		local lcCursor as String, llRetorno as boolean, lxVar as Variant, llCondicion as boolean
		lcCursor = This.oEntidad.cPrefijoImportar + 'ARTICULO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..ARTCOD
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ARTICULO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ARTICULO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,ARTCOD as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( ARTCOD, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ARTICULO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  NOCOM     
		* Validar ANTERIORES A 1/1/1753  ArtRest   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ART') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ART
Create Table ZooLogic.TablaTrabajo_ART ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"horaexpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"descfw" char( 200 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"tipagrupub" numeric( 1, 0 )  null, 
"bloqreg" bit  null, 
"importado" bit  null, 
"arimagen" char( 180 )  null, 
"palcol" char( 10 )  null, 
"artcod" char( 15 )  null, 
"nocom" datetime  null, 
"deseco" varchar(max)  null, 
"artpeso" numeric( 11, 3 )  null, 
"esimpdes" bit  null, 
"artdes" char( 100 )  null, 
"curtall" char( 10 )  null, 
"desecohtml" varchar(max)  null, 
"artdesadic" char( 254 )  null, 
"artfab" char( 10 )  null, 
"artlargo" numeric( 11, 2 )  null, 
"artnodevo" bit  null, 
"astock" numeric( 1, 0 )  null, 
"unimed" char( 3 )  null, 
"artancho" numeric( 11, 2 )  null, 
"artsindes" bit  null, 
"atemporada" char( 5 )  null, 
"artalto" numeric( 11, 2 )  null, 
"artrest" datetime  null, 
"ano" numeric( 4, 0 )  null, 
"reqccosto" numeric( 1, 0 )  null, 
"marca" char( 30 )  null, 
"pubecom" bit  null, 
"promoykit" bit  null, 
"familia" char( 10 )  null, 
"mat" char( 10 )  null, 
"linea" char( 10 )  null, 
"grupo" char( 10 )  null, 
"catearti" char( 10 )  null, 
"clasifart" char( 10 )  null, 
"tipoarti" char( 10 )  null, 
"artconiva" numeric( 1, 0 )  null, 
"artporiva" numeric( 5, 2 )  null, 
"artiva" numeric( 1, 0 )  null, 
"anx2" numeric( 5, 2 )  null, 
"impinterno" numeric( 5, 2 )  null, 
"artnarba" char( 6 )  null, 
"artpercep" numeric( 1, 0 )  null, 
"aobs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ART' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ART' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearTablaDeTrabajoDetalles( toConexion as Object ) as void

		* TablaTrabajo_ART_AgruPubART
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ART_AgruPubART') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ART_AgruPubART
Create Table ZooLogic.TablaTrabajo_ART_AgruPubART ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"nroitem" numeric( 5, 0 )  null, 
"codigo" char( 15 )  null, 
"agrup" char( 21 )  null, 
"agrupdes" char( 254 )  null, 
"campo0" numeric( 20, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia_AgruPubART( 'TablaTrabajo_ART_AgruPubART' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion_AgruPubART( 'TablaTrabajo_ART_AgruPubART' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )

		* TablaTrabajo_ART_KitPartDet
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ART_KitPartDet') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ART_KitPartDet
Create Table ZooLogic.TablaTrabajo_ART_KitPartDet ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"nroitem" numeric( 5, 0 )  null, 
"comp" numeric( 1, 0 )  null, 
"bloqreg" bit  null, 
"codigo" char( 15 )  null, 
"ippart" char( 15 )  null, 
"artdet" char( 100 )  null, 
"ipcolor" char( 6 )  null, 
"coldet" char( 50 )  null, 
"iptalle" char( 5 )  null, 
"cant" numeric( 13, 2 )  null, 
"campo0" numeric( 20, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia_KitPartDet( 'TablaTrabajo_ART_KitPartDet' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion_KitPartDet( 'TablaTrabajo_ART_KitPartDet' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ARTICULO'
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
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('tipagrupub','tipagrupub')
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('importado','importado')
			.AgregarMapeo('arimagen','arimagen')
			.AgregarMapeo('palcol','palcol')
			.AgregarMapeo('artcod','artcod')
			.AgregarMapeo('nocom','nocom')
			.AgregarMapeo('deseco','deseco')
			.AgregarMapeo('artpeso','artpeso')
			.AgregarMapeo('esimpdes','esimpdes')
			.AgregarMapeo('artdes','artdes')
			.AgregarMapeo('curtall','curtall')
			.AgregarMapeo('desecohtml','desecohtml')
			.AgregarMapeo('artdesadic','artdesadic')
			.AgregarMapeo('artfab','artfab')
			.AgregarMapeo('artlargo','artlargo')
			.AgregarMapeo('artnodevo','artnodevo')
			.AgregarMapeo('astock','astock')
			.AgregarMapeo('unimed','unimed')
			.AgregarMapeo('artancho','artancho')
			.AgregarMapeo('artsindes','artsindes')
			.AgregarMapeo('atemporada','atemporada')
			.AgregarMapeo('artalto','artalto')
			.AgregarMapeo('artrest','artrest')
			.AgregarMapeo('ano','ano')
			.AgregarMapeo('reqccosto','reqccosto')
			.AgregarMapeo('marca','marca')
			.AgregarMapeo('pubecom','pubecom')
			.AgregarMapeo('promoykit','promoykit')
			.AgregarMapeo('familia','familia')
			.AgregarMapeo('mat','mat')
			.AgregarMapeo('linea','linea')
			.AgregarMapeo('grupo','grupo')
			.AgregarMapeo('catearti','catearti')
			.AgregarMapeo('clasifart','clasifart')
			.AgregarMapeo('tipoarti','tipoarti')
			.AgregarMapeo('artconiva','artconiva')
			.AgregarMapeo('artporiva','artporiva')
			.AgregarMapeo('artiva','artiva')
			.AgregarMapeo('anx2','anx2')
			.AgregarMapeo('impinterno','impinterno')
			.AgregarMapeo('artnarba','artnarba')
			.AgregarMapeo('artpercep','artpercep')
			.AgregarMapeo('aobs','aobs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ART'
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
	protected function CargarTablaDeTrabajoDetalles( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPAPUBLICART'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + 'ITEMAGRUPAPUBLICART'
		endif
		if used( lcCursor )
		with loManejador
			.AgregarMapeo('campo0','campo0')
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('nroitem','nroitem')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('agrup','agrup')
			.AgregarMapeo('agrupdes','agrupdes')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ART_AgruPubART'
			.ConsultaOrigen = 'select * from ' + lcCursor
			Select( lcCursor )
			Count to This.nCantVeces
			This.nCantVeces = ceiling( This.nCantVeces / This.nCantABorrar )
			if !this.oEntidad.VerificarContexto( 'CB' )
				use in ( lcCursor )
			endif
			.ImportarMasivamente( toConexion )
			
		endwith
		endif
			
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ITEMPARTICIPANTES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + 'ITEMPARTICIPANTES'
		endif
		if used( lcCursor )
		with loManejador
			.AgregarMapeo('campo0','campo0')
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('nroitem','nroitem')
			.AgregarMapeo('comp','comp')
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('ippart','ippart')
			.AgregarMapeo('artdet','artdet')
			.AgregarMapeo('ipcolor','ipcolor')
			.AgregarMapeo('coldet','coldet')
			.AgregarMapeo('iptalle','iptalle')
			.AgregarMapeo('cant','cant')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ART_KitPartDet'
			.ConsultaOrigen = 'select * from ' + lcCursor
			Select( lcCursor )
			Count to This.nCantVeces
			This.nCantVeces = ceiling( This.nCantVeces / This.nCantABorrar )
			if !this.oEntidad.VerificarContexto( 'CB' )
				use in ( lcCursor )
			endif
			.ImportarMasivamente( toConexion )
			
		endwith
		endif
			
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion( tcTablaTrabajo ) as String
		local lcCadena as String, lcTabla as String, lcEntidad as String, loLogueo as Object, lcDescripcionFW as string
		lcTabla = alltrim( Upper( tcTablaTrabajo ) )
		loLogueo = this.oLogueo.oInfoLog
		lcEntidad = alltrim( Upper( This.oEntidad.ObtenerNombre() ) )
		lcDescripcionFW = "IMPORTACION"
		Local lcCabecera1 as string, lcCabecera2 as string, lcCabecera3 as string, lcCabecera4 as string, lcCabecera5 as string, lcCabecera6 as string, lcCabecera7 as string, lcCabecera8 as string, lcCabecera9 as string
		lcCabecera1 = "replace( newId(),'-','1' )"
		lcCabecera2 = "'" + this.ConvertirDateSql( golibrerias.obtenerfechaformateada( golibrerias.obtenerfecha() ) ) + "'"
		lcCabecera3 = "'" + this.FormatearTextoSql( golibrerias.obtenerhora() ) + "'"
		lcCabecera4 = "'" + this.FormatearTextoSql( alltrim( _screen.zoo.app.cSerie ) ) + "'"
		lcCabecera5 = "'" + this.FormatearTextoSql( goServicios.Seguridad.cUsuarioLogueado ) + "'"
		lcCabecera6 = "'" + this.FormatearTextoSql( this.oEntidad.ObtenerNombre() ) + "'"
		lcCabecera7 = "'" + this.FormatearTextoSql( alltrim('1.00') ) + "'"
		lcCabecera8 = "'" + this.FormatearTextoSql( _Screen.zoo.app.obtenerversion() ) + "'"
		lcCabecera9 = iif( .F., 1, 0 )
		
		Text to lcCadena noshow textmerge
			CREATE TRIGGER ZooLogic.DELETE_<<lcTabla>>
				ON ZooLogic.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				insert into ZooLogic.ADT_ART ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","ARTCOD","Nocom","Artrest" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Artcod,Isnull( d.Nocom,t.Nocom),Isnull( d.Artrest,t.Artrest)
						from ZooLogic.ART t inner join deleted d 
							 on t.ARTCOD = d.ARTCOD
					where ( d.NOCOM is not null and d.NOCOM <> t.NOCOM ) or ( d.ArtRest is not null and d.ArtRest <> t.ArtRest )
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.TIPAGRUPUB = isnull( d.TIPAGRUPUB, t.TIPAGRUPUB ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.IMPORTADO = isnull( d.IMPORTADO, t.IMPORTADO ),t.ARIMAGEN = isnull( d.ARIMAGEN, t.ARIMAGEN ),t.PALCOL = isnull( d.PALCOL, t.PALCOL ),t.ARTCOD = isnull( d.ARTCOD, t.ARTCOD ),t.NOCOM = isnull( d.NOCOM, t.NOCOM ),t.DESECO = isnull( d.DESECO, t.DESECO ),t.ARTPESO = isnull( d.ARTPESO, t.ARTPESO ),t.ESIMPDES = isnull( d.ESIMPDES, t.ESIMPDES ),t.ARTDES = isnull( d.ARTDES, t.ARTDES ),t.CURTALL = isnull( d.CURTALL, t.CURTALL ),t.DESECOHTML = isnull( d.DESECOHTML, t.DESECOHTML ),t.ARTDESADIC = isnull( d.ARTDESADIC, t.ARTDESADIC ),t.ARTFAB = isnull( d.ARTFAB, t.ARTFAB ),t.ARTLARGO = isnull( d.ARTLARGO, t.ARTLARGO ),t.ARTNODEVO = isnull( d.ARTNODEVO, t.ARTNODEVO ),t.ASTOCK = isnull( d.ASTOCK, t.ASTOCK ),t.UNIMED = isnull( d.UNIMED, t.UNIMED ),t.ARTANCHO = isnull( d.ARTANCHO, t.ARTANCHO ),t.ARTSINDES = isnull( d.ARTSINDES, t.ARTSINDES ),t.ATEMPORADA = isnull( d.ATEMPORADA, t.ATEMPORADA ),t.ARTALTO = isnull( d.ARTALTO, t.ARTALTO ),t.ARTREST = isnull( d.ARTREST, t.ARTREST ),t.ANO = isnull( d.ANO, t.ANO ),t.REQCCOSTO = isnull( d.REQCCOSTO, t.REQCCOSTO ),t.MARCA = isnull( d.MARCA, t.MARCA ),t.PUBECOM = isnull( d.PUBECOM, t.PUBECOM ),t.PROMOYKIT = isnull( d.PROMOYKIT, t.PROMOYKIT ),t.FAMILIA = isnull( d.FAMILIA, t.FAMILIA ),t.MAT = isnull( d.MAT, t.MAT ),t.LINEA = isnull( d.LINEA, t.LINEA ),t.GRUPO = isnull( d.GRUPO, t.GRUPO ),t.CATEARTI = isnull( d.CATEARTI, t.CATEARTI ),t.CLASIFART = isnull( d.CLASIFART, t.CLASIFART ),t.TIPOARTI = isnull( d.TIPOARTI, t.TIPOARTI ),t.ARTCONIVA = isnull( d.ARTCONIVA, t.ARTCONIVA ),t.ARTPORIVA = isnull( d.ARTPORIVA, t.ARTPORIVA ),t.ARTIVA = isnull( d.ARTIVA, t.ARTIVA ),t.ANX2 = isnull( d.ANX2, t.ANX2 ),t.IMPINTERNO = isnull( d.IMPINTERNO, t.IMPINTERNO ),t.ARTNARBA = isnull( d.ARTNARBA, t.ARTNARBA ),t.ARTPERCEP = isnull( d.ARTPERCEP, t.ARTPERCEP ),t.AOBS = isnull( d.AOBS, t.AOBS )
					from ZooLogic.ART t inner join deleted d 
							 on t.ARTCOD = d.ARTCOD
				-- Fin Updates
				insert into ZooLogic.ADT_ART ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","ARTCOD","Nocom","Artrest" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Artcod,isnull( d.NOCOM,''),isnull( d.ARTREST,'')
						From deleted d left join ZooLogic.ART pk 
							 on d.ARTCOD = pk.ARTCOD
						Where pk.ARTCOD Is Null 
				insert into ZooLogic.ART(Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Horaexpo,Esttrans,Haltafw,Bdaltafw,Saltafw,Vmodifw,Descfw,Zadsfw,Valtafw,Umodifw,Horaimpo,Hmodifw,Bdmodifw,Ualtafw,Smodifw,Timestamp,Tipagrupub,Bloqreg,Importado,Arimagen,Palcol,Artcod,Nocom,Deseco,Artpeso,Esimpdes,Artdes,Curtall,Desecohtml,Artdesadic,Artfab,Artlargo,Artnodevo,Astock,Unimed,Artancho,Artsindes,Atemporada,Artalto,Artrest,Ano,Reqccosto,Marca,Pubecom,Promoykit,Familia,Mat,Linea,Grupo,Catearti,Clasifart,Tipoarti,Artconiva,Artporiva,Artiva,Anx2,Impinterno,Artnarba,Artpercep,Aobs)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.HORAEXPO,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.SALTAFW,''),isnull( d.VMODIFW,''),isnull( d.DESCFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.TIMESTAMP,0),isnull( d.TIPAGRUPUB,0),isnull( d.BLOQREG,0),isnull( d.IMPORTADO,0),isnull( d.ARIMAGEN,''),isnull( d.PALCOL,''),isnull( d.ARTCOD,''),isnull( d.NOCOM,''),isnull( d.DESECO,''),isnull( d.ARTPESO,0),isnull( d.ESIMPDES,0),isnull( d.ARTDES,''),isnull( d.CURTALL,''),isnull( d.DESECOHTML,''),isnull( d.ARTDESADIC,''),isnull( d.ARTFAB,''),isnull( d.ARTLARGO,0),isnull( d.ARTNODEVO,0),isnull( d.ASTOCK,0),isnull( d.UNIMED,''),isnull( d.ARTANCHO,0),isnull( d.ARTSINDES,0),isnull( d.ATEMPORADA,''),isnull( d.ARTALTO,0),isnull( d.ARTREST,''),isnull( d.ANO,0),isnull( d.REQCCOSTO,0),isnull( d.MARCA,''),isnull( d.PUBECOM,0),isnull( d.PROMOYKIT,0),isnull( d.FAMILIA,''),isnull( d.MAT,''),isnull( d.LINEA,''),isnull( d.GRUPO,''),isnull( d.CATEARTI,''),isnull( d.CLASIFART,''),isnull( d.TIPOARTI,''),isnull( d.ARTCONIVA,0),isnull( d.ARTPORIVA,0),isnull( d.ARTIVA,0),isnull( d.ANX2,0),isnull( d.IMPINTERNO,0),isnull( d.ARTNARBA,''),isnull( d.ARTPERCEP,0),isnull( d.AOBS,'')
						From deleted d left join ZooLogic.ART pk 
							 on d.ARTCOD = pk.ARTCOD
						Where pk.ARTCOD Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgruPubART( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ART_AgruPubART
ON ZooLogic.TablaTrabajo_ART_AgruPubART
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AGRUP = isnull( d.AGRUP, t.AGRUP ),
t.AGRUPDES = isnull( d.AGRUPDES, t.AGRUPDES )
from ZooLogic.AgruPubART t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.AgruPubART
( 
"NROITEM",
"CODIGO",
"AGRUP",
"AGRUPDES"
 )
Select 
d.NROITEM,
d.CODIGO,
d.AGRUP,
d.AGRUPDES
From deleted d left join ZooLogic.AgruPubART pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_KitPartDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ART_KitPartDet
ON ZooLogic.TablaTrabajo_ART_KitPartDet
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.COMP = isnull( d.COMP, t.COMP ),
t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.IPPART = isnull( d.IPPART, t.IPPART ),
t.ARTDET = isnull( d.ARTDET, t.ARTDET ),
t.IPCOLOR = isnull( d.IPCOLOR, t.IPCOLOR ),
t.COLDET = isnull( d.COLDET, t.COLDET ),
t.IPTALLE = isnull( d.IPTALLE, t.IPTALLE ),
t.CANT = isnull( d.CANT, t.CANT )
from ZooLogic.KitPartDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.KitPartDet
( 
"NROITEM",
"COMP",
"BLOQREG",
"CODIGO",
"IPPART",
"ARTDET",
"IPCOLOR",
"COLDET",
"IPTALLE",
"CANT"
 )
Select 
d.NROITEM,
d.COMP,
d.BLOQREG,
d.CODIGO,
d.IPPART,
d.ARTDET,
d.IPCOLOR,
d.COLDET,
d.IPTALLE,
d.CANT
From deleted d left join ZooLogic.KitPartDet pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ART') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ART
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )

		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_AgruPubART') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_AgruPubART
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )

		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_KitPartDet') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_KitPartDet
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ARTICULO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARTICULO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARTICULO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARTICULO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARTICULO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARTICULO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_ARTICULO.Horaexpo, [] )
					.Estadotransferencia = nvl( c_ARTICULO.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_ARTICULO.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_ARTICULO.Basededatosaltafw, [] )
					.Seriealtafw = nvl( c_ARTICULO.Seriealtafw, [] )
					.Versionmodificacionfw = nvl( c_ARTICULO.Versionmodificacionfw, [] )
					.Descripcionfw = nvl( c_ARTICULO.Descripcionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_ARTICULO.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_ARTICULO.Usuariomodificacionfw, [] )
					.Horaimpo = nvl( c_ARTICULO.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_ARTICULO.Horamodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_ARTICULO.Basededatosmodificacionfw, [] )
					.Usuarioaltafw = nvl( c_ARTICULO.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_ARTICULO.Seriemodificacionfw, [] )
					.Timestamp = nvl( c_ARTICULO.Timestamp, 0 )
					.Tipoagrupamientopublicaciones = nvl( c_ARTICULO.Tipoagrupamientopublicaciones, 0 )
					.Bloquearregistro = nvl( c_ARTICULO.Bloquearregistro, .F. )
					.Importado = nvl( c_ARTICULO.Importado, .F. )
					.Imagen = nvl( c_ARTICULO.Imagen, [] )
					.Paletadecolores_PK =  nvl( c_ARTICULO.Paletadecolores, [] )
					.Codigo = nvl( c_ARTICULO.Codigo, [] )
					.Nocomercializable = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARTICULO.Nocomercializable, ctod( '  /  /    ' ) ) )
					lcValor = This.ObtenerMemo( 'c_Descecommerce')
					.Descecommerce = lcValor 
					.Peso = nvl( c_ARTICULO.Peso, 0 )
					.Imprimedespacho = nvl( c_ARTICULO.Imprimedespacho, .F. )
					.Descripcion = nvl( c_ARTICULO.Descripcion, [] )
					.Curvadetalles_PK =  nvl( c_ARTICULO.Curvadetalles, [] )
					lcValor = This.ObtenerMemo( 'c_Descecommercehtml')
					.Descecommercehtml = lcValor 
					if !.lEsSubEntidad
					.Agrupublidetalle.Limpiar()
					.Agrupublidetalle.SetearEsNavegacion( .lProcesando )
					.Agrupublidetalle.Cargar()
					endif
					.Descripcionadicional = nvl( c_ARTICULO.Descripcionadicional, [] )
					.Proveedor_PK =  nvl( c_ARTICULO.Proveedor, [] )
					.Largo = nvl( c_ARTICULO.Largo, 0 )
					.Nopermitedevoluciones = nvl( c_ARTICULO.Nopermitedevoluciones, .F. )
					.Comportamiento = nvl( c_ARTICULO.Comportamiento, 0 )
					.Unidaddemedida_PK =  nvl( c_ARTICULO.Unidaddemedida, [] )
					.Ancho = nvl( c_ARTICULO.Ancho, 0 )
					.Participantesdetalle.Limpiar()
					.Participantesdetalle.SetearEsNavegacion( .lProcesando )
					.Participantesdetalle.Cargar()
					.Restringirdescuentos = nvl( c_ARTICULO.Restringirdescuentos, .F. )
					.Temporada_PK =  nvl( c_ARTICULO.Temporada, [] )
					.Alto = nvl( c_ARTICULO.Alto, 0 )
					.Restringirarticulo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARTICULO.Restringirarticulo, ctod( '  /  /    ' ) ) )
					.Ano = nvl( c_ARTICULO.Ano, 0 )
					.Requiereccosto = nvl( c_ARTICULO.Requiereccosto, 0 )
					.Marca_PK =  nvl( c_ARTICULO.Marca, [] )
					.Nopublicarenecommerce = nvl( c_ARTICULO.Nopublicarenecommerce, .F. )
					.Solopromoykit = nvl( c_ARTICULO.Solopromoykit, .F. )
					.Familia_PK =  nvl( c_ARTICULO.Familia, [] )
					.Material_PK =  nvl( c_ARTICULO.Material, [] )
					.Linea_PK =  nvl( c_ARTICULO.Linea, [] )
					.Grupo_PK =  nvl( c_ARTICULO.Grupo, [] )
					.Categoriadearticulo_PK =  nvl( c_ARTICULO.Categoriadearticulo, [] )
					.Clasificacion_PK =  nvl( c_ARTICULO.Clasificacion, [] )
					.Tipodearticulo_PK =  nvl( c_ARTICULO.Tipodearticulo, [] )
					.Condicionivaventas = nvl( c_ARTICULO.Condicionivaventas, 0 )
					.Porcentajeivaventas = nvl( c_ARTICULO.Porcentajeivaventas, 0 )
					.Condicionivacompras = nvl( c_ARTICULO.Condicionivacompras, 0 )
					.Porcentajeivacompras = nvl( c_ARTICULO.Porcentajeivacompras, 0 )
					.Porcentajeimpuestointerno = nvl( c_ARTICULO.Porcentajeimpuestointerno, 0 )
					.Nomenclador_PK =  nvl( c_ARTICULO.Nomenclador, [] )
					.Percepcionivarg5329 = nvl( c_ARTICULO.Percepcionivarg5329, 0 )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					Select c_ARTICULO
					scatter name This.oEntidad.oAtributosAuditoria
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
	*-----------------------------------------------------------------------------------------
	function ObtenerSentenciasInsertAuditoria( tcCursor as string ) as String
		if empty( tcCursor )
			local lcDescripcionFW as string
			lcDescripcionFW = this.oEntidad.DescripcionFW
		else
			local lcDescripcionFW as string
			lcDescripcionFW = &tcCursor..DescFW
		endif
		Local lcCabecera1 as string, lcCabecera2 as string, lcCabecera3 as string, lcCabecera4 as string, lcCabecera5 as string, lcCabecera6 as string, lcCabecera7 as string, lcCabecera8 as string, lcCabecera9 as string;
		, lcCabecera10 as string
		lcCabecera1 = "'" + this.FormatearTextoSql( goLibrerias.ObtenerGuidPk() ) + "'"
		lcCabecera2 = "'" + this.ConvertirDateSql( golibrerias.obtenerfechaformateada( golibrerias.obtenerfecha() ) ) + "'"
		lcCabecera3 = "'" + this.FormatearTextoSql( golibrerias.obtenerhora() ) + "'"
		lcCabecera4 = "'" + this.FormatearTextoSql( alltrim( _screen.zoo.app.cSerie ) ) + "'"
		lcCabecera5 = "'" + this.FormatearTextoSql( goServicios.Seguridad.cUsuarioLogueado ) + "'"
		lcCabecera6 = "'" + this.FormatearTextoSql( this.oEntidad.ObtenerNombre() ) + "'"
		lcCabecera7 = "'" + this.FormatearTextoSql( lcDescripcionFW ) + "'"
		lcCabecera8 = "'" + this.FormatearTextoSql( alltrim('1.00') ) + "'"
		lcCabecera9 = "'" + this.FormatearTextoSql( _Screen.zoo.app.obtenerversion() ) + "'"
		lcCabecera10 = iif( .F., 1, 0 )
		
		local lxValorClavePrimaria as variant
		if empty( tcCursor )
			lxValorClavePrimaria = this.oEntidad.CODIGO
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad2 = "'" + this.ConvertirDateSql( this.oEntidad.Nocomercializable ) + "'"
			lcEntidad3 = "'" + this.ConvertirDateSql( this.oEntidad.Restringirarticulo ) + "'"
			
		else
			lxValorClavePrimaria = &tcCursor..ARTCOD
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad2 = "'" + this.ConvertirDateSql( &tcCursor..Nocom ) + "'"
			lcEntidad3 = "'" + this.ConvertirDateSql( &tcCursor..Artrest ) + "'"
			
		endif
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_ART ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","ARTCOD","Nocom","Artrest" ) values ( <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, <<lcCabecera10>>, <<lcEntidad1>>, <<lcEntidad2>>, <<lcEntidad3>> ) 
			endtext
		return lcSentencia
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.AgruPubliDetalle
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

		loDetalle = this.oEntidad.ParticipantesDetalle
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
		return c_ARTICULO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.ART' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "ARTCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,ARTCOD as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    ARTCOD from (
							select * 
								from ZooLogic.ART 
								Where   ART.ARTCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ART", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "ARTCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Bloqreg" as "Bloquearregistro", "Importado" as "Importado", "Arimagen" as "Imagen", "Palcol" as "Paletadecolores", "Artcod" as "Codigo", "Nocom" as "Nocomercializable", "Deseco" as "Descecommerce", "Artpeso" as "Peso", "Esimpdes" as "Imprimedespacho", "Artdes" as "Descripcion", "Curtall" as "Curvadetalles", "Desecohtml" as "Descecommercehtml", "Artdesadic" as "Descripcionadicional", "Artfab" as "Proveedor", "Artlargo" as "Largo", "Artnodevo" as "Nopermitedevoluciones", "Astock" as "Comportamiento", "Unimed" as "Unidaddemedida", "Artancho" as "Ancho", "Artsindes" as "Restringirdescuentos", "Atemporada" as "Temporada", "Artalto" as "Alto", "Artrest" as "Restringirarticulo", "Ano" as "Ano", "Reqccosto" as "Requiereccosto", "Marca" as "Marca", "Pubecom" as "Nopublicarenecommerce", "Promoykit" as "Solopromoykit", "Familia" as "Familia", "Mat" as "Material", "Linea" as "Linea", "Grupo" as "Grupo", "Catearti" as "Categoriadearticulo", "Clasifart" as "Clasificacion", "Tipoarti" as "Tipodearticulo", "Artconiva" as "Condicionivaventas", "Artporiva" as "Porcentajeivaventas", "Artiva" as "Condicionivacompras", "Anx2" as "Porcentajeivacompras", "Impinterno" as "Porcentajeimpuestointerno", "Artnarba" as "Nomenclador", "Artpercep" as "Percepcionivarg5329", "Aobs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ART 
								Where   ART.ARTCOD != ''
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
	Tabla = 'ART'
	Filtro = " ART.ARTCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ART.ARTCOD != ''"
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
	<row entidad="ARTICULO                                " atributo="FECHAIMPO                               " tabla="ART            " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="FECHATRANSFERENCIA                      " tabla="ART            " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="FECHAMODIFICACIONFW                     " tabla="ART            " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="FECHAALTAFW                             " tabla="ART            " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="FECHAEXPO                               " tabla="ART            " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="HORAEXPO                                " tabla="ART            " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="ESTADOTRANSFERENCIA                     " tabla="ART            " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="HORAALTAFW                              " tabla="ART            " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="BASEDEDATOSALTAFW                       " tabla="ART            " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="SERIEALTAFW                             " tabla="ART            " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="VERSIONMODIFICACIONFW                   " tabla="ART            " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCIONFW                           " tabla="ART            " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="ZADSFW                                  " tabla="ART            " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="VERSIONALTAFW                           " tabla="ART            " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="USUARIOMODIFICACIONFW                   " tabla="ART            " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="HORAIMPO                                " tabla="ART            " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="HORAMODIFICACIONFW                      " tabla="ART            " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ART            " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="USUARIOALTAFW                           " tabla="ART            " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="SERIEMODIFICACIONFW                     " tabla="ART            " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="TIMESTAMP                               " tabla="ART            " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="TIPOAGRUPAMIENTOPUBLICACIONES           " tabla="ART            " campo="TIPAGRUPUB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="BLOQUEARREGISTRO                        " tabla="ART            " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="IMPORTADO                               " tabla="ART            " campo="IMPORTADO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Importado                                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="IMAGEN                                  " tabla="ART            " campo="ARIMAGEN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="180" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="34" etiqueta="Archivo                                                                                                                                                         " dominio="IMAGENCONRUTADINAMICA         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="PALETADECOLORES                         " tabla="ART            " campo="PALCOL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PALETADECOLORES                         " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Paleta de colores                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="CODIGO                                  " tabla="ART            " campo="ARTCOD    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="NOCOMERCIALIZABLE                       " tabla="ART            " campo="NOCOM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="44" etiqueta="A partir del                                                                                                                                                    " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCECOMMERCE                           " tabla="ART            " campo="DESECO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Descripción ampliada                                                                                                                                            " dominio="OBSERVACION4R                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="PESO                                    " tabla="ART            " campo="ARTPESO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="11" decimales="3" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Peso ( kg.)                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="IMPRIMEDESPACHO                         " tabla="ART            " campo="ESIMPDES  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Imprime despacho                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="CURVADETALLES                           " tabla="ART            " campo="CURTALL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CURVADETALLES                           " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Curva de talles                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCECOMMERCEHTML                       " tabla="ART            " campo="DESECOHTML" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Descripción HTML                                                                                                                                                " dominio="OBSERVACION8R                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="AGRUPUBLIDETALLE                        " tabla="AGRUPUBART     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Agrupamientos                                                                                                                                                   " dominio="DETALLEITEMAGRUPAPUBLICART    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCIONADICIONAL                    " tabla="ART            " campo="ARTDESADIC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción adicional                                                                                                                                           " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="PROVEEDOR                               " tabla="ART            " campo="ARTFAB    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="LARGO                                   " tabla="ART            " campo="ARTLARGO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="11" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Largo ( cm.)                                                                                                                                                    " dominio="DIMENSION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="NOPERMITEDEVOLUCIONES                   " tabla="ART            " campo="ARTNODEVO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Restringir devolución                                                                                                                                           " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="COMPORTAMIENTO                          " tabla="ART            " campo="ASTOCK    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="40" etiqueta="Comportamiento                                                                                                                                                  " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="UNIDADDEMEDIDA                          " tabla="ART            " campo="UNIMED    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="UNIDADDEMEDIDA                          " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Unidad de medida                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="ANCHO                                   " tabla="ART            " campo="ARTANCHO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="11" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Ancho                                                                                                                                                           " dominio="DIMENSION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="PARTICIPANTESDETALLE                    " tabla="KITPARTDET     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Ítems participantes                                                                                                                                             " dominio="DETALLEITEMPARTICIPANTES      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="RESTRINGIRDESCUENTOS                    " tabla="ART            " campo="ARTSINDES " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Restringir descuentos                                                                                                                                           " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="TEMPORADA                               " tabla="ART            " campo="ATEMPORADA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TEMPORADA                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Temporada                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="ALTO                                    " tabla="ART            " campo="ARTALTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="11" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Alto                                                                                                                                                            " dominio="DIMENSION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="RESTRINGIRARTICULO                      " tabla="ART            " campo="ARTREST   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="46" etiqueta="Restringir a partir del                                                                                                                                         " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="ANO                                     " tabla="ART            " campo="ANO       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Año                                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="REQUIERECCOSTO                          " tabla="ART            " campo="REQCCOSTO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Requiere centro de costos                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="MARCA                                   " tabla="ART            " campo="MARCA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MARCA                                   " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="48" etiqueta="Marca                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="NOPUBLICARENECOMMERCE                   " tabla="ART            " campo="PUBECOM   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="No publicar en Tienda Nube                                                                                                                                      " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="SOLOPROMOYKIT                           " tabla="ART            " campo="PROMOYKIT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Solo en promos y/o kits                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="FAMILIA                                 " tabla="ART            " campo="FAMILIA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="FAMILIA                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Familia                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="MATERIAL                                " tabla="ART            " campo="MAT       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MATERIAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="22" etiqueta="Material                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="LINEA                                   " tabla="ART            " campo="LINEA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LINEA                                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="24" etiqueta="Línea                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="GRUPO                                   " tabla="ART            " campo="GRUPO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="GRUPO                                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="26" etiqueta="Grupo                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="CATEGORIADEARTICULO                     " tabla="ART            " campo="CATEARTI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CATEGORIADEARTICULO                     " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="28" etiqueta="Categoría                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="CLASIFICACION                           " tabla="ART            " campo="CLASIFART " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONARTICULO                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="30" etiqueta="Clasificación                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="TIPODEARTICULO                          " tabla="ART            " campo="TIPOARTI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPODEARTICULO                          " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="32" etiqueta="Tipo                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="CONDICIONIVAVENTAS                      " tabla="ART            " campo="ARTCONIVA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Condición de impuestos (ventas)                                                                                                                                 " dominio="COMBOCONDICIONIVA             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="22" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="PORCENTAJEIVAVENTAS                     " tabla="ART            " campo="ARTPORIVA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Porcentaje IVA ventas                                                                                                                                           " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="23" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="CONDICIONIVACOMPRAS                     " tabla="ART            " campo="ARTIVA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Condición de impuestos (compras)                                                                                                                                " dominio="COMBOCONDICIONIVA             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="24" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="PORCENTAJEIVACOMPRAS                    " tabla="ART            " campo="ANX2      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Porcentaje IVA compras                                                                                                                                          " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="PORCENTAJEIMPUESTOINTERNO               " tabla="ART            " campo="IMPINTERNO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Impuesto interno                                                                                                                                                " dominio="IMPUESTOINTERNO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="26" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="NOMENCLADOR                             " tabla="ART            " campo="ARTNARBA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="NOMENCLADORARBA                         " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Código del nomenclador ARBA                                                                                                                                     " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="27" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="PERCEPCIONIVARG5329                     " tabla="ART            " campo="ARTPERCEP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Percepción IVA según RG 5329/23                                                                                                                                 " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="28" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="OBSERVACION                             " tabla="ART            " campo="AOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PALETADECOLORES                         " atributo="DESCRIPCION                             " tabla="PCOLOR         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Pal.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PCOLOR On ART.PALCOL = PCOLOR.Codigo And  PCOLOR.CODIGO != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CURVADETALLES                           " atributo="DESCRIPCION                             " tabla="CTALLE         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="11" etiqueta="Detalle Cur.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CTALLE On ART.CURTALL = CTALLE.Codigo And  CTALLE.CODIGO != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="13" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On ART.ARTFAB = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="UNIDADDEMEDIDA                          " atributo="DESCRIPCION                             " tabla="UNMED          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="15" etiqueta="Detalle Uni.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join UNMED On ART.UNIMED = UNMED.Cod And  UNMED.COD != ''                                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TEMPORADA                               " atributo="DESCRIPCION                             " tabla="TEMPORADA      " campo="TDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="17" etiqueta="Detalle Tem.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TEMPORADA On ART.ATEMPORADA = TEMPORADA.TCOD And  TEMPORADA.TCOD != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MARCA                                   " atributo="DESCRIPCION                             " tabla="MARCAS         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="49" etiqueta="Detalle Mar.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MARCAS On ART.MARCA = MARCAS.Codigo And  MARCAS.CODIGO != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FAMILIA                                 " atributo="DESCRIPCION                             " tabla="FAMILIA        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="21" etiqueta="Detalle Fam.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FAMILIA On ART.FAMILIA = FAMILIA.Cod And  FAMILIA.COD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MATERIAL                                " atributo="DESCRIPCION                             " tabla="MAT            " campo="MATDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="23" etiqueta="Detalle Mat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MAT On ART.MAT = MAT.MATCOD And  MAT.MATCOD != ''                                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINEA                                   " atributo="DESCRIPCION                             " tabla="LINEA          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="25" etiqueta="Detalle Lín.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LINEA On ART.LINEA = LINEA.Cod And  LINEA.COD != ''                                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPO                                   " atributo="DESCRIPCION                             " tabla="GRUPO          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="27" etiqueta="Detalle Gru.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join GRUPO On ART.GRUPO = GRUPO.Cod And  GRUPO.COD != ''                                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIADEARTICULO                     " atributo="DESCRIPCION                             " tabla="CATEGART       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="29" etiqueta="Detalle Cat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CATEGART On ART.CATEARTI = CATEGART.Cod And  CATEGART.COD != ''                                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONARTICULO                   " atributo="DESCRIPCION                             " tabla="CLASIFART      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="31" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIFART On ART.CLASIFART = CLASIFART.CODIGO And  CLASIFART.CODIGO != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODEARTICULO                          " atributo="DESCRIPCION                             " tabla="TIPOART        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="33" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOART On ART.TIPOARTI = TIPOART.Cod And  TIPOART.COD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="DESCRIPCION                             " tabla="NMCARBA        " campo="NMCDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="439" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join NMCARBA On ART.ARTNARBA = NMCARBA.NMCCOD And  NMCARBA.NMCCOD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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