
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
	cTagClavePk = '_001PK'
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
			local  lxArtFaltafw, lxArtAd1, lxArtAd3, lxArtFectrans, lxArtFmodifw, lxArtAd2, lxArtFecimpo, lxArtFecexpo, lxArtTimestamp, lxArtImportado, lxArtBloqreg, lxArtEsttrans, lxArtHoraimpo, lxArtUmodifw, lxArtVmodifw, lxArtValtafw, lxArtUaltafw, lxArtSaltafw, lxArtSmodifw, lxArtHoraexpo, lxArtHmodifw, lxArtBdmodifw, lxArtHaltafw, lxArtDescfw, lxArtBdaltafw, lxArtZadsfw, lxArtArimagen, lxArtArtcod, lxArtArtfab, lxArtAobs, lxArtNocom, lxArtAoferta, lxArtDeseco, lxArtArtdes, lxArtEsimpdes, lxArtArtuni, lxArtArtconiva, lxArtDesecohtml, lxArtArtesunkit, lxArtArtporiva, lxArtArtdesadic, lxArtAmate, lxArtArtcondevo, lxArtUnimed, lxArtAstock, lxArtArtiva, lxArtAesta, lxArtAnx2, lxArtAl3, lxArtAano, lxArtArtrest, lxArtArtsindes, lxArtReqccosto, lxArtMarca, lxArtPromoykit, lxArtArtnarba, lxArtImpinterno, lxArtClasifart, lxArtArtpercep, lxArtArtpeso, lxArtArtlargo, lxArtArtancho, lxArtArtalto
				lxArtFaltafw =  .Fechaaltafw			lxArtAd1 =  .Fechadealta			lxArtAd3 =  .Fechacambiooferta			lxArtFectrans =  .Fechatransferencia			lxArtFmodifw =  .Fechamodificacionfw			lxArtAd2 =  .Fechaultimamodificacion			lxArtFecimpo =  .Fechaimpo			lxArtFecexpo =  .Fechaexpo			lxArtTimestamp = goLibrerias.ObtenerTimestamp()			lxArtImportado =  .Importado			lxArtBloqreg =  .Bloquearregistro			lxArtEsttrans =  .Estadotransferencia			lxArtHoraimpo =  .Horaimpo			lxArtUmodifw =  .Usuariomodificacionfw			lxArtVmodifw =  .Versionmodificacionfw			lxArtValtafw =  .Versionaltafw			lxArtUaltafw =  .Usuarioaltafw			lxArtSaltafw =  .Seriealtafw			lxArtSmodifw =  .Seriemodificacionfw			lxArtHoraexpo =  .Horaexpo			lxArtHmodifw =  .Horamodificacionfw			lxArtBdmodifw =  .Basededatosmodificacionfw			lxArtHaltafw =  .Horaaltafw			lxArtDescfw =  .Descripcionfw			lxArtBdaltafw =  .Basededatosaltafw			lxArtZadsfw =  .Zadsfw			lxArtArimagen =  .Imagen			lxArtArtcod =  .Codigo			lxArtArtfab =  upper( .Proveedor_PK ) 			lxArtAobs =  .Observacion			lxArtNocom =  .Nocomercializable			lxArtAoferta =  .Esoferta			lxArtDeseco =  .Descecommerce			lxArtArtdes =  .Descripcion			lxArtEsimpdes =  .Imprimedespacho			lxArtArtuni =  upper( .Unidad_PK ) 			lxArtArtconiva =  .Condicionivaventas			lxArtDesecohtml =  .Descecommercehtml			lxArtArtesunkit =  .Esunkit			lxArtArtporiva =  .Porcentajeivaventas			lxArtArtdesadic =  .Descripcionadicional			lxArtAmate =  upper( .Material_PK ) 			lxArtArtcondevo =  .Permitedevolucion			lxArtUnimed =  .Unidaddemedida			lxArtAstock =  .Comportamiento			lxArtArtiva =  .Condicionivacompras			lxArtAesta =  .Estacion			lxArtAnx2 =  .Porcentajeivacompras			lxArtAl3 =  .Permitedescuento			lxArtAano =  .Anio			lxArtArtrest =  .Restringirarticulo			lxArtArtsindes =  .Restringirdescuentos			lxArtReqccosto =  .Requiereccosto			lxArtMarca =  upper( .Marca_PK ) 			lxArtPromoykit =  .Solopromoykit			lxArtArtnarba =  upper( .Nomenclador_PK ) 			lxArtImpinterno =  .Porcentajeimpuestointerno			lxArtClasifart =  upper( .Clasificacion_PK ) 			lxArtArtpercep =  .Percepcionivarg5329			lxArtArtpeso =  .Peso			lxArtArtlargo =  .Largo			lxArtArtancho =  .Ancho			lxArtArtalto =  .Alto
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
				insert into ZooLogic.ART ( "Faltafw","Ad1","Ad3","Fectrans","Fmodifw","Ad2","Fecimpo","Fecexpo","Timestamp","Importado","Bloqreg","Esttrans","Horaimpo","Umodifw","Vmodifw","Valtafw","Ualtafw","Saltafw","Smodifw","Horaexpo","Hmodifw","Bdmodifw","Haltafw","Descfw","Bdaltafw","Zadsfw","Arimagen","Artcod","Artfab","Aobs","Nocom","Aoferta","Deseco","Artdes","Esimpdes","Artuni","Artconiva","Desecohtml","Artesunkit","Artporiva","Artdesadic","Amate","Artcondevo","Unimed","Astock","Artiva","Aesta","Anx2","Al3","Aano","Artrest","Artsindes","Reqccosto","Marca","Promoykit","Artnarba","Impinterno","Clasifart","Artpercep","Artpeso","Artlargo","Artancho","Artalto" ) values ( <<"'" + this.ConvertirDateSql( lxArtFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtAd1 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtAd3 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtAd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtFecexpo ) + "'" >>, <<lxArtTimestamp >>, <<iif( lxArtImportado, 1, 0 ) >>, <<iif( lxArtBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxArtEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtArimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtArtcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtArtfab ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtAobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtNocom ) + "'" >>, <<lxArtAoferta >>, <<"'" + this.FormatearTextoSql( lxArtDeseco ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtArtdes ) + "'" >>, <<iif( lxArtEsimpdes, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxArtArtuni ) + "'" >>, <<lxArtArtconiva >>, <<"'" + this.FormatearTextoSql( lxArtDesecohtml ) + "'" >>, <<lxArtArtesunkit >>, <<lxArtArtporiva >>, <<"'" + this.FormatearTextoSql( lxArtArtdesadic ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtAmate ) + "'" >>, <<lxArtArtcondevo >>, <<"'" + this.FormatearTextoSql( lxArtUnimed ) + "'" >>, <<lxArtAstock >>, <<lxArtArtiva >>, <<lxArtAesta >>, <<lxArtAnx2 >>, <<iif( lxArtAl3, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxArtAano ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtArtrest ) + "'" >>, <<iif( lxArtArtsindes, 1, 0 ) >>, <<lxArtReqccosto >>, <<"'" + this.FormatearTextoSql( lxArtMarca ) + "'" >>, <<iif( lxArtPromoykit, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxArtArtnarba ) + "'" >>, <<lxArtImpinterno >>, <<"'" + this.FormatearTextoSql( lxArtClasifart ) + "'" >>, <<lxArtArtpercep >>, <<lxArtArtpeso >>, <<lxArtArtlargo >>, <<lxArtArtancho >>, <<lxArtArtalto >> )
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
			for each loItem in this.oEntidad.ParticipantesDetalle
				if this.oEntidad.ParticipantesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.KitPartDet("NROITEM","COMP","BLOQREG","CODIGO","IPPART","ARTDET","IPCOLOR","COLDET","IPTALLE","CANT" ) values ( <<lxNroitem>>, <<lxComportamiento>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>> ) 
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
			local  lxArtFaltafw, lxArtAd1, lxArtAd3, lxArtFectrans, lxArtFmodifw, lxArtAd2, lxArtFecimpo, lxArtFecexpo, lxArtTimestamp, lxArtImportado, lxArtBloqreg, lxArtEsttrans, lxArtHoraimpo, lxArtUmodifw, lxArtVmodifw, lxArtValtafw, lxArtUaltafw, lxArtSaltafw, lxArtSmodifw, lxArtHoraexpo, lxArtHmodifw, lxArtBdmodifw, lxArtHaltafw, lxArtDescfw, lxArtBdaltafw, lxArtZadsfw, lxArtArimagen, lxArtArtcod, lxArtArtfab, lxArtAobs, lxArtNocom, lxArtAoferta, lxArtDeseco, lxArtArtdes, lxArtEsimpdes, lxArtArtuni, lxArtArtconiva, lxArtDesecohtml, lxArtArtesunkit, lxArtArtporiva, lxArtArtdesadic, lxArtAmate, lxArtArtcondevo, lxArtUnimed, lxArtAstock, lxArtArtiva, lxArtAesta, lxArtAnx2, lxArtAl3, lxArtAano, lxArtArtrest, lxArtArtsindes, lxArtReqccosto, lxArtMarca, lxArtPromoykit, lxArtArtnarba, lxArtImpinterno, lxArtClasifart, lxArtArtpercep, lxArtArtpeso, lxArtArtlargo, lxArtArtancho, lxArtArtalto
				lxArtFaltafw =  .Fechaaltafw			lxArtAd1 =  .Fechadealta			lxArtAd3 =  .Fechacambiooferta			lxArtFectrans =  .Fechatransferencia			lxArtFmodifw =  .Fechamodificacionfw			lxArtAd2 =  .Fechaultimamodificacion			lxArtFecimpo =  .Fechaimpo			lxArtFecexpo =  .Fechaexpo			lxArtTimestamp = goLibrerias.ObtenerTimestamp()			lxArtImportado =  .Importado			lxArtBloqreg =  .Bloquearregistro			lxArtEsttrans =  .Estadotransferencia			lxArtHoraimpo =  .Horaimpo			lxArtUmodifw =  .Usuariomodificacionfw			lxArtVmodifw =  .Versionmodificacionfw			lxArtValtafw =  .Versionaltafw			lxArtUaltafw =  .Usuarioaltafw			lxArtSaltafw =  .Seriealtafw			lxArtSmodifw =  .Seriemodificacionfw			lxArtHoraexpo =  .Horaexpo			lxArtHmodifw =  .Horamodificacionfw			lxArtBdmodifw =  .Basededatosmodificacionfw			lxArtHaltafw =  .Horaaltafw			lxArtDescfw =  .Descripcionfw			lxArtBdaltafw =  .Basededatosaltafw			lxArtZadsfw =  .Zadsfw			lxArtArimagen =  .Imagen			lxArtArtcod =  .Codigo			lxArtArtfab =  upper( .Proveedor_PK ) 			lxArtAobs =  .Observacion			lxArtNocom =  .Nocomercializable			lxArtAoferta =  .Esoferta			lxArtDeseco =  .Descecommerce			lxArtArtdes =  .Descripcion			lxArtEsimpdes =  .Imprimedespacho			lxArtArtuni =  upper( .Unidad_PK ) 			lxArtArtconiva =  .Condicionivaventas			lxArtDesecohtml =  .Descecommercehtml			lxArtArtesunkit =  .Esunkit			lxArtArtporiva =  .Porcentajeivaventas			lxArtArtdesadic =  .Descripcionadicional			lxArtAmate =  upper( .Material_PK ) 			lxArtArtcondevo =  .Permitedevolucion			lxArtUnimed =  .Unidaddemedida			lxArtAstock =  .Comportamiento			lxArtArtiva =  .Condicionivacompras			lxArtAesta =  .Estacion			lxArtAnx2 =  .Porcentajeivacompras			lxArtAl3 =  .Permitedescuento			lxArtAano =  .Anio			lxArtArtrest =  .Restringirarticulo			lxArtArtsindes =  .Restringirdescuentos			lxArtReqccosto =  .Requiereccosto			lxArtMarca =  upper( .Marca_PK ) 			lxArtPromoykit =  .Solopromoykit			lxArtArtnarba =  upper( .Nomenclador_PK ) 			lxArtImpinterno =  .Porcentajeimpuestointerno			lxArtClasifart =  upper( .Clasificacion_PK ) 			lxArtArtpercep =  .Percepcionivarg5329			lxArtArtpeso =  .Peso			lxArtArtlargo =  .Largo			lxArtArtancho =  .Ancho			lxArtArtalto =  .Alto
		endwith
		
		if this.oEntidad.VerificarContexto( 'CB' )
		else
			this.ValidarTimestamp()
		endif
		with this
		Try
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  this.ConvertirDateSql( .oEntidad.oAtributosAuditoria.NoComercializable) != this.ConvertirDateSql( .oEntidad.NoComercializable) )
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ART set "Faltafw" = <<"'" + this.ConvertirDateSql( lxArtFaltafw ) + "'">>,"Ad1" = <<"'" + this.ConvertirDateSql( lxArtAd1 ) + "'">>,"Ad3" = <<"'" + this.ConvertirDateSql( lxArtAd3 ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxArtFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxArtFmodifw ) + "'">>,"Ad2" = <<"'" + this.ConvertirDateSql( lxArtAd2 ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxArtFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxArtFecexpo ) + "'">>,"Timestamp" = <<lxArtTimestamp>>,"Importado" = <<iif( lxArtImportado, 1, 0 )>>,"Bloqreg" = <<iif( lxArtBloqreg, 1, 0 )>>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxArtEsttrans ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxArtHoraimpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxArtUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxArtVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxArtValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxArtUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxArtSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxArtSmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxArtHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxArtHmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxArtBdmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxArtHaltafw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxArtDescfw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxArtBdaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxArtZadsfw ) + "'">>,"Arimagen" = <<"'" + this.FormatearTextoSql( lxArtArimagen ) + "'">>,"Artcod" = <<"'" + this.FormatearTextoSql( lxArtArtcod ) + "'">>,"Artfab" = <<"'" + this.FormatearTextoSql( lxArtArtfab ) + "'">>,"Aobs" = <<"'" + this.FormatearTextoSql( lxArtAobs ) + "'">>,"Nocom" = <<"'" + this.ConvertirDateSql( lxArtNocom ) + "'">>,"Aoferta" = <<lxArtAoferta>>,"Deseco" = <<"'" + this.FormatearTextoSql( lxArtDeseco ) + "'">>,"Artdes" = <<"'" + this.FormatearTextoSql( lxArtArtdes ) + "'">>,"Esimpdes" = <<iif( lxArtEsimpdes, 1, 0 )>>,"Artuni" = <<"'" + this.FormatearTextoSql( lxArtArtuni ) + "'">>,"Artconiva" = <<lxArtArtconiva>>,"Desecohtml" = <<"'" + this.FormatearTextoSql( lxArtDesecohtml ) + "'">>,"Artesunkit" = <<lxArtArtesunkit>>,"Artporiva" = <<lxArtArtporiva>>,"Artdesadic" = <<"'" + this.FormatearTextoSql( lxArtArtdesadic ) + "'">>,"Amate" = <<"'" + this.FormatearTextoSql( lxArtAmate ) + "'">>,"Artcondevo" = <<lxArtArtcondevo>>,"Unimed" = <<"'" + this.FormatearTextoSql( lxArtUnimed ) + "'">>,"Astock" = <<lxArtAstock>>,"Artiva" = <<lxArtArtiva>>,"Aesta" = <<lxArtAesta>>,"Anx2" = <<lxArtAnx2>>,"Al3" = <<iif( lxArtAl3, 1, 0 )>>,"Aano" = <<"'" + this.FormatearTextoSql( lxArtAano ) + "'">>,"Artrest" = <<"'" + this.ConvertirDateSql( lxArtArtrest ) + "'">>,"Artsindes" = <<iif( lxArtArtsindes, 1, 0 )>>,"Reqccosto" = <<lxArtReqccosto>>,"Marca" = <<"'" + this.FormatearTextoSql( lxArtMarca ) + "'">>,"Promoykit" = <<iif( lxArtPromoykit, 1, 0 )>>,"Artnarba" = <<"'" + this.FormatearTextoSql( lxArtArtnarba ) + "'">>,"Impinterno" = <<lxArtImpinterno>>,"Clasifart" = <<"'" + this.FormatearTextoSql( lxArtClasifart ) + "'">>,"Artpercep" = <<lxArtArtpercep>>,"Artpeso" = <<lxArtArtpeso>>,"Artlargo" = <<lxArtArtlargo>>,"Artancho" = <<lxArtArtancho>>,"Artalto" = <<lxArtArtalto>> where "Artcod" = <<"'" + this.FormatearTextoSql( lxArtArtcod ) + "'">> and  ART.ARTCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			If llInsertarAuditoria
				lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			EndIf
			this.oConexion.EjecutarSql( 'delete from ZooLogic.KitPartDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

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
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.KitPartDet("NROITEM","COMP","BLOQREG","CODIGO","IPPART","ARTDET","IPCOLOR","COLDET","IPTALLE","CANT" ) values ( <<lxNroitem>>, <<lxComportamiento>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>> ) 
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
				select "Faltafw" as "Fechaaltafw", "Ad1" as "Fechadealta", "Ad3" as "Fechacambiooferta", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Ad2" as "Fechaultimamodificacion", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Importado" as "Importado", "Bloqreg" as "Bloquearregistro", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Arimagen" as "Imagen", "Artcod" as "Codigo", "Artfab" as "Proveedor", "Aobs" as "Observacion", "Nocom" as "Nocomercializable", "Aoferta" as "Esoferta", "Deseco" as "Descecommerce", "Artdes" as "Descripcion", "Esimpdes" as "Imprimedespacho", "Artuni" as "Unidad", "Artconiva" as "Condicionivaventas", "Desecohtml" as "Descecommercehtml", "Artesunkit" as "Esunkit", "Artporiva" as "Porcentajeivaventas", "Artdesadic" as "Descripcionadicional", "Amate" as "Material", "Artcondevo" as "Permitedevolucion", "Unimed" as "Unidaddemedida", "Astock" as "Comportamiento", "Artiva" as "Condicionivacompras", "Aesta" as "Estacion", "Anx2" as "Porcentajeivacompras", "Al3" as "Permitedescuento", "Aano" as "Anio", "Artrest" as "Restringirarticulo", "Artsindes" as "Restringirdescuentos", "Reqccosto" as "Requiereccosto", "Marca" as "Marca", "Promoykit" as "Solopromoykit", "Artnarba" as "Nomenclador", "Impinterno" as "Porcentajeimpuestointerno", "Clasifart" as "Clasificacion", "Artpercep" as "Percepcionivarg5329", "Artpeso" as "Peso", "Artlargo" as "Largo", "Artancho" as "Ancho", "Artalto" as "Alto" from ZooLogic.ART where "Artcod" = <<"'" + this.FormatearTextoSql( lxArtArtcod ) + "'">> and  ART.ARTCOD != ''
			endtext
			use in select('c_ARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ARTICULO', set( 'Datasession' ) )

			if reccount( 'c_ARTICULO' ) = 0
				llRetorno = .f.
			else
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
				select top 1 "Faltafw" as "Fechaaltafw", "Ad1" as "Fechadealta", "Ad3" as "Fechacambiooferta", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Ad2" as "Fechaultimamodificacion", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Importado" as "Importado", "Bloqreg" as "Bloquearregistro", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Arimagen" as "Imagen", "Artcod" as "Codigo", "Artfab" as "Proveedor", "Aobs" as "Observacion", "Nocom" as "Nocomercializable", "Aoferta" as "Esoferta", "Deseco" as "Descecommerce", "Artdes" as "Descripcion", "Esimpdes" as "Imprimedespacho", "Artuni" as "Unidad", "Artconiva" as "Condicionivaventas", "Desecohtml" as "Descecommercehtml", "Artesunkit" as "Esunkit", "Artporiva" as "Porcentajeivaventas", "Artdesadic" as "Descripcionadicional", "Amate" as "Material", "Artcondevo" as "Permitedevolucion", "Unimed" as "Unidaddemedida", "Astock" as "Comportamiento", "Artiva" as "Condicionivacompras", "Aesta" as "Estacion", "Anx2" as "Porcentajeivacompras", "Al3" as "Permitedescuento", "Aano" as "Anio", "Artrest" as "Restringirarticulo", "Artsindes" as "Restringirdescuentos", "Reqccosto" as "Requiereccosto", "Marca" as "Marca", "Promoykit" as "Solopromoykit", "Artnarba" as "Nomenclador", "Impinterno" as "Porcentajeimpuestointerno", "Clasifart" as "Clasificacion", "Artpercep" as "Percepcionivarg5329", "Artpeso" as "Peso", "Artlargo" as "Largo", "Artancho" as "Ancho", "Artalto" as "Alto" from ZooLogic.ART where  ART.ARTCOD != '' order by ARTCOD
			endtext
			use in select('c_ARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ARTICULO', set( 'Datasession' ) )
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
				select top 1 "Faltafw" as "Fechaaltafw", "Ad1" as "Fechadealta", "Ad3" as "Fechacambiooferta", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Ad2" as "Fechaultimamodificacion", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Importado" as "Importado", "Bloqreg" as "Bloquearregistro", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Arimagen" as "Imagen", "Artcod" as "Codigo", "Artfab" as "Proveedor", "Aobs" as "Observacion", "Nocom" as "Nocomercializable", "Aoferta" as "Esoferta", "Deseco" as "Descecommerce", "Artdes" as "Descripcion", "Esimpdes" as "Imprimedespacho", "Artuni" as "Unidad", "Artconiva" as "Condicionivaventas", "Desecohtml" as "Descecommercehtml", "Artesunkit" as "Esunkit", "Artporiva" as "Porcentajeivaventas", "Artdesadic" as "Descripcionadicional", "Amate" as "Material", "Artcondevo" as "Permitedevolucion", "Unimed" as "Unidaddemedida", "Astock" as "Comportamiento", "Artiva" as "Condicionivacompras", "Aesta" as "Estacion", "Anx2" as "Porcentajeivacompras", "Al3" as "Permitedescuento", "Aano" as "Anio", "Artrest" as "Restringirarticulo", "Artsindes" as "Restringirdescuentos", "Reqccosto" as "Requiereccosto", "Marca" as "Marca", "Promoykit" as "Solopromoykit", "Artnarba" as "Nomenclador", "Impinterno" as "Porcentajeimpuestointerno", "Clasifart" as "Clasificacion", "Artpercep" as "Percepcionivarg5329", "Artpeso" as "Peso", "Artlargo" as "Largo", "Artancho" as "Ancho", "Artalto" as "Alto" from ZooLogic.ART where  funciones.padr( ARTCOD, 13, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ART.ARTCOD != '' order by ARTCOD
			endtext
			use in select('c_ARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ARTICULO', set( 'Datasession' ) )
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
				select top 1 "Faltafw" as "Fechaaltafw", "Ad1" as "Fechadealta", "Ad3" as "Fechacambiooferta", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Ad2" as "Fechaultimamodificacion", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Importado" as "Importado", "Bloqreg" as "Bloquearregistro", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Arimagen" as "Imagen", "Artcod" as "Codigo", "Artfab" as "Proveedor", "Aobs" as "Observacion", "Nocom" as "Nocomercializable", "Aoferta" as "Esoferta", "Deseco" as "Descecommerce", "Artdes" as "Descripcion", "Esimpdes" as "Imprimedespacho", "Artuni" as "Unidad", "Artconiva" as "Condicionivaventas", "Desecohtml" as "Descecommercehtml", "Artesunkit" as "Esunkit", "Artporiva" as "Porcentajeivaventas", "Artdesadic" as "Descripcionadicional", "Amate" as "Material", "Artcondevo" as "Permitedevolucion", "Unimed" as "Unidaddemedida", "Astock" as "Comportamiento", "Artiva" as "Condicionivacompras", "Aesta" as "Estacion", "Anx2" as "Porcentajeivacompras", "Al3" as "Permitedescuento", "Aano" as "Anio", "Artrest" as "Restringirarticulo", "Artsindes" as "Restringirdescuentos", "Reqccosto" as "Requiereccosto", "Marca" as "Marca", "Promoykit" as "Solopromoykit", "Artnarba" as "Nomenclador", "Impinterno" as "Porcentajeimpuestointerno", "Clasifart" as "Clasificacion", "Artpercep" as "Percepcionivarg5329", "Artpeso" as "Peso", "Artlargo" as "Largo", "Artancho" as "Ancho", "Artalto" as "Alto" from ZooLogic.ART where  funciones.padr( ARTCOD, 13, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ART.ARTCOD != '' order by ARTCOD desc
			endtext
			use in select('c_ARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ARTICULO', set( 'Datasession' ) )
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
				select top 1 "Faltafw" as "Fechaaltafw", "Ad1" as "Fechadealta", "Ad3" as "Fechacambiooferta", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Ad2" as "Fechaultimamodificacion", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Importado" as "Importado", "Bloqreg" as "Bloquearregistro", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Arimagen" as "Imagen", "Artcod" as "Codigo", "Artfab" as "Proveedor", "Aobs" as "Observacion", "Nocom" as "Nocomercializable", "Aoferta" as "Esoferta", "Deseco" as "Descecommerce", "Artdes" as "Descripcion", "Esimpdes" as "Imprimedespacho", "Artuni" as "Unidad", "Artconiva" as "Condicionivaventas", "Desecohtml" as "Descecommercehtml", "Artesunkit" as "Esunkit", "Artporiva" as "Porcentajeivaventas", "Artdesadic" as "Descripcionadicional", "Amate" as "Material", "Artcondevo" as "Permitedevolucion", "Unimed" as "Unidaddemedida", "Astock" as "Comportamiento", "Artiva" as "Condicionivacompras", "Aesta" as "Estacion", "Anx2" as "Porcentajeivacompras", "Al3" as "Permitedescuento", "Aano" as "Anio", "Artrest" as "Restringirarticulo", "Artsindes" as "Restringirdescuentos", "Reqccosto" as "Requiereccosto", "Marca" as "Marca", "Promoykit" as "Solopromoykit", "Artnarba" as "Nomenclador", "Impinterno" as "Porcentajeimpuestointerno", "Clasifart" as "Clasificacion", "Artpercep" as "Percepcionivarg5329", "Artpeso" as "Peso", "Artlargo" as "Largo", "Artancho" as "Ancho", "Artalto" as "Alto" from ZooLogic.ART where  ART.ARTCOD != '' order by ARTCOD desc
			endtext
			use in select('c_ARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ARTICULO', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Faltafw,Ad1,Ad3,Fectrans,Fmodifw,Ad2,Fecimpo,Fecexpo,Timestamp,Importado,Bloqreg,Esttrans,Ho" + ;
"raimpo,Umodifw,Vmodifw,Valtafw,Ualtafw,Saltafw,Smodifw,Horaexpo,Hmodifw,Bdmodifw,Haltafw,Descfw,Bdal" + ;
"tafw,Zadsfw,Arimagen,Artcod,Artfab,Aobs,Nocom,Aoferta,Deseco,Artdes,Esimpdes,Artuni,Artconiva,Deseco" + ;
"html,Artesunkit,Artporiva,Artdesadic,Amate,Artcondevo,Unimed,Astock,Artiva,Aesta,Anx2,Al3,Aano,Artre" + ;
"st,Artsindes,Reqccosto,Marca,Promoykit,Artnarba,Impinterno,Clasifart,Artpercep,Artpeso,Artlargo,Arta" + ;
"ncho,Artalto" + ;
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
			local  lxArtFaltafw, lxArtAd1, lxArtAd3, lxArtFectrans, lxArtFmodifw, lxArtAd2, lxArtFecimpo, lxArtFecexpo, lxArtTimestamp, lxArtImportado, lxArtBloqreg, lxArtEsttrans, lxArtHoraimpo, lxArtUmodifw, lxArtVmodifw, lxArtValtafw, lxArtUaltafw, lxArtSaltafw, lxArtSmodifw, lxArtHoraexpo, lxArtHmodifw, lxArtBdmodifw, lxArtHaltafw, lxArtDescfw, lxArtBdaltafw, lxArtZadsfw, lxArtArimagen, lxArtArtcod, lxArtArtfab, lxArtAobs, lxArtNocom, lxArtAoferta, lxArtDeseco, lxArtArtdes, lxArtEsimpdes, lxArtArtuni, lxArtArtconiva, lxArtDesecohtml, lxArtArtesunkit, lxArtArtporiva, lxArtArtdesadic, lxArtAmate, lxArtArtcondevo, lxArtUnimed, lxArtAstock, lxArtArtiva, lxArtAesta, lxArtAnx2, lxArtAl3, lxArtAano, lxArtArtrest, lxArtArtsindes, lxArtReqccosto, lxArtMarca, lxArtPromoykit, lxArtArtnarba, lxArtImpinterno, lxArtClasifart, lxArtArtpercep, lxArtArtpeso, lxArtArtlargo, lxArtArtancho, lxArtArtalto
				lxArtFaltafw = ctod( '  /  /    ' )			lxArtAd1 = ctod( '  /  /    ' )			lxArtAd3 = ctod( '  /  /    ' )			lxArtFectrans = ctod( '  /  /    ' )			lxArtFmodifw = ctod( '  /  /    ' )			lxArtAd2 = ctod( '  /  /    ' )			lxArtFecimpo = ctod( '  /  /    ' )			lxArtFecexpo = ctod( '  /  /    ' )			lxArtTimestamp = goLibrerias.ObtenerTimestamp()			lxArtImportado = .F.			lxArtBloqreg = .F.			lxArtEsttrans = []			lxArtHoraimpo = []			lxArtUmodifw = []			lxArtVmodifw = []			lxArtValtafw = []			lxArtUaltafw = []			lxArtSaltafw = []			lxArtSmodifw = []			lxArtHoraexpo = []			lxArtHmodifw = []			lxArtBdmodifw = []			lxArtHaltafw = []			lxArtDescfw = []			lxArtBdaltafw = []			lxArtZadsfw = []			lxArtArimagen = []			lxArtArtcod = []			lxArtArtfab = []			lxArtAobs = []			lxArtNocom = ctod( '  /  /    ' )			lxArtAoferta = 0			lxArtDeseco = []			lxArtArtdes = []			lxArtEsimpdes = .F.			lxArtArtuni = []			lxArtArtconiva = 0			lxArtDesecohtml = []			lxArtArtesunkit = 0			lxArtArtporiva = 0			lxArtArtdesadic = []			lxArtAmate = []			lxArtArtcondevo = 0			lxArtUnimed = []			lxArtAstock = 0			lxArtArtiva = 0			lxArtAesta = 0			lxArtAnx2 = 0			lxArtAl3 = .F.			lxArtAano = []			lxArtArtrest = ctod( '  /  /    ' )			lxArtArtsindes = .F.			lxArtReqccosto = 0			lxArtMarca = []			lxArtPromoykit = .F.			lxArtArtnarba = []			lxArtImpinterno = 0			lxArtClasifart = []			lxArtArtpercep = 0			lxArtArtpeso = 0			lxArtArtlargo = 0			lxArtArtancho = 0			lxArtArtalto = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
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
					"Faltafw" as "Fechaaltafw", "Ad1" as "Fechadealta", "Ad3" as "Fechacambiooferta", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Ad2" as "Fechaultimamodificacion", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Importado" as "Importado", "Bloqreg" as "Bloquearregistro", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Arimagen" as "Imagen", "Artcod" as "Codigo", "Artfab" as "Proveedor", "Aobs" as "Observacion", "Nocom" as "Nocomercializable", "Aoferta" as "Esoferta", "Deseco" as "Descecommerce", "Artdes" as "Descripcion", "Esimpdes" as "Imprimedespacho", "Artuni" as "Unidad", "Artconiva" as "Condicionivaventas", "Desecohtml" as "Descecommercehtml", "Artesunkit" as "Esunkit", "Artporiva" as "Porcentajeivaventas", "Artdesadic" as "Descripcionadicional", "Amate" as "Material", "Artcondevo" as "Permitedevolucion", "Unimed" as "Unidaddemedida", "Astock" as "Comportamiento", "Artiva" as "Condicionivacompras", "Aesta" as "Estacion", "Anx2" as "Porcentajeivacompras", "Al3" as "Permitedescuento", "Aano" as "Anio", "Artrest" as "Restringirarticulo", "Artsindes" as "Restringirdescuentos", "Reqccosto" as "Requiereccosto", "Marca" as "Marca", "Promoykit" as "Solopromoykit", "Artnarba" as "Nomenclador", "Impinterno" as "Porcentajeimpuestointerno", "Clasifart" as "Clasificacion", "Artpercep" as "Percepcionivarg5329", "Artpeso" as "Peso", "Artlargo" as "Largo", "Artancho" as "Ancho", "Artalto" as "Alto"
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHADEALTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AD1 AS FECHADEALTA'
				Case lcAtributo == 'FECHACAMBIOOFERTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AD3 AS FECHACAMBIOOFERTA'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAULTIMAMODIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AD2 AS FECHAULTIMAMODIFICACION'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'IMPORTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPORTADO AS IMPORTADO'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'IMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARIMAGEN AS IMAGEN'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTCOD AS CODIGO'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTFAB AS PROVEEDOR'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AOBS AS OBSERVACION'
				Case lcAtributo == 'NOCOMERCIALIZABLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOCOM AS NOCOMERCIALIZABLE'
				Case lcAtributo == 'ESOFERTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AOFERTA AS ESOFERTA'
				Case lcAtributo == 'DESCECOMMERCE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESECO AS DESCECOMMERCE'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTDES AS DESCRIPCION'
				Case lcAtributo == 'IMPRIMEDESPACHO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESIMPDES AS IMPRIMEDESPACHO'
				Case lcAtributo == 'UNIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTUNI AS UNIDAD'
				Case lcAtributo == 'CONDICIONIVAVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTCONIVA AS CONDICIONIVAVENTAS'
				Case lcAtributo == 'DESCECOMMERCEHTML'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESECOHTML AS DESCECOMMERCEHTML'
				Case lcAtributo == 'ESUNKIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTESUNKIT AS ESUNKIT'
				Case lcAtributo == 'PORCENTAJEIVAVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTPORIVA AS PORCENTAJEIVAVENTAS'
				Case lcAtributo == 'DESCRIPCIONADICIONAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTDESADIC AS DESCRIPCIONADICIONAL'
				Case lcAtributo == 'MATERIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AMATE AS MATERIAL'
				Case lcAtributo == 'PERMITEDEVOLUCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTCONDEVO AS PERMITEDEVOLUCION'
				Case lcAtributo == 'UNIDADDEMEDIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIMED AS UNIDADDEMEDIDA'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ASTOCK AS COMPORTAMIENTO'
				Case lcAtributo == 'CONDICIONIVACOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTIVA AS CONDICIONIVACOMPRAS'
				Case lcAtributo == 'ESTACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AESTA AS ESTACION'
				Case lcAtributo == 'PORCENTAJEIVACOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANX2 AS PORCENTAJEIVACOMPRAS'
				Case lcAtributo == 'PERMITEDESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AL3 AS PERMITEDESCUENTO'
				Case lcAtributo == 'ANIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AANO AS ANIO'
				Case lcAtributo == 'RESTRINGIRARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTREST AS RESTRINGIRARTICULO'
				Case lcAtributo == 'RESTRINGIRDESCUENTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTSINDES AS RESTRINGIRDESCUENTOS'
				Case lcAtributo == 'REQUIERECCOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REQCCOSTO AS REQUIERECCOSTO'
				Case lcAtributo == 'MARCA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MARCA AS MARCA'
				Case lcAtributo == 'SOLOPROMOYKIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROMOYKIT AS SOLOPROMOYKIT'
				Case lcAtributo == 'NOMENCLADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTNARBA AS NOMENCLADOR'
				Case lcAtributo == 'PORCENTAJEIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPINTERNO AS PORCENTAJEIMPUESTOINTERNO'
				Case lcAtributo == 'CLASIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLASIFART AS CLASIFICACION'
				Case lcAtributo == 'PERCEPCIONIVARG5329'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTPERCEP AS PERCEPCIONIVARG5329'
				Case lcAtributo == 'PESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTPESO AS PESO'
				Case lcAtributo == 'LARGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTLARGO AS LARGO'
				Case lcAtributo == 'ANCHO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTANCHO AS ANCHO'
				Case lcAtributo == 'ALTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTALTO AS ALTO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADEALTA'
				lcCampo = 'AD1'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACAMBIOOFERTA'
				lcCampo = 'AD3'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAULTIMAMODIFICACION'
				lcCampo = 'AD2'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'IMPORTADO'
				lcCampo = 'IMPORTADO'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'IMAGEN'
				lcCampo = 'ARIMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'ARTCOD'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'ARTFAB'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'AOBS'
			Case upper( alltrim( tcAtributo ) ) == 'NOCOMERCIALIZABLE'
				lcCampo = 'NOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'ESOFERTA'
				lcCampo = 'AOFERTA'
			Case upper( alltrim( tcAtributo ) ) == 'DESCECOMMERCE'
				lcCampo = 'DESECO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'ARTDES'
			Case upper( alltrim( tcAtributo ) ) == 'IMPRIMEDESPACHO'
				lcCampo = 'ESIMPDES'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDAD'
				lcCampo = 'ARTUNI'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVAVENTAS'
				lcCampo = 'ARTCONIVA'
			Case upper( alltrim( tcAtributo ) ) == 'DESCECOMMERCEHTML'
				lcCampo = 'DESECOHTML'
			Case upper( alltrim( tcAtributo ) ) == 'ESUNKIT'
				lcCampo = 'ARTESUNKIT'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIVAVENTAS'
				lcCampo = 'ARTPORIVA'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONADICIONAL'
				lcCampo = 'ARTDESADIC'
			Case upper( alltrim( tcAtributo ) ) == 'MATERIAL'
				lcCampo = 'AMATE'
			Case upper( alltrim( tcAtributo ) ) == 'PERMITEDEVOLUCION'
				lcCampo = 'ARTCONDEVO'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDADDEMEDIDA'
				lcCampo = 'UNIMED'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'ASTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVACOMPRAS'
				lcCampo = 'ARTIVA'
			Case upper( alltrim( tcAtributo ) ) == 'ESTACION'
				lcCampo = 'AESTA'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIVACOMPRAS'
				lcCampo = 'ANX2'
			Case upper( alltrim( tcAtributo ) ) == 'PERMITEDESCUENTO'
				lcCampo = 'AL3'
			Case upper( alltrim( tcAtributo ) ) == 'ANIO'
				lcCampo = 'AANO'
			Case upper( alltrim( tcAtributo ) ) == 'RESTRINGIRARTICULO'
				lcCampo = 'ARTREST'
			Case upper( alltrim( tcAtributo ) ) == 'RESTRINGIRDESCUENTOS'
				lcCampo = 'ARTSINDES'
			Case upper( alltrim( tcAtributo ) ) == 'REQUIERECCOSTO'
				lcCampo = 'REQCCOSTO'
			Case upper( alltrim( tcAtributo ) ) == 'MARCA'
				lcCampo = 'MARCA'
			Case upper( alltrim( tcAtributo ) ) == 'SOLOPROMOYKIT'
				lcCampo = 'PROMOYKIT'
			Case upper( alltrim( tcAtributo ) ) == 'NOMENCLADOR'
				lcCampo = 'ARTNARBA'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIMPUESTOINTERNO'
				lcCampo = 'IMPINTERNO'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACION'
				lcCampo = 'CLASIFART'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONIVARG5329'
				lcCampo = 'ARTPERCEP'
			Case upper( alltrim( tcAtributo ) ) == 'PESO'
				lcCampo = 'ARTPESO'
			Case upper( alltrim( tcAtributo ) ) == 'LARGO'
				lcCampo = 'ARTLARGO'
			Case upper( alltrim( tcAtributo ) ) == 'ANCHO'
				lcCampo = 'ARTANCHO'
			Case upper( alltrim( tcAtributo ) ) == 'ALTO'
				lcCampo = 'ARTALTO'
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
			local  lxArtFaltafw, lxArtAd1, lxArtAd3, lxArtFectrans, lxArtFmodifw, lxArtAd2, lxArtFecimpo, lxArtFecexpo, lxArtTimestamp, lxArtImportado, lxArtBloqreg, lxArtEsttrans, lxArtHoraimpo, lxArtUmodifw, lxArtVmodifw, lxArtValtafw, lxArtUaltafw, lxArtSaltafw, lxArtSmodifw, lxArtHoraexpo, lxArtHmodifw, lxArtBdmodifw, lxArtHaltafw, lxArtDescfw, lxArtBdaltafw, lxArtZadsfw, lxArtArimagen, lxArtArtcod, lxArtArtfab, lxArtAobs, lxArtNocom, lxArtAoferta, lxArtDeseco, lxArtArtdes, lxArtEsimpdes, lxArtArtuni, lxArtArtconiva, lxArtDesecohtml, lxArtArtesunkit, lxArtArtporiva, lxArtArtdesadic, lxArtAmate, lxArtArtcondevo, lxArtUnimed, lxArtAstock, lxArtArtiva, lxArtAesta, lxArtAnx2, lxArtAl3, lxArtAano, lxArtArtrest, lxArtArtsindes, lxArtReqccosto, lxArtMarca, lxArtPromoykit, lxArtArtnarba, lxArtImpinterno, lxArtClasifart, lxArtArtpercep, lxArtArtpeso, lxArtArtlargo, lxArtArtancho, lxArtArtalto
				lxArtFaltafw =  .Fechaaltafw			lxArtAd1 =  .Fechadealta			lxArtAd3 =  .Fechacambiooferta			lxArtFectrans =  .Fechatransferencia			lxArtFmodifw =  .Fechamodificacionfw			lxArtAd2 =  .Fechaultimamodificacion			lxArtFecimpo =  .Fechaimpo			lxArtFecexpo =  .Fechaexpo			lxArtTimestamp = goLibrerias.ObtenerTimestamp()			lxArtImportado =  .Importado			lxArtBloqreg =  .Bloquearregistro			lxArtEsttrans =  .Estadotransferencia			lxArtHoraimpo =  .Horaimpo			lxArtUmodifw =  .Usuariomodificacionfw			lxArtVmodifw =  .Versionmodificacionfw			lxArtValtafw =  .Versionaltafw			lxArtUaltafw =  .Usuarioaltafw			lxArtSaltafw =  .Seriealtafw			lxArtSmodifw =  .Seriemodificacionfw			lxArtHoraexpo =  .Horaexpo			lxArtHmodifw =  .Horamodificacionfw			lxArtBdmodifw =  .Basededatosmodificacionfw			lxArtHaltafw =  .Horaaltafw			lxArtDescfw =  .Descripcionfw			lxArtBdaltafw =  .Basededatosaltafw			lxArtZadsfw =  .Zadsfw			lxArtArimagen =  .Imagen			lxArtArtcod =  .Codigo			lxArtArtfab =  upper( .Proveedor_PK ) 			lxArtAobs =  .Observacion			lxArtNocom =  .Nocomercializable			lxArtAoferta =  .Esoferta			lxArtDeseco =  .Descecommerce			lxArtArtdes =  .Descripcion			lxArtEsimpdes =  .Imprimedespacho			lxArtArtuni =  upper( .Unidad_PK ) 			lxArtArtconiva =  .Condicionivaventas			lxArtDesecohtml =  .Descecommercehtml			lxArtArtesunkit =  .Esunkit			lxArtArtporiva =  .Porcentajeivaventas			lxArtArtdesadic =  .Descripcionadicional			lxArtAmate =  upper( .Material_PK ) 			lxArtArtcondevo =  .Permitedevolucion			lxArtUnimed =  .Unidaddemedida			lxArtAstock =  .Comportamiento			lxArtArtiva =  .Condicionivacompras			lxArtAesta =  .Estacion			lxArtAnx2 =  .Porcentajeivacompras			lxArtAl3 =  .Permitedescuento			lxArtAano =  .Anio			lxArtArtrest =  .Restringirarticulo			lxArtArtsindes =  .Restringirdescuentos			lxArtReqccosto =  .Requiereccosto			lxArtMarca =  upper( .Marca_PK ) 			lxArtPromoykit =  .Solopromoykit			lxArtArtnarba =  upper( .Nomenclador_PK ) 			lxArtImpinterno =  .Porcentajeimpuestointerno			lxArtClasifart =  upper( .Clasificacion_PK ) 			lxArtArtpercep =  .Percepcionivarg5329			lxArtArtpeso =  .Peso			lxArtArtlargo =  .Largo			lxArtArtancho =  .Ancho			lxArtArtalto =  .Alto
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ART ( "Faltafw","Ad1","Ad3","Fectrans","Fmodifw","Ad2","Fecimpo","Fecexpo","Timestamp","Importado","Bloqreg","Esttrans","Horaimpo","Umodifw","Vmodifw","Valtafw","Ualtafw","Saltafw","Smodifw","Horaexpo","Hmodifw","Bdmodifw","Haltafw","Descfw","Bdaltafw","Zadsfw","Arimagen","Artcod","Artfab","Aobs","Nocom","Aoferta","Deseco","Artdes","Esimpdes","Artuni","Artconiva","Desecohtml","Artesunkit","Artporiva","Artdesadic","Amate","Artcondevo","Unimed","Astock","Artiva","Aesta","Anx2","Al3","Aano","Artrest","Artsindes","Reqccosto","Marca","Promoykit","Artnarba","Impinterno","Clasifart","Artpercep","Artpeso","Artlargo","Artancho","Artalto" ) values ( <<"'" + this.ConvertirDateSql( lxArtFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtAd1 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtAd3 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtAd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtFecexpo ) + "'" >>, <<lxArtTimestamp >>, <<iif( lxArtImportado, 1, 0 ) >>, <<iif( lxArtBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxArtEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtArimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtArtcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtArtfab ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtAobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtNocom ) + "'" >>, <<lxArtAoferta >>, <<"'" + this.FormatearTextoSql( lxArtDeseco ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtArtdes ) + "'" >>, <<iif( lxArtEsimpdes, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxArtArtuni ) + "'" >>, <<lxArtArtconiva >>, <<"'" + this.FormatearTextoSql( lxArtDesecohtml ) + "'" >>, <<lxArtArtesunkit >>, <<lxArtArtporiva >>, <<"'" + this.FormatearTextoSql( lxArtArtdesadic ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArtAmate ) + "'" >>, <<lxArtArtcondevo >>, <<"'" + this.FormatearTextoSql( lxArtUnimed ) + "'" >>, <<lxArtAstock >>, <<lxArtArtiva >>, <<lxArtAesta >>, <<lxArtAnx2 >>, <<iif( lxArtAl3, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxArtAano ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArtArtrest ) + "'" >>, <<iif( lxArtArtsindes, 1, 0 ) >>, <<lxArtReqccosto >>, <<"'" + this.FormatearTextoSql( lxArtMarca ) + "'" >>, <<iif( lxArtPromoykit, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxArtArtnarba ) + "'" >>, <<lxArtImpinterno >>, <<"'" + this.FormatearTextoSql( lxArtClasifart ) + "'" >>, <<lxArtArtpercep >>, <<lxArtArtpeso >>, <<lxArtArtlargo >>, <<lxArtArtancho >>, <<lxArtArtalto >> )
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
			for each loItem in this.oEntidad.ParticipantesDetalle
				if this.oEntidad.ParticipantesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.KitPartDet("NROITEM","COMP","BLOQREG","CODIGO","IPPART","ARTDET","IPCOLOR","COLDET","IPTALLE","CANT" ) values ( <<lxNroitem>>, <<lxComportamiento>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>> ) 
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
			local  lxArtFaltafw, lxArtAd1, lxArtAd3, lxArtFectrans, lxArtFmodifw, lxArtAd2, lxArtFecimpo, lxArtFecexpo, lxArtTimestamp, lxArtImportado, lxArtBloqreg, lxArtEsttrans, lxArtHoraimpo, lxArtUmodifw, lxArtVmodifw, lxArtValtafw, lxArtUaltafw, lxArtSaltafw, lxArtSmodifw, lxArtHoraexpo, lxArtHmodifw, lxArtBdmodifw, lxArtHaltafw, lxArtDescfw, lxArtBdaltafw, lxArtZadsfw, lxArtArimagen, lxArtArtcod, lxArtArtfab, lxArtAobs, lxArtNocom, lxArtAoferta, lxArtDeseco, lxArtArtdes, lxArtEsimpdes, lxArtArtuni, lxArtArtconiva, lxArtDesecohtml, lxArtArtesunkit, lxArtArtporiva, lxArtArtdesadic, lxArtAmate, lxArtArtcondevo, lxArtUnimed, lxArtAstock, lxArtArtiva, lxArtAesta, lxArtAnx2, lxArtAl3, lxArtAano, lxArtArtrest, lxArtArtsindes, lxArtReqccosto, lxArtMarca, lxArtPromoykit, lxArtArtnarba, lxArtImpinterno, lxArtClasifart, lxArtArtpercep, lxArtArtpeso, lxArtArtlargo, lxArtArtancho, lxArtArtalto
				lxArtFaltafw =  .Fechaaltafw			lxArtAd1 =  .Fechadealta			lxArtAd3 =  .Fechacambiooferta			lxArtFectrans =  .Fechatransferencia			lxArtFmodifw =  .Fechamodificacionfw			lxArtAd2 =  .Fechaultimamodificacion			lxArtFecimpo =  .Fechaimpo			lxArtFecexpo =  .Fechaexpo			lxArtTimestamp = goLibrerias.ObtenerTimestamp()			lxArtImportado =  .Importado			lxArtBloqreg =  .Bloquearregistro			lxArtEsttrans =  .Estadotransferencia			lxArtHoraimpo =  .Horaimpo			lxArtUmodifw =  .Usuariomodificacionfw			lxArtVmodifw =  .Versionmodificacionfw			lxArtValtafw =  .Versionaltafw			lxArtUaltafw =  .Usuarioaltafw			lxArtSaltafw =  .Seriealtafw			lxArtSmodifw =  .Seriemodificacionfw			lxArtHoraexpo =  .Horaexpo			lxArtHmodifw =  .Horamodificacionfw			lxArtBdmodifw =  .Basededatosmodificacionfw			lxArtHaltafw =  .Horaaltafw			lxArtDescfw =  .Descripcionfw			lxArtBdaltafw =  .Basededatosaltafw			lxArtZadsfw =  .Zadsfw			lxArtArimagen =  .Imagen			lxArtArtcod =  .Codigo			lxArtArtfab =  upper( .Proveedor_PK ) 			lxArtAobs =  .Observacion			lxArtNocom =  .Nocomercializable			lxArtAoferta =  .Esoferta			lxArtDeseco =  .Descecommerce			lxArtArtdes =  .Descripcion			lxArtEsimpdes =  .Imprimedespacho			lxArtArtuni =  upper( .Unidad_PK ) 			lxArtArtconiva =  .Condicionivaventas			lxArtDesecohtml =  .Descecommercehtml			lxArtArtesunkit =  .Esunkit			lxArtArtporiva =  .Porcentajeivaventas			lxArtArtdesadic =  .Descripcionadicional			lxArtAmate =  upper( .Material_PK ) 			lxArtArtcondevo =  .Permitedevolucion			lxArtUnimed =  .Unidaddemedida			lxArtAstock =  .Comportamiento			lxArtArtiva =  .Condicionivacompras			lxArtAesta =  .Estacion			lxArtAnx2 =  .Porcentajeivacompras			lxArtAl3 =  .Permitedescuento			lxArtAano =  .Anio			lxArtArtrest =  .Restringirarticulo			lxArtArtsindes =  .Restringirdescuentos			lxArtReqccosto =  .Requiereccosto			lxArtMarca =  upper( .Marca_PK ) 			lxArtPromoykit =  .Solopromoykit			lxArtArtnarba =  upper( .Nomenclador_PK ) 			lxArtImpinterno =  .Porcentajeimpuestointerno			lxArtClasifart =  upper( .Clasificacion_PK ) 			lxArtArtpercep =  .Percepcionivarg5329			lxArtArtpeso =  .Peso			lxArtArtlargo =  .Largo			lxArtArtancho =  .Ancho			lxArtArtalto =  .Alto
		endwith
		With this
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  this.ConvertirDateSql( .oEntidad.oAtributosAuditoria.NoComercializable) != this.ConvertirDateSql( .oEntidad.NoComercializable) )
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Artcod" = ] + lcValorClavePrimariaString  + [ and  ART.ARTCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ART set "Faltafw" = <<"'" + this.ConvertirDateSql( lxArtFaltafw ) + "'">>, "Ad1" = <<"'" + this.ConvertirDateSql( lxArtAd1 ) + "'">>, "Ad3" = <<"'" + this.ConvertirDateSql( lxArtAd3 ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxArtFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxArtFmodifw ) + "'">>, "Ad2" = <<"'" + this.ConvertirDateSql( lxArtAd2 ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxArtFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxArtFecexpo ) + "'">>, "Timestamp" = <<lxArtTimestamp>>, "Importado" = <<iif( lxArtImportado, 1, 0 )>>, "Bloqreg" = <<iif( lxArtBloqreg, 1, 0 )>>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxArtEsttrans ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxArtHoraimpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxArtUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxArtVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxArtValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxArtUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxArtSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxArtSmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxArtHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxArtHmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxArtBdmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxArtHaltafw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxArtDescfw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxArtBdaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxArtZadsfw ) + "'">>, "Arimagen" = <<"'" + this.FormatearTextoSql( lxArtArimagen ) + "'">>, "Artcod" = <<"'" + this.FormatearTextoSql( lxArtArtcod ) + "'">>, "Artfab" = <<"'" + this.FormatearTextoSql( lxArtArtfab ) + "'">>, "Aobs" = <<"'" + this.FormatearTextoSql( lxArtAobs ) + "'">>, "Nocom" = <<"'" + this.ConvertirDateSql( lxArtNocom ) + "'">>, "Aoferta" = <<lxArtAoferta>>, "Deseco" = <<"'" + this.FormatearTextoSql( lxArtDeseco ) + "'">>, "Artdes" = <<"'" + this.FormatearTextoSql( lxArtArtdes ) + "'">>, "Esimpdes" = <<iif( lxArtEsimpdes, 1, 0 )>>, "Artuni" = <<"'" + this.FormatearTextoSql( lxArtArtuni ) + "'">>, "Artconiva" = <<lxArtArtconiva>>, "Desecohtml" = <<"'" + this.FormatearTextoSql( lxArtDesecohtml ) + "'">>, "Artesunkit" = <<lxArtArtesunkit>>, "Artporiva" = <<lxArtArtporiva>>, "Artdesadic" = <<"'" + this.FormatearTextoSql( lxArtArtdesadic ) + "'">>, "Amate" = <<"'" + this.FormatearTextoSql( lxArtAmate ) + "'">>, "Artcondevo" = <<lxArtArtcondevo>>, "Unimed" = <<"'" + this.FormatearTextoSql( lxArtUnimed ) + "'">>, "Astock" = <<lxArtAstock>>, "Artiva" = <<lxArtArtiva>>, "Aesta" = <<lxArtAesta>>, "Anx2" = <<lxArtAnx2>>, "Al3" = <<iif( lxArtAl3, 1, 0 )>>, "Aano" = <<"'" + this.FormatearTextoSql( lxArtAano ) + "'">>, "Artrest" = <<"'" + this.ConvertirDateSql( lxArtArtrest ) + "'">>, "Artsindes" = <<iif( lxArtArtsindes, 1, 0 )>>, "Reqccosto" = <<lxArtReqccosto>>, "Marca" = <<"'" + this.FormatearTextoSql( lxArtMarca ) + "'">>, "Promoykit" = <<iif( lxArtPromoykit, 1, 0 )>>, "Artnarba" = <<"'" + this.FormatearTextoSql( lxArtArtnarba ) + "'">>, "Impinterno" = <<lxArtImpinterno>>, "Clasifart" = <<"'" + this.FormatearTextoSql( lxArtClasifart ) + "'">>, "Artpercep" = <<lxArtArtpercep>>, "Artpeso" = <<lxArtArtpeso>>, "Artlargo" = <<lxArtArtlargo>>, "Artancho" = <<lxArtArtancho>>, "Artalto" = <<lxArtArtalto>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ART' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
		If llInsertarAuditoria
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		EndIf
			loColeccion.Agregar([delete from ZooLogic.KitPartDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

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
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.KitPartDet("NROITEM","COMP","BLOQREG","CODIGO","IPPART","ARTDET","IPCOLOR","COLDET","IPTALLE","CANT" ) values ( <<lxNroitem>>, <<lxComportamiento>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>> ) 
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxARTNOCOM as variant, lcMensajeExtra as String
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
					llInsertarAuditoria = (  iif( isnull( ( curSeek.NOCOM != &lcCursor..NOCOM ) and ( !empty( goServicios.Librerias.ObtenerFechaFormateada( curSeek.NOCOM ) ) or !empty( goServicios.Librerias.ObtenerFechaFormateada( &lcCursor..NOCOM ) ) ) ), .F., ( curSeek.NOCOM != &lcCursor..NOCOM ) and ( !empty( goServicios.Librerias.ObtenerFechaFormateada( curSeek.NOCOM ) ) or !empty( goServicios.Librerias.ObtenerFechaFormateada( &lcCursor..NOCOM ) ) ) ) )
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
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.ART set  AD1 = ] + "'" + this.ConvertirDateSql( &lcCursor..AD1 ) + "'"+ [, AD3 = ] + "'" + this.ConvertirDateSql( &lcCursor..AD3 ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, AD2 = ] + "'" + this.ConvertirDateSql( &lcCursor..AD2 ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, Importado = ] + Transform( iif( &lcCursor..Importado, 1, 0 ))+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, ARIMAGEN = ] + "'" + this.FormatearTextoSql( &lcCursor..ARIMAGEN ) + "'"+ [, ARTCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTCOD ) + "'"+ [, ARTFAB = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTFAB ) + "'"+ [, AObs = ] + "'" + this.FormatearTextoSql( &lcCursor..AObs ) + "'"+ [, NOCOM = ] + "'" + this.ConvertirDateSql( &lcCursor..NOCOM ) + "'"+ [, AOFERTA = ] + transform( &lcCursor..AOFERTA )+ [, DesEco = ] + "'" + this.FormatearTextoSql( &lcCursor..DesEco ) + "'"+ [, ARTDES = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTDES ) + "'"+ [, EsImpDes = ] + Transform( iif( &lcCursor..EsImpDes, 1, 0 ))+ [, ARTUNI = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTUNI ) + "'"+ [, ARTCONIVA = ] + transform( &lcCursor..ARTCONIVA )+ [, DesEcoHTML = ] + "'" + this.FormatearTextoSql( &lcCursor..DesEcoHTML ) + "'"+ [, ARTESUNKIT = ] + transform( &lcCursor..ARTESUNKIT )+ [, ARTPORIVA = ] + transform( &lcCursor..ARTPORIVA )+ [, ARTDESADIC = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTDESADIC ) + "'"+ [, AMATE = ] + "'" + this.FormatearTextoSql( &lcCursor..AMATE ) + "'"+ [, ARTCONDEVO = ] + transform( &lcCursor..ARTCONDEVO )+ [, UniMed = ] + "'" + this.FormatearTextoSql( &lcCursor..UniMed ) + "'"+ [, ASTOCK = ] + transform( &lcCursor..ASTOCK )+ [, ARTIVA = ] + transform( &lcCursor..ARTIVA )+ [, AESTA = ] + transform( &lcCursor..AESTA )+ [, ANX2 = ] + transform( &lcCursor..ANX2 )+ [, AL3 = ] + Transform( iif( &lcCursor..AL3, 1, 0 ))+ [, AANO = ] + "'" + this.FormatearTextoSql( &lcCursor..AANO ) + "'"+ [, ArtRest = ] + "'" + this.ConvertirDateSql( &lcCursor..ArtRest ) + "'"+ [, ArtSinDes = ] + Transform( iif( &lcCursor..ArtSinDes, 1, 0 ))+ [, ReqCCosto = ] + transform( &lcCursor..ReqCCosto )+ [, Marca = ] + "'" + this.FormatearTextoSql( &lcCursor..Marca ) + "'"+ [, PromoYKit = ] + Transform( iif( &lcCursor..PromoYKit, 1, 0 ))+ [, ARTNARBA = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTNARBA ) + "'"+ [, impinterno = ] + transform( &lcCursor..impinterno )+ [, CLASIFART = ] + "'" + this.FormatearTextoSql( &lcCursor..CLASIFART ) + "'"+ [, ArtPercep = ] + transform( &lcCursor..ArtPercep )+ [, ARTPESO = ] + transform( &lcCursor..ARTPESO )+ [, ARTLARGO = ] + transform( &lcCursor..ARTLARGO )+ [, ARTANCHO = ] + transform( &lcCursor..ARTANCHO )+ [, ARTALTO = ] + transform( &lcCursor..ARTALTO ) + [ Where ARTCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTCOD ) + "'" )
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
					 FALTAFW, AD1, AD3, FECTRANS, FMODIFW, AD2, FECIMPO, FECEXPO, TIMESTAMP, Importado, BLOQREG, ESTTRANS, HORAIMPO, UMODIFW, VMODIFW, VALTAFW, UALTAFW, SALTAFW, SMODIFW, HORAEXPO, HMODIFW, BDMODIFW, HALTAFW, DescFW, BDALTAFW, ZADSFW, ARIMAGEN, ARTCOD, ARTFAB, AObs, NOCOM, AOFERTA, DesEco, ARTDES, EsImpDes, ARTUNI, ARTCONIVA, DesEcoHTML, ARTESUNKIT, ARTPORIVA, ARTDESADIC, AMATE, ARTCONDEVO, UniMed, ASTOCK, ARTIVA, AESTA, ANX2, AL3, AANO, ArtRest, ArtSinDes, ReqCCosto, Marca, PromoYKit, ARTNARBA, impinterno, CLASIFART, ArtPercep, ARTPESO, ARTLARGO, ARTANCHO, ARTALTO
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..AD1 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..AD3 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..AD2 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + Transform( iif( &lcCursor..Importado, 1, 0 )) + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ARIMAGEN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ARTCOD ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ARTFAB ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..AObs ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..NOCOM ) + "'" + ',' + transform( &lcCursor..AOFERTA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..DesEco ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ARTDES ) + "'" + ',' + Transform( iif( &lcCursor..EsImpDes, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ARTUNI ) + "'" + ',' + transform( &lcCursor..ARTCONIVA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..DesEcoHTML ) + "'" + ',' + transform( &lcCursor..ARTESUNKIT ) + ',' + transform( &lcCursor..ARTPORIVA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ARTDESADIC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..AMATE ) + "'" + ',' + transform( &lcCursor..ARTCONDEVO )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UniMed ) + "'" + ',' + transform( &lcCursor..ASTOCK ) + ',' + transform( &lcCursor..ARTIVA ) + ',' + transform( &lcCursor..AESTA ) + ',' + transform( &lcCursor..ANX2 ) + ',' + Transform( iif( &lcCursor..AL3, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..AANO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..ArtRest ) + "'" + ',' + Transform( iif( &lcCursor..ArtSinDes, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..ReqCCosto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Marca ) + "'" + ',' + Transform( iif( &lcCursor..PromoYKit, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ARTNARBA ) + "'" + ',' + transform( &lcCursor..impinterno ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLASIFART ) + "'" + ',' + transform( &lcCursor..ArtPercep ) + ',' + transform( &lcCursor..ARTPESO )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..ARTLARGO ) + ',' + transform( &lcCursor..ARTANCHO ) + ',' + transform( &lcCursor..ARTALTO )
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
					this.oConexion.EjecutarSql( [Delete From ZooLogic.KitPartDet Where CODIGO] + lcIn  )
					endfor
					if llEjecutaEnTransaccion
						this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
					endif
				EndIf
			endif
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
		create cursor &tcCursorACrear ( ARTCOD C (13) , Orden N(16), texto C(80))
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
			Case  lcAlias == lcPrefijo + 'ARTICULO_AOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ARTICULO_DESECO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ARTICULO_DESECOHTML'
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
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  AD1       
		* Validar ANTERIORES A 1/1/1753  AD3       
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  AD2       
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
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
"faltafw" datetime  null, 
"ad1" datetime  null, 
"ad3" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"ad2" datetime  null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"importado" bit  null, 
"bloqreg" bit  null, 
"esttrans" char( 20 )  null, 
"horaimpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"descfw" char( 200 )  null, 
"bdaltafw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"arimagen" char( 180 )  null, 
"artcod" char( 13 )  null, 
"artfab" char( 5 )  null, 
"aobs" varchar(max)  null, 
"nocom" datetime  null, 
"aoferta" numeric( 1, 0 )  null, 
"deseco" varchar(max)  null, 
"artdes" char( 40 )  null, 
"esimpdes" bit  null, 
"artuni" char( 3 )  null, 
"artconiva" numeric( 1, 0 )  null, 
"desecohtml" varchar(max)  null, 
"artesunkit" numeric( 1, 0 )  null, 
"artporiva" numeric( 5, 2 )  null, 
"artdesadic" char( 254 )  null, 
"amate" char( 10 )  null, 
"artcondevo" numeric( 1, 0 )  null, 
"unimed" char( 3 )  null, 
"astock" numeric( 1, 0 )  null, 
"artiva" numeric( 1, 0 )  null, 
"aesta" numeric( 1, 0 )  null, 
"anx2" numeric( 5, 2 )  null, 
"al3" bit  null, 
"aano" char( 2 )  null, 
"artrest" datetime  null, 
"artsindes" bit  null, 
"reqccosto" numeric( 1, 0 )  null, 
"marca" char( 30 )  null, 
"promoykit" bit  null, 
"artnarba" char( 6 )  null, 
"impinterno" numeric( 5, 2 )  null, 
"clasifart" char( 10 )  null, 
"artpercep" numeric( 1, 0 )  null, 
"artpeso" numeric( 11, 3 )  null, 
"artlargo" numeric( 11, 2 )  null, 
"artancho" numeric( 11, 2 )  null, 
"artalto" numeric( 11, 2 )  null )
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
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('ad1','ad1')
			.AgregarMapeo('ad3','ad3')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('ad2','ad2')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('importado','importado')
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('arimagen','arimagen')
			.AgregarMapeo('artcod','artcod')
			.AgregarMapeo('artfab','artfab')
			.AgregarMapeo('aobs','aobs')
			.AgregarMapeo('nocom','nocom')
			.AgregarMapeo('aoferta','aoferta')
			.AgregarMapeo('deseco','deseco')
			.AgregarMapeo('artdes','artdes')
			.AgregarMapeo('esimpdes','esimpdes')
			.AgregarMapeo('artuni','artuni')
			.AgregarMapeo('artconiva','artconiva')
			.AgregarMapeo('desecohtml','desecohtml')
			.AgregarMapeo('artesunkit','artesunkit')
			.AgregarMapeo('artporiva','artporiva')
			.AgregarMapeo('artdesadic','artdesadic')
			.AgregarMapeo('amate','amate')
			.AgregarMapeo('artcondevo','artcondevo')
			.AgregarMapeo('unimed','unimed')
			.AgregarMapeo('astock','astock')
			.AgregarMapeo('artiva','artiva')
			.AgregarMapeo('aesta','aesta')
			.AgregarMapeo('anx2','anx2')
			.AgregarMapeo('al3','al3')
			.AgregarMapeo('aano','aano')
			.AgregarMapeo('artrest','artrest')
			.AgregarMapeo('artsindes','artsindes')
			.AgregarMapeo('reqccosto','reqccosto')
			.AgregarMapeo('marca','marca')
			.AgregarMapeo('promoykit','promoykit')
			.AgregarMapeo('artnarba','artnarba')
			.AgregarMapeo('impinterno','impinterno')
			.AgregarMapeo('clasifart','clasifart')
			.AgregarMapeo('artpercep','artpercep')
			.AgregarMapeo('artpeso','artpeso')
			.AgregarMapeo('artlargo','artlargo')
			.AgregarMapeo('artancho','artancho')
			.AgregarMapeo('artalto','artalto')
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
				insert into ZooLogic.ADT_ART ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","ARTCOD","Nocom" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Artcod,Isnull( d.Nocom,t.Nocom)
						from ZooLogic.ART t inner join deleted d 
							 on t.ARTCOD = d.ARTCOD
					where ( d.NOCOM is not null and d.NOCOM <> t.NOCOM )
				Update t Set t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.AD1 = isnull( d.AD1, t.AD1 ),t.AD3 = isnull( d.AD3, t.AD3 ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.AD2 = isnull( d.AD2, t.AD2 ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.IMPORTADO = isnull( d.IMPORTADO, t.IMPORTADO ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.ARIMAGEN = isnull( d.ARIMAGEN, t.ARIMAGEN ),t.ARTCOD = isnull( d.ARTCOD, t.ARTCOD ),t.ARTFAB = isnull( d.ARTFAB, t.ARTFAB ),t.AOBS = isnull( d.AOBS, t.AOBS ),t.NOCOM = isnull( d.NOCOM, t.NOCOM ),t.AOFERTA = isnull( d.AOFERTA, t.AOFERTA ),t.DESECO = isnull( d.DESECO, t.DESECO ),t.ARTDES = isnull( d.ARTDES, t.ARTDES ),t.ESIMPDES = isnull( d.ESIMPDES, t.ESIMPDES ),t.ARTUNI = isnull( d.ARTUNI, t.ARTUNI ),t.ARTCONIVA = isnull( d.ARTCONIVA, t.ARTCONIVA ),t.DESECOHTML = isnull( d.DESECOHTML, t.DESECOHTML ),t.ARTESUNKIT = isnull( d.ARTESUNKIT, t.ARTESUNKIT ),t.ARTPORIVA = isnull( d.ARTPORIVA, t.ARTPORIVA ),t.ARTDESADIC = isnull( d.ARTDESADIC, t.ARTDESADIC ),t.AMATE = isnull( d.AMATE, t.AMATE ),t.ARTCONDEVO = isnull( d.ARTCONDEVO, t.ARTCONDEVO ),t.UNIMED = isnull( d.UNIMED, t.UNIMED ),t.ASTOCK = isnull( d.ASTOCK, t.ASTOCK ),t.ARTIVA = isnull( d.ARTIVA, t.ARTIVA ),t.AESTA = isnull( d.AESTA, t.AESTA ),t.ANX2 = isnull( d.ANX2, t.ANX2 ),t.AL3 = isnull( d.AL3, t.AL3 ),t.AANO = isnull( d.AANO, t.AANO ),t.ARTREST = isnull( d.ARTREST, t.ARTREST ),t.ARTSINDES = isnull( d.ARTSINDES, t.ARTSINDES ),t.REQCCOSTO = isnull( d.REQCCOSTO, t.REQCCOSTO ),t.MARCA = isnull( d.MARCA, t.MARCA ),t.PROMOYKIT = isnull( d.PROMOYKIT, t.PROMOYKIT ),t.ARTNARBA = isnull( d.ARTNARBA, t.ARTNARBA ),t.IMPINTERNO = isnull( d.IMPINTERNO, t.IMPINTERNO ),t.CLASIFART = isnull( d.CLASIFART, t.CLASIFART ),t.ARTPERCEP = isnull( d.ARTPERCEP, t.ARTPERCEP ),t.ARTPESO = isnull( d.ARTPESO, t.ARTPESO ),t.ARTLARGO = isnull( d.ARTLARGO, t.ARTLARGO ),t.ARTANCHO = isnull( d.ARTANCHO, t.ARTANCHO ),t.ARTALTO = isnull( d.ARTALTO, t.ARTALTO )
					from ZooLogic.ART t inner join deleted d 
							 on t.ARTCOD = d.ARTCOD
				-- Fin Updates
				insert into ZooLogic.ADT_ART ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","ARTCOD","Nocom" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Artcod,isnull( d.NOCOM,'')
						From deleted d left join ZooLogic.ART pk 
							 on d.ARTCOD = pk.ARTCOD
						Where pk.ARTCOD Is Null 
				insert into ZooLogic.ART(Faltafw,Ad1,Ad3,Fectrans,Fmodifw,Ad2,Fecimpo,Fecexpo,Timestamp,Importado,Bloqreg,Esttrans,Horaimpo,Umodifw,Vmodifw,Valtafw,Ualtafw,Saltafw,Smodifw,Horaexpo,Hmodifw,Bdmodifw,Haltafw,Descfw,Bdaltafw,Zadsfw,Arimagen,Artcod,Artfab,Aobs,Nocom,Aoferta,Deseco,Artdes,Esimpdes,Artuni,Artconiva,Desecohtml,Artesunkit,Artporiva,Artdesadic,Amate,Artcondevo,Unimed,Astock,Artiva,Aesta,Anx2,Al3,Aano,Artrest,Artsindes,Reqccosto,Marca,Promoykit,Artnarba,Impinterno,Clasifart,Artpercep,Artpeso,Artlargo,Artancho,Artalto)
					Select CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.AD1,''),isnull( d.AD3,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.AD2,''),isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.TIMESTAMP,0),isnull( d.IMPORTADO,0),isnull( d.BLOQREG,0),isnull( d.ESTTRANS,''),isnull( d.HORAIMPO,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.BDMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.DESCFW,''),isnull( d.BDALTAFW,''),isnull( d.ZADSFW,''),isnull( d.ARIMAGEN,''),isnull( d.ARTCOD,''),isnull( d.ARTFAB,''),isnull( d.AOBS,''),isnull( d.NOCOM,''),isnull( d.AOFERTA,0),isnull( d.DESECO,''),isnull( d.ARTDES,''),isnull( d.ESIMPDES,0),isnull( d.ARTUNI,''),isnull( d.ARTCONIVA,0),isnull( d.DESECOHTML,''),isnull( d.ARTESUNKIT,0),isnull( d.ARTPORIVA,0),isnull( d.ARTDESADIC,''),isnull( d.AMATE,''),isnull( d.ARTCONDEVO,0),isnull( d.UNIMED,''),isnull( d.ASTOCK,0),isnull( d.ARTIVA,0),isnull( d.AESTA,0),isnull( d.ANX2,0),isnull( d.AL3,0),isnull( d.AANO,''),isnull( d.ARTREST,''),isnull( d.ARTSINDES,0),isnull( d.REQCCOSTO,0),isnull( d.MARCA,''),isnull( d.PROMOYKIT,0),isnull( d.ARTNARBA,''),isnull( d.IMPINTERNO,0),isnull( d.CLASIFART,''),isnull( d.ARTPERCEP,0),isnull( d.ARTPESO,0),isnull( d.ARTLARGO,0),isnull( d.ARTANCHO,0),isnull( d.ARTALTO,0)
						From deleted d left join ZooLogic.ART pk 
							 on d.ARTCOD = pk.ARTCOD
						Where pk.ARTCOD Is Null 
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
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARTICULO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechadealta = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARTICULO.Fechadealta, ctod( '  /  /    ' ) ) )
					.Fechacambiooferta = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARTICULO.Fechacambiooferta, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARTICULO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARTICULO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaultimamodificacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARTICULO.Fechaultimamodificacion, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARTICULO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARTICULO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_ARTICULO.Timestamp, 0 )
					.Importado = nvl( c_ARTICULO.Importado, .F. )
					.Bloquearregistro = nvl( c_ARTICULO.Bloquearregistro, .F. )
					.Estadotransferencia = nvl( c_ARTICULO.Estadotransferencia, [] )
					.Horaimpo = nvl( c_ARTICULO.Horaimpo, [] )
					.Usuariomodificacionfw = nvl( c_ARTICULO.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_ARTICULO.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_ARTICULO.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_ARTICULO.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_ARTICULO.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_ARTICULO.Seriemodificacionfw, [] )
					.Horaexpo = nvl( c_ARTICULO.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_ARTICULO.Horamodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_ARTICULO.Basededatosmodificacionfw, [] )
					.Horaaltafw = nvl( c_ARTICULO.Horaaltafw, [] )
					.Descripcionfw = nvl( c_ARTICULO.Descripcionfw, [] )
					.Basededatosaltafw = nvl( c_ARTICULO.Basededatosaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Imagen = nvl( c_ARTICULO.Imagen, [] )
					.Codigo = nvl( c_ARTICULO.Codigo, [] )
					.Proveedor_PK =  nvl( c_ARTICULO.Proveedor, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Nocomercializable = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARTICULO.Nocomercializable, ctod( '  /  /    ' ) ) )
					.Esoferta = nvl( c_ARTICULO.Esoferta, 0 )
					lcValor = This.ObtenerMemo( 'c_Descecommerce')
					.Descecommerce = lcValor 
					.Descripcion = nvl( c_ARTICULO.Descripcion, [] )
					.Imprimedespacho = nvl( c_ARTICULO.Imprimedespacho, .F. )
					.Unidad_PK =  nvl( c_ARTICULO.Unidad, [] )
					.Condicionivaventas = nvl( c_ARTICULO.Condicionivaventas, 0 )
					lcValor = This.ObtenerMemo( 'c_Descecommercehtml')
					.Descecommercehtml = lcValor 
					.Esunkit = nvl( c_ARTICULO.Esunkit, 0 )
					.Porcentajeivaventas = nvl( c_ARTICULO.Porcentajeivaventas, 0 )
					.Descripcionadicional = nvl( c_ARTICULO.Descripcionadicional, [] )
					.Material_PK =  nvl( c_ARTICULO.Material, [] )
					.Permitedevolucion = nvl( c_ARTICULO.Permitedevolucion, 0 )
					.Unidaddemedida = nvl( c_ARTICULO.Unidaddemedida, [] )
					.Comportamiento = nvl( c_ARTICULO.Comportamiento, 0 )
					.Condicionivacompras = nvl( c_ARTICULO.Condicionivacompras, 0 )
					.Participantesdetalle.Limpiar()
					.Participantesdetalle.SetearEsNavegacion( .lProcesando )
					.Participantesdetalle.Cargar()
					.Estacion = nvl( c_ARTICULO.Estacion, 0 )
					.Porcentajeivacompras = nvl( c_ARTICULO.Porcentajeivacompras, 0 )
					.Permitedescuento = nvl( c_ARTICULO.Permitedescuento, .F. )
					.Anio = nvl( c_ARTICULO.Anio, [] )
					.Restringirarticulo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARTICULO.Restringirarticulo, ctod( '  /  /    ' ) ) )
					.Restringirdescuentos = nvl( c_ARTICULO.Restringirdescuentos, .F. )
					.Requiereccosto = nvl( c_ARTICULO.Requiereccosto, 0 )
					.Marca_PK =  nvl( c_ARTICULO.Marca, [] )
					.Solopromoykit = nvl( c_ARTICULO.Solopromoykit, .F. )
					.Nomenclador_PK =  nvl( c_ARTICULO.Nomenclador, [] )
					.Porcentajeimpuestointerno = nvl( c_ARTICULO.Porcentajeimpuestointerno, 0 )
					.Clasificacion_PK =  nvl( c_ARTICULO.Clasificacion, [] )
					.Percepcionivarg5329 = nvl( c_ARTICULO.Percepcionivarg5329, 0 )
					.Peso = nvl( c_ARTICULO.Peso, 0 )
					.Largo = nvl( c_ARTICULO.Largo, 0 )
					.Ancho = nvl( c_ARTICULO.Ancho, 0 )
					.Alto = nvl( c_ARTICULO.Alto, 0 )
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
			Local lcEntidad1 as string, lcEntidad2 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad2 = "'" + this.ConvertirDateSql( this.oEntidad.Nocomercializable ) + "'"
			
		else
			lxValorClavePrimaria = &tcCursor..ARTCOD
			Local lcEntidad1 as string, lcEntidad2 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad2 = "'" + this.ConvertirDateSql( &tcCursor..Nocom ) + "'"
			
		endif
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_ART ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","ARTCOD","Nocom" ) values ( <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, <<lcCabecera10>>, <<lcEntidad1>>, <<lcEntidad2>> ) 
			endtext
		return lcSentencia
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
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
			"Faltafw" as "Fechaaltafw", "Ad1" as "Fechadealta", "Ad3" as "Fechacambiooferta", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Ad2" as "Fechaultimamodificacion", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Importado" as "Importado", "Bloqreg" as "Bloquearregistro", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Arimagen" as "Imagen", "Artcod" as "Codigo", "Artfab" as "Proveedor", "Aobs" as "Observacion", "Nocom" as "Nocomercializable", "Aoferta" as "Esoferta", "Deseco" as "Descecommerce", "Artdes" as "Descripcion", "Esimpdes" as "Imprimedespacho", "Artuni" as "Unidad", "Artconiva" as "Condicionivaventas", "Desecohtml" as "Descecommercehtml", "Artesunkit" as "Esunkit", "Artporiva" as "Porcentajeivaventas", "Artdesadic" as "Descripcionadicional", "Amate" as "Material", "Artcondevo" as "Permitedevolucion", "Unimed" as "Unidaddemedida", "Astock" as "Comportamiento", "Artiva" as "Condicionivacompras", "Aesta" as "Estacion", "Anx2" as "Porcentajeivacompras", "Al3" as "Permitedescuento", "Aano" as "Anio", "Artrest" as "Restringirarticulo", "Artsindes" as "Restringirdescuentos", "Reqccosto" as "Requiereccosto", "Marca" as "Marca", "Promoykit" as "Solopromoykit", "Artnarba" as "Nomenclador", "Impinterno" as "Porcentajeimpuestointerno", "Clasifart" as "Clasificacion", "Artpercep" as "Percepcionivarg5329", "Artpeso" as "Peso", "Artlargo" as "Largo", "Artancho" as "Ancho", "Artalto" as "Alto"
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
	<row entidad="ARTICULO                                " atributo="FECHAALTAFW                             " tabla="ART            " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="FECHADEALTA                             " tabla="ART            " campo="AD1       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Alta                                                                                                                                                            " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="FECHACAMBIOOFERTA                       " tabla="ART            " campo="AD3       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="FECHATRANSFERENCIA                      " tabla="ART            " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="FECHAMODIFICACIONFW                     " tabla="ART            " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="FECHAULTIMAMODIFICACION                 " tabla="ART            " campo="AD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Ultima modificación                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="FECHAIMPO                               " tabla="ART            " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="FECHAEXPO                               " tabla="ART            " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="LISTADEPRECIOSCHECK                     " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="LSTPRECIOCHK                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="TIMESTAMP                               " tabla="ART            " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="IMPORTADO                               " tabla="ART            " campo="IMPORTADO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Importado                                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="BLOQUEARREGISTRO                        " tabla="ART            " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="ESTADOTRANSFERENCIA                     " tabla="ART            " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="HORAIMPO                                " tabla="ART            " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="USUARIOMODIFICACIONFW                   " tabla="ART            " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="VERSIONMODIFICACIONFW                   " tabla="ART            " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="VERSIONALTAFW                           " tabla="ART            " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="USUARIOALTAFW                           " tabla="ART            " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="SERIEALTAFW                             " tabla="ART            " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="SERIEMODIFICACIONFW                     " tabla="ART            " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="HORAEXPO                                " tabla="ART            " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="HORAMODIFICACIONFW                      " tabla="ART            " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ART            " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="HORAALTAFW                              " tabla="ART            " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCIONFW                           " tabla="ART            " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="BASEDEDATOSALTAFW                       " tabla="ART            " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="ZADSFW                                  " tabla="ART            " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="IMAGEN                                  " tabla="ART            " campo="ARIMAGEN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="180" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Imagen                                                                                                                                                          " dominio="IMAGENCONRUTADINAMICA         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="CODIGO                                  " tabla="ART            " campo="ARTCOD    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="PROVEEDOR                               " tabla="ART            " campo="ARTFAB    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="OBSERVACION                             " tabla="ART            " campo="AOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="NOCOMERCIALIZABLE                       " tabla="ART            " campo="NOCOM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="44" etiqueta="A partir del                                                                                                                                                    " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="ESOFERTA                                " tabla="ART            " campo="AOFERTA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="404" etiqueta="En oferta                                                                                                                                                       " dominio="SINOINVERTIDO                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCECOMMERCE                           " tabla="ART            " campo="DESECO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Descripción ampliada                                                                                                                                            " dominio="OBSERVACION4R                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="IMPRIMEDESPACHO                         " tabla="ART            " campo="ESIMPDES  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Imprime despacho                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="UNIDAD                                  " tabla="ART            " campo="ARTUNI    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="UNIDADDEMEDIDA                          " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Unidad                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="CONDICIONIVAVENTAS                      " tabla="ART            " campo="ARTCONIVA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Condición de impuestos (ventas)                                                                                                                                 " dominio="COMBOCONDICIONIVA             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCECOMMERCEHTML                       " tabla="ART            " campo="DESECOHTML" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Descripción HTML                                                                                                                                                " dominio="OBSERVACION18R                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="ESUNKIT                                 " tabla="ART            " campo="ARTESUNKIT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="Es un Kit                                                                                                                                                       " dominio="SINOINVERTIDO                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="PORCENTAJEIVAVENTAS                     " tabla="ART            " campo="ARTPORIVA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="%                                                                                                                                                               " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCIONADICIONAL                    " tabla="ART            " campo="ARTDESADIC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción adicional                                                                                                                                           " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="MATERIAL                                " tabla="ART            " campo="AMATE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MATERIAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Material                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="PERMITEDEVOLUCION                       " tabla="ART            " campo="ARTCONDEVO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="Permite Devolución                                                                                                                                              " dominio="SINOGENERICO                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="UNIDADDEMEDIDA                          " tabla="ART            " campo="UNIMED    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Unidad de medida                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="COMPORTAMIENTO                          " tabla="ART            " campo="ASTOCK    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="40" etiqueta="Comportamiento                                                                                                                                                  " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="CONDICIONIVACOMPRAS                     " tabla="ART            " campo="ARTIVA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Condición de impuestos (compras)                                                                                                                                " dominio="COMBOCONDICIONIVA             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="PARTICIPANTESDETALLE                    " tabla="KITPARTDET     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta=".                                                                                                                                                               " dominio="DETALLEITEMPARTICIPANTES      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="ESTACION                                " tabla="ART            " campo="AESTA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="424" etiqueta="Estación                                                                                                                                                        " dominio="ESTACION                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="PORCENTAJEIVACOMPRAS                    " tabla="ART            " campo="ANX2      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="%                                                                                                                                                               " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="PERMITEDESCUENTO                        " tabla="ART            " campo="AL3       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Permite Descuento                                                                                                                                               " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="ANIO                                    " tabla="ART            " campo="AANO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="=right(str(year(goServicios.Librerias.ObtenerFecha())),2)                                                                                                                                                                                                     " obligatorio="false" admitebusqueda="428" etiqueta="Año                                                                                                                                                             " dominio="ANIO                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="RESTRINGIRARTICULO                      " tabla="ART            " campo="ARTREST   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Restringir a partir del                                                                                                                                         " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="RESTRINGIRDESCUENTOS                    " tabla="ART            " campo="ARTSINDES " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Restringir descuentos                                                                                                                                           " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="REQUIERECCOSTO                          " tabla="ART            " campo="REQCCOSTO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Requiere centro de costo                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="MARCA                                   " tabla="ART            " campo="MARCA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MARCA                                   " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="48" etiqueta="Marca                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="SOLOPROMOYKIT                           " tabla="ART            " campo="PROMOYKIT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Comercializable solo en promos y/o kits                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="NOMENCLADOR                             " tabla="ART            " campo="ARTNARBA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="NOMENCLADORARBA                         " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Código del nomenclador ARBA                                                                                                                                     " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="PORCENTAJEIMPUESTOINTERNO               " tabla="ART            " campo="IMPINTERNO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Impuesto interno                                                                                                                                                " dominio="IMPUESTOINTERNO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="CLASIFICACION                           " tabla="ART            " campo="CLASIFART " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONARTICULO                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="48" etiqueta="Clasificación                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="PERCEPCIONIVARG5329                     " tabla="ART            " campo="ARTPERCEP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Percepción IVA según RG 5329/23                                                                                                                                 " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="28" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="PESO                                    " tabla="ART            " campo="ARTPESO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="11" decimales="3" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Peso ( kg.)                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="LARGO                                   " tabla="ART            " campo="ARTLARGO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="11" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Largo ( cm.)                                                                                                                                                    " dominio="DIMENSION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="32" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="ANCHO                                   " tabla="ART            " campo="ARTANCHO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="11" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="Ancho                                                                                                                                                           " dominio="DIMENSION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="34" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="ALTO                                    " tabla="ART            " campo="ARTALTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="11" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="Alto                                                                                                                                                            " dominio="DIMENSION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="36" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROVEED        " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVEED On ART.ARTFAB = PROVEED.CLCOD And  PROVEED.CLCOD != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="UNIDADDEMEDIDA                          " atributo="DESCRIPCION                             " tabla="UNMED          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Uni.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join UNMED On ART.ARTUNI = UNMED.Cod And  UNMED.COD != ''                                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MATERIAL                                " atributo="DESCRIPCION                             " tabla="MAT            " campo="MATDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Mat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MAT On ART.AMATE = MAT.MATCOD And  MAT.MATCOD != ''                                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MARCA                                   " atributo="DESCRIPCION                             " tabla="MARCAS         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="49" etiqueta="Detalle Mar.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MARCAS On ART.MARCA = MARCAS.Codigo And  MARCAS.CODIGO != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="DESCRIPCION                             " tabla="NMCARBA        " campo="NMCDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="439" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join NMCARBA On ART.ARTNARBA = NMCARBA.NMCCOD And  NMCARBA.NMCCOD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONARTICULO                   " atributo="DESCRIPCION                             " tabla="CLASIFART      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="49" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIFART On ART.CLASIFART = CLASIFART.CODIGO And  CLASIFART.CODIGO != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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