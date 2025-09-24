
define class Din_EntidadPROPIEDADESLISTADOSAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_PROPIEDADESLISTADOS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_PLIPK'
	cTablaPrincipal = 'PROPLIST'
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
			local  lxProplistFecimpo, lxProplistFaltafw, lxProplistFecexpo, lxProplistFmodifw, lxProplistFectrans, lxProplistHaltafw, lxProplistHoraexpo, lxProplistHmodifw, lxProplistHoraimpo, lxProplistVmodifw, lxProplistZadsfw, lxProplistValtafw, lxProplistUmodifw, lxProplistSmodifw, lxProplistUaltafw, lxProplistSaltafw, lxProplistEsttrans, lxProplistBdaltafw, lxProplistBdmodifw, lxProplistCodigo, lxProplistNombre, lxProplistEtiqueta, lxProplistLongitud, lxProplistDecimales, lxProplistCalculo, lxProplistMceros, lxProplistPcrecer, lxProplistOrepetido, lxProplistLvertical, lxProplistWimagen, lxProplistMimagen, lxProplistHimagen, lxProplistCriteinit, lxProplistDiasatras, lxProplistVnidesde, lxProplistVnihasta, lxProplistVcidesde, lxProplistVcihasta, lxProplistVibooleano, lxProplistVisinobool, lxProplistSlectura, lxProplistNoinformar, lxProplistNomostrar, lxProplistTitulo, lxProplistImagen, lxProplistFechaimpre, lxProplistHoraimpre, lxProplistObs, lxProplistCestilo, lxProplistMderecho, lxProplistMizquierdo, lxProplistMcabe, lxProplistMpie, lxProplistOrien, lxProplistDdetalle, lxProplistColorsombr
				lxProplistFecimpo =  .Fechaimpo			lxProplistFaltafw =  .Fechaaltafw			lxProplistFecexpo =  .Fechaexpo			lxProplistFmodifw =  .Fechamodificacionfw			lxProplistFectrans =  .Fechatransferencia			lxProplistHaltafw =  .Horaaltafw			lxProplistHoraexpo =  .Horaexpo			lxProplistHmodifw =  .Horamodificacionfw			lxProplistHoraimpo =  .Horaimpo			lxProplistVmodifw =  .Versionmodificacionfw			lxProplistZadsfw =  .Zadsfw			lxProplistValtafw =  .Versionaltafw			lxProplistUmodifw =  .Usuariomodificacionfw			lxProplistSmodifw =  .Seriemodificacionfw			lxProplistUaltafw =  .Usuarioaltafw			lxProplistSaltafw =  .Seriealtafw			lxProplistEsttrans =  .Estadotransferencia			lxProplistBdaltafw =  .Basededatosaltafw			lxProplistBdmodifw =  .Basededatosmodificacionfw			lxProplistCodigo =  .Codigo			lxProplistNombre =  .Nombre			lxProplistEtiqueta =  .Etiqueta			lxProplistLongitud =  .Longitud			lxProplistDecimales =  .Decimalesreporte			lxProplistCalculo =  .Tipocalculo			lxProplistMceros =  .Mostrarceros			lxProplistPcrecer =  .Puedecrecer			lxProplistOrepetido =  .Ocultarepetido			lxProplistLvertical =  .Lineavertical			lxProplistWimagen =  .Anchoimagen			lxProplistMimagen =  .Tamañooriginalimagen			lxProplistHimagen =  .Altoimagen			lxProplistCriteinit =  .Criteriodeinicializacion			lxProplistDiasatras =  .Diashaciaatras			lxProplistVnidesde =  .Valornumericoinicial_desde			lxProplistVnihasta =  .Valornumericoinicial_hasta			lxProplistVcidesde =  .Valorcaracterinicial_desde			lxProplistVcihasta =  .Valorcaracterinicial_hasta			lxProplistVibooleano =  .Valorbooleanoinicial			lxProplistVisinobool =  .Valorsinoinicial			lxProplistSlectura =  .Sololectura			lxProplistNoinformar =  .Noinformar			lxProplistNomostrar =  .Nomostrar			lxProplistTitulo =  .Titulolistado			lxProplistImagen =  .Imagenlistado			lxProplistFechaimpre =  .Imprimefechadeimpresion			lxProplistHoraimpre =  .Imprimehoradeimpresion			lxProplistObs =  .Obs			lxProplistCestilo =  upper( .Estilo_PK ) 			lxProplistMderecho =  .Margenderecho			lxProplistMizquierdo =  .Margenizquierdo			lxProplistMcabe =  .Margencabecera			lxProplistMpie =  .Margenpie			lxProplistOrien =  .Orientacion			lxProplistDdetalle =  .Diferenciardetalle			lxProplistColorsombr =  .Colorparaelsombreado
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxProplistCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.PROPLIST ( "Fecimpo","Faltafw","Fecexpo","Fmodifw","Fectrans","Haltafw","Horaexpo","Hmodifw","Horaimpo","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Saltafw","Esttrans","Bdaltafw","Bdmodifw","Codigo","Nombre","Etiqueta","Longitud","Decimales","Calculo","Mceros","Pcrecer","Orepetido","Lvertical","Wimagen","Mimagen","Himagen","Criteinit","Diasatras","Vnidesde","Vnihasta","Vcidesde","Vcihasta","Vibooleano","Visinobool","Slectura","Noinformar","Nomostrar","Titulo","Imagen","Fechaimpre","Horaimpre","Obs","Cestilo","Mderecho","Mizquierdo","Mcabe","Mpie","Orien","Ddetalle","Colorsombr" ) values ( <<"'" + this.ConvertirDateSql( lxProplistFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProplistFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProplistFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProplistFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProplistFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistNombre ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistEtiqueta ) + "'" >>, <<lxProplistLongitud >>, <<lxProplistDecimales >>, <<"'" + this.FormatearTextoSql( lxProplistCalculo ) + "'" >>, <<iif( lxProplistMceros, 1, 0 ) >>, <<iif( lxProplistPcrecer, 1, 0 ) >>, <<iif( lxProplistOrepetido, 1, 0 ) >>, <<iif( lxProplistLvertical, 1, 0 ) >>, <<lxProplistWimagen >>, <<iif( lxProplistMimagen, 1, 0 ) >>, <<lxProplistHimagen >>, <<lxProplistCriteinit >>, <<lxProplistDiasatras >>, <<lxProplistVnidesde >>, <<lxProplistVnihasta >>, <<"'" + this.FormatearTextoSql( lxProplistVcidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistVcihasta ) + "'" >>, <<lxProplistVibooleano >>, <<lxProplistVisinobool >>, <<iif( lxProplistSlectura, 1, 0 ) >>, <<iif( lxProplistNoinformar, 1, 0 ) >>, <<iif( lxProplistNomostrar, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxProplistTitulo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistImagen ) + "'" >>, <<iif( lxProplistFechaimpre, 1, 0 ) >>, <<iif( lxProplistHoraimpre, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxProplistObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistCestilo ) + "'" >>, <<lxProplistMderecho >>, <<lxProplistMizquierdo >>, <<lxProplistMcabe >>, <<lxProplistMpie >>, <<lxProplistOrien >>, <<iif( lxProplistDdetalle, 1, 0 ) >>, <<lxProplistColorsombr >> )
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
			local  lxProplistFecimpo, lxProplistFaltafw, lxProplistFecexpo, lxProplistFmodifw, lxProplistFectrans, lxProplistHaltafw, lxProplistHoraexpo, lxProplistHmodifw, lxProplistHoraimpo, lxProplistVmodifw, lxProplistZadsfw, lxProplistValtafw, lxProplistUmodifw, lxProplistSmodifw, lxProplistUaltafw, lxProplistSaltafw, lxProplistEsttrans, lxProplistBdaltafw, lxProplistBdmodifw, lxProplistCodigo, lxProplistNombre, lxProplistEtiqueta, lxProplistLongitud, lxProplistDecimales, lxProplistCalculo, lxProplistMceros, lxProplistPcrecer, lxProplistOrepetido, lxProplistLvertical, lxProplistWimagen, lxProplistMimagen, lxProplistHimagen, lxProplistCriteinit, lxProplistDiasatras, lxProplistVnidesde, lxProplistVnihasta, lxProplistVcidesde, lxProplistVcihasta, lxProplistVibooleano, lxProplistVisinobool, lxProplistSlectura, lxProplistNoinformar, lxProplistNomostrar, lxProplistTitulo, lxProplistImagen, lxProplistFechaimpre, lxProplistHoraimpre, lxProplistObs, lxProplistCestilo, lxProplistMderecho, lxProplistMizquierdo, lxProplistMcabe, lxProplistMpie, lxProplistOrien, lxProplistDdetalle, lxProplistColorsombr
				lxProplistFecimpo =  .Fechaimpo			lxProplistFaltafw =  .Fechaaltafw			lxProplistFecexpo =  .Fechaexpo			lxProplistFmodifw =  .Fechamodificacionfw			lxProplistFectrans =  .Fechatransferencia			lxProplistHaltafw =  .Horaaltafw			lxProplistHoraexpo =  .Horaexpo			lxProplistHmodifw =  .Horamodificacionfw			lxProplistHoraimpo =  .Horaimpo			lxProplistVmodifw =  .Versionmodificacionfw			lxProplistZadsfw =  .Zadsfw			lxProplistValtafw =  .Versionaltafw			lxProplistUmodifw =  .Usuariomodificacionfw			lxProplistSmodifw =  .Seriemodificacionfw			lxProplistUaltafw =  .Usuarioaltafw			lxProplistSaltafw =  .Seriealtafw			lxProplistEsttrans =  .Estadotransferencia			lxProplistBdaltafw =  .Basededatosaltafw			lxProplistBdmodifw =  .Basededatosmodificacionfw			lxProplistCodigo =  .Codigo			lxProplistNombre =  .Nombre			lxProplistEtiqueta =  .Etiqueta			lxProplistLongitud =  .Longitud			lxProplistDecimales =  .Decimalesreporte			lxProplistCalculo =  .Tipocalculo			lxProplistMceros =  .Mostrarceros			lxProplistPcrecer =  .Puedecrecer			lxProplistOrepetido =  .Ocultarepetido			lxProplistLvertical =  .Lineavertical			lxProplistWimagen =  .Anchoimagen			lxProplistMimagen =  .Tamañooriginalimagen			lxProplistHimagen =  .Altoimagen			lxProplistCriteinit =  .Criteriodeinicializacion			lxProplistDiasatras =  .Diashaciaatras			lxProplistVnidesde =  .Valornumericoinicial_desde			lxProplistVnihasta =  .Valornumericoinicial_hasta			lxProplistVcidesde =  .Valorcaracterinicial_desde			lxProplistVcihasta =  .Valorcaracterinicial_hasta			lxProplistVibooleano =  .Valorbooleanoinicial			lxProplistVisinobool =  .Valorsinoinicial			lxProplistSlectura =  .Sololectura			lxProplistNoinformar =  .Noinformar			lxProplistNomostrar =  .Nomostrar			lxProplistTitulo =  .Titulolistado			lxProplistImagen =  .Imagenlistado			lxProplistFechaimpre =  .Imprimefechadeimpresion			lxProplistHoraimpre =  .Imprimehoradeimpresion			lxProplistObs =  .Obs			lxProplistCestilo =  upper( .Estilo_PK ) 			lxProplistMderecho =  .Margenderecho			lxProplistMizquierdo =  .Margenizquierdo			lxProplistMcabe =  .Margencabecera			lxProplistMpie =  .Margenpie			lxProplistOrien =  .Orientacion			lxProplistDdetalle =  .Diferenciardetalle			lxProplistColorsombr =  .Colorparaelsombreado
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.PROPLIST set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxProplistFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxProplistFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxProplistFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxProplistFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxProplistFectrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxProplistHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxProplistHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxProplistHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxProplistHoraimpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxProplistVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxProplistZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxProplistValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxProplistUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxProplistSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxProplistUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxProplistSaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxProplistEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxProplistBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxProplistBdmodifw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxProplistCodigo ) + "'">>,"Nombre" = <<"'" + this.FormatearTextoSql( lxProplistNombre ) + "'">>,"Etiqueta" = <<"'" + this.FormatearTextoSql( lxProplistEtiqueta ) + "'">>,"Longitud" = <<lxProplistLongitud>>,"Decimales" = <<lxProplistDecimales>>,"Calculo" = <<"'" + this.FormatearTextoSql( lxProplistCalculo ) + "'">>,"Mceros" = <<iif( lxProplistMceros, 1, 0 )>>,"Pcrecer" = <<iif( lxProplistPcrecer, 1, 0 )>>,"Orepetido" = <<iif( lxProplistOrepetido, 1, 0 )>>,"Lvertical" = <<iif( lxProplistLvertical, 1, 0 )>>,"Wimagen" = <<lxProplistWimagen>>,"Mimagen" = <<iif( lxProplistMimagen, 1, 0 )>>,"Himagen" = <<lxProplistHimagen>>,"Criteinit" = <<lxProplistCriteinit>>,"Diasatras" = <<lxProplistDiasatras>>,"Vnidesde" = <<lxProplistVnidesde>>,"Vnihasta" = <<lxProplistVnihasta>>,"Vcidesde" = <<"'" + this.FormatearTextoSql( lxProplistVcidesde ) + "'">>,"Vcihasta" = <<"'" + this.FormatearTextoSql( lxProplistVcihasta ) + "'">>,"Vibooleano" = <<lxProplistVibooleano>>,"Visinobool" = <<lxProplistVisinobool>>,"Slectura" = <<iif( lxProplistSlectura, 1, 0 )>>,"Noinformar" = <<iif( lxProplistNoinformar, 1, 0 )>>,"Nomostrar" = <<iif( lxProplistNomostrar, 1, 0 )>>,"Titulo" = <<"'" + this.FormatearTextoSql( lxProplistTitulo ) + "'">>,"Imagen" = <<"'" + this.FormatearTextoSql( lxProplistImagen ) + "'">>,"Fechaimpre" = <<iif( lxProplistFechaimpre, 1, 0 )>>,"Horaimpre" = <<iif( lxProplistHoraimpre, 1, 0 )>>,"Obs" = <<"'" + this.FormatearTextoSql( lxProplistObs ) + "'">>,"Cestilo" = <<"'" + this.FormatearTextoSql( lxProplistCestilo ) + "'">>,"Mderecho" = <<lxProplistMderecho>>,"Mizquierdo" = <<lxProplistMizquierdo>>,"Mcabe" = <<lxProplistMcabe>>,"Mpie" = <<lxProplistMpie>>,"Orien" = <<lxProplistOrien>>,"Ddetalle" = <<iif( lxProplistDdetalle, 1, 0 )>>,"Colorsombr" = <<lxProplistColorsombr>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxProplistCodigo ) + "'">> and  PROPLIST.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.PROPLIST where " + this.ConvertirFuncionesSql( " PROPLIST.CODIGO != ''" ) )
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
			Local lxProplistCodigo
			lxProplistCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Nombre" as "Nombre", "Etiqueta" as "Etiqueta", "Longitud" as "Longitud", "Decimales" as "Decimalesreporte", "Calculo" as "Tipocalculo", "Mceros" as "Mostrarceros", "Pcrecer" as "Puedecrecer", "Orepetido" as "Ocultarepetido", "Lvertical" as "Lineavertical", "Wimagen" as "Anchoimagen", "Mimagen" as "Tamañooriginalimagen", "Himagen" as "Altoimagen", "Criteinit" as "Criteriodeinicializacion", "Diasatras" as "Diashaciaatras", "Vnidesde" as "Valornumericoinicial_desde", "Vnihasta" as "Valornumericoinicial_hasta", "Vcidesde" as "Valorcaracterinicial_desde", "Vcihasta" as "Valorcaracterinicial_hasta", "Vibooleano" as "Valorbooleanoinicial", "Visinobool" as "Valorsinoinicial", "Slectura" as "Sololectura", "Noinformar" as "Noinformar", "Nomostrar" as "Nomostrar", "Titulo" as "Titulolistado", "Imagen" as "Imagenlistado", "Fechaimpre" as "Imprimefechadeimpresion", "Horaimpre" as "Imprimehoradeimpresion", "Obs" as "Obs", "Cestilo" as "Estilo", "Mderecho" as "Margenderecho", "Mizquierdo" as "Margenizquierdo", "Mcabe" as "Margencabecera", "Mpie" as "Margenpie", "Orien" as "Orientacion", "Ddetalle" as "Diferenciardetalle", "Colorsombr" as "Colorparaelsombreado" from ZooLogic.PROPLIST where "Codigo" = <<"'" + this.FormatearTextoSql( lxProplistCodigo ) + "'">> and  PROPLIST.CODIGO != ''
			endtext
			use in select('c_PROPIEDADESLISTADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROPIEDADESLISTADOS', set( 'Datasession' ) )

			if reccount( 'c_PROPIEDADESLISTADOS' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxProplistCodigo as Variant
		llRetorno = .t.
		lxProplistCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.PROPLIST where "Codigo" = <<"'" + this.FormatearTextoSql( lxProplistCodigo ) + "'">> and  PROPLIST.CODIGO != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Nombre" as "Nombre", "Etiqueta" as "Etiqueta", "Longitud" as "Longitud", "Decimales" as "Decimalesreporte", "Calculo" as "Tipocalculo", "Mceros" as "Mostrarceros", "Pcrecer" as "Puedecrecer", "Orepetido" as "Ocultarepetido", "Lvertical" as "Lineavertical", "Wimagen" as "Anchoimagen", "Mimagen" as "Tamañooriginalimagen", "Himagen" as "Altoimagen", "Criteinit" as "Criteriodeinicializacion", "Diasatras" as "Diashaciaatras", "Vnidesde" as "Valornumericoinicial_desde", "Vnihasta" as "Valornumericoinicial_hasta", "Vcidesde" as "Valorcaracterinicial_desde", "Vcihasta" as "Valorcaracterinicial_hasta", "Vibooleano" as "Valorbooleanoinicial", "Visinobool" as "Valorsinoinicial", "Slectura" as "Sololectura", "Noinformar" as "Noinformar", "Nomostrar" as "Nomostrar", "Titulo" as "Titulolistado", "Imagen" as "Imagenlistado", "Fechaimpre" as "Imprimefechadeimpresion", "Horaimpre" as "Imprimehoradeimpresion", "Obs" as "Obs", "Cestilo" as "Estilo", "Mderecho" as "Margenderecho", "Mizquierdo" as "Margenizquierdo", "Mcabe" as "Margencabecera", "Mpie" as "Margenpie", "Orien" as "Orientacion", "Ddetalle" as "Diferenciardetalle", "Colorsombr" as "Colorparaelsombreado" from ZooLogic.PROPLIST where  PROPLIST.CODIGO != '' order by Codigo
			endtext
			use in select('c_PROPIEDADESLISTADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROPIEDADESLISTADOS', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Nombre" as "Nombre", "Etiqueta" as "Etiqueta", "Longitud" as "Longitud", "Decimales" as "Decimalesreporte", "Calculo" as "Tipocalculo", "Mceros" as "Mostrarceros", "Pcrecer" as "Puedecrecer", "Orepetido" as "Ocultarepetido", "Lvertical" as "Lineavertical", "Wimagen" as "Anchoimagen", "Mimagen" as "Tamañooriginalimagen", "Himagen" as "Altoimagen", "Criteinit" as "Criteriodeinicializacion", "Diasatras" as "Diashaciaatras", "Vnidesde" as "Valornumericoinicial_desde", "Vnihasta" as "Valornumericoinicial_hasta", "Vcidesde" as "Valorcaracterinicial_desde", "Vcihasta" as "Valorcaracterinicial_hasta", "Vibooleano" as "Valorbooleanoinicial", "Visinobool" as "Valorsinoinicial", "Slectura" as "Sololectura", "Noinformar" as "Noinformar", "Nomostrar" as "Nomostrar", "Titulo" as "Titulolistado", "Imagen" as "Imagenlistado", "Fechaimpre" as "Imprimefechadeimpresion", "Horaimpre" as "Imprimehoradeimpresion", "Obs" as "Obs", "Cestilo" as "Estilo", "Mderecho" as "Margenderecho", "Mizquierdo" as "Margenizquierdo", "Mcabe" as "Margencabecera", "Mpie" as "Margenpie", "Orien" as "Orientacion", "Ddetalle" as "Diferenciardetalle", "Colorsombr" as "Colorparaelsombreado" from ZooLogic.PROPLIST where  funciones.padr( Codigo, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PROPLIST.CODIGO != '' order by Codigo
			endtext
			use in select('c_PROPIEDADESLISTADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROPIEDADESLISTADOS', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Nombre" as "Nombre", "Etiqueta" as "Etiqueta", "Longitud" as "Longitud", "Decimales" as "Decimalesreporte", "Calculo" as "Tipocalculo", "Mceros" as "Mostrarceros", "Pcrecer" as "Puedecrecer", "Orepetido" as "Ocultarepetido", "Lvertical" as "Lineavertical", "Wimagen" as "Anchoimagen", "Mimagen" as "Tamañooriginalimagen", "Himagen" as "Altoimagen", "Criteinit" as "Criteriodeinicializacion", "Diasatras" as "Diashaciaatras", "Vnidesde" as "Valornumericoinicial_desde", "Vnihasta" as "Valornumericoinicial_hasta", "Vcidesde" as "Valorcaracterinicial_desde", "Vcihasta" as "Valorcaracterinicial_hasta", "Vibooleano" as "Valorbooleanoinicial", "Visinobool" as "Valorsinoinicial", "Slectura" as "Sololectura", "Noinformar" as "Noinformar", "Nomostrar" as "Nomostrar", "Titulo" as "Titulolistado", "Imagen" as "Imagenlistado", "Fechaimpre" as "Imprimefechadeimpresion", "Horaimpre" as "Imprimehoradeimpresion", "Obs" as "Obs", "Cestilo" as "Estilo", "Mderecho" as "Margenderecho", "Mizquierdo" as "Margenizquierdo", "Mcabe" as "Margencabecera", "Mpie" as "Margenpie", "Orien" as "Orientacion", "Ddetalle" as "Diferenciardetalle", "Colorsombr" as "Colorparaelsombreado" from ZooLogic.PROPLIST where  funciones.padr( Codigo, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PROPLIST.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_PROPIEDADESLISTADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROPIEDADESLISTADOS', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Nombre" as "Nombre", "Etiqueta" as "Etiqueta", "Longitud" as "Longitud", "Decimales" as "Decimalesreporte", "Calculo" as "Tipocalculo", "Mceros" as "Mostrarceros", "Pcrecer" as "Puedecrecer", "Orepetido" as "Ocultarepetido", "Lvertical" as "Lineavertical", "Wimagen" as "Anchoimagen", "Mimagen" as "Tamañooriginalimagen", "Himagen" as "Altoimagen", "Criteinit" as "Criteriodeinicializacion", "Diasatras" as "Diashaciaatras", "Vnidesde" as "Valornumericoinicial_desde", "Vnihasta" as "Valornumericoinicial_hasta", "Vcidesde" as "Valorcaracterinicial_desde", "Vcihasta" as "Valorcaracterinicial_hasta", "Vibooleano" as "Valorbooleanoinicial", "Visinobool" as "Valorsinoinicial", "Slectura" as "Sololectura", "Noinformar" as "Noinformar", "Nomostrar" as "Nomostrar", "Titulo" as "Titulolistado", "Imagen" as "Imagenlistado", "Fechaimpre" as "Imprimefechadeimpresion", "Horaimpre" as "Imprimehoradeimpresion", "Obs" as "Obs", "Cestilo" as "Estilo", "Mderecho" as "Margenderecho", "Mizquierdo" as "Margenizquierdo", "Mcabe" as "Margencabecera", "Mpie" as "Margenpie", "Orien" as "Orientacion", "Ddetalle" as "Diferenciardetalle", "Colorsombr" as "Colorparaelsombreado" from ZooLogic.PROPLIST where  PROPLIST.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_PROPIEDADESLISTADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROPIEDADESLISTADOS', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Faltafw,Fecexpo,Fmodifw,Fectrans,Haltafw,Horaexpo,Hmodifw,Horaimpo,Vmodifw,Zadsfw,Va" + ;
"ltafw,Umodifw,Smodifw,Ualtafw,Saltafw,Esttrans,Bdaltafw,Bdmodifw,Codigo,Nombre,Etiqueta,Longitud,Dec" + ;
"imales,Calculo,Mceros,Pcrecer,Orepetido,Lvertical,Wimagen,Mimagen,Himagen,Criteinit,Diasatras,Vnides" + ;
"de,Vnihasta,Vcidesde,Vcihasta,Vibooleano,Visinobool,Slectura,Noinformar,Nomostrar,Titulo,Imagen,Fech" + ;
"aimpre,Horaimpre,Obs,Cestilo,Mderecho,Mizquierdo,Mcabe,Mpie,Orien,Ddetalle,Colorsombr" + ;
" from ZooLogic.PROPLIST where  PROPLIST.CODIGO != '' and " + lcFiltro )
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
			local  lxProplistFecimpo, lxProplistFaltafw, lxProplistFecexpo, lxProplistFmodifw, lxProplistFectrans, lxProplistHaltafw, lxProplistHoraexpo, lxProplistHmodifw, lxProplistHoraimpo, lxProplistVmodifw, lxProplistZadsfw, lxProplistValtafw, lxProplistUmodifw, lxProplistSmodifw, lxProplistUaltafw, lxProplistSaltafw, lxProplistEsttrans, lxProplistBdaltafw, lxProplistBdmodifw, lxProplistCodigo, lxProplistNombre, lxProplistEtiqueta, lxProplistLongitud, lxProplistDecimales, lxProplistCalculo, lxProplistMceros, lxProplistPcrecer, lxProplistOrepetido, lxProplistLvertical, lxProplistWimagen, lxProplistMimagen, lxProplistHimagen, lxProplistCriteinit, lxProplistDiasatras, lxProplistVnidesde, lxProplistVnihasta, lxProplistVcidesde, lxProplistVcihasta, lxProplistVibooleano, lxProplistVisinobool, lxProplistSlectura, lxProplistNoinformar, lxProplistNomostrar, lxProplistTitulo, lxProplistImagen, lxProplistFechaimpre, lxProplistHoraimpre, lxProplistObs, lxProplistCestilo, lxProplistMderecho, lxProplistMizquierdo, lxProplistMcabe, lxProplistMpie, lxProplistOrien, lxProplistDdetalle, lxProplistColorsombr
				lxProplistFecimpo = ctod( '  /  /    ' )			lxProplistFaltafw = ctod( '  /  /    ' )			lxProplistFecexpo = ctod( '  /  /    ' )			lxProplistFmodifw = ctod( '  /  /    ' )			lxProplistFectrans = ctod( '  /  /    ' )			lxProplistHaltafw = []			lxProplistHoraexpo = []			lxProplistHmodifw = []			lxProplistHoraimpo = []			lxProplistVmodifw = []			lxProplistZadsfw = []			lxProplistValtafw = []			lxProplistUmodifw = []			lxProplistSmodifw = []			lxProplistUaltafw = []			lxProplistSaltafw = []			lxProplistEsttrans = []			lxProplistBdaltafw = []			lxProplistBdmodifw = []			lxProplistCodigo = []			lxProplistNombre = []			lxProplistEtiqueta = []			lxProplistLongitud = 0			lxProplistDecimales = 0			lxProplistCalculo = []			lxProplistMceros = .F.			lxProplistPcrecer = .F.			lxProplistOrepetido = .F.			lxProplistLvertical = .F.			lxProplistWimagen = 0			lxProplistMimagen = .F.			lxProplistHimagen = 0			lxProplistCriteinit = 0			lxProplistDiasatras = 0			lxProplistVnidesde = 0			lxProplistVnihasta = 0			lxProplistVcidesde = []			lxProplistVcihasta = []			lxProplistVibooleano = 0			lxProplistVisinobool = 0			lxProplistSlectura = .F.			lxProplistNoinformar = .F.			lxProplistNomostrar = .F.			lxProplistTitulo = []			lxProplistImagen = []			lxProplistFechaimpre = .F.			lxProplistHoraimpre = .F.			lxProplistObs = []			lxProplistCestilo = []			lxProplistMderecho = 0			lxProplistMizquierdo = 0			lxProplistMcabe = 0			lxProplistMpie = 0			lxProplistOrien = 0			lxProplistDdetalle = .F.			lxProplistColorsombr = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.PROPLIST where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'PROPLIST' + '_' + tcCampo
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
		lcWhere = " Where  PROPLIST.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Nombre" as "Nombre", "Etiqueta" as "Etiqueta", "Longitud" as "Longitud", "Decimales" as "Decimalesreporte", "Calculo" as "Tipocalculo", "Mceros" as "Mostrarceros", "Pcrecer" as "Puedecrecer", "Orepetido" as "Ocultarepetido", "Lvertical" as "Lineavertical", "Wimagen" as "Anchoimagen", "Mimagen" as "Tamañooriginalimagen", "Himagen" as "Altoimagen", "Criteinit" as "Criteriodeinicializacion", "Diasatras" as "Diashaciaatras", "Vnidesde" as "Valornumericoinicial_desde", "Vnihasta" as "Valornumericoinicial_hasta", "Vcidesde" as "Valorcaracterinicial_desde", "Vcihasta" as "Valorcaracterinicial_hasta", "Vibooleano" as "Valorbooleanoinicial", "Visinobool" as "Valorsinoinicial", "Slectura" as "Sololectura", "Noinformar" as "Noinformar", "Nomostrar" as "Nomostrar", "Titulo" as "Titulolistado", "Imagen" as "Imagenlistado", "Fechaimpre" as "Imprimefechadeimpresion", "Horaimpre" as "Imprimehoradeimpresion", "Obs" as "Obs", "Cestilo" as "Estilo", "Mderecho" as "Margenderecho", "Mizquierdo" as "Margenizquierdo", "Mcabe" as "Margencabecera", "Mpie" as "Margenpie", "Orien" as "Orientacion", "Ddetalle" as "Diferenciardetalle", "Colorsombr" as "Colorparaelsombreado"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PROPLIST', '', tnTope )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
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
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMBRE AS NOMBRE'
				Case lcAtributo == 'ETIQUETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ETIQUETA AS ETIQUETA'
				Case lcAtributo == 'LONGITUD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LONGITUD AS LONGITUD'
				Case lcAtributo == 'DECIMALESREPORTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DECIMALES AS DECIMALESREPORTE'
				Case lcAtributo == 'TIPOCALCULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CALCULO AS TIPOCALCULO'
				Case lcAtributo == 'MOSTRARCEROS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MCEROS AS MOSTRARCEROS'
				Case lcAtributo == 'PUEDECRECER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PCRECER AS PUEDECRECER'
				Case lcAtributo == 'OCULTAREPETIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OREPETIDO AS OCULTAREPETIDO'
				Case lcAtributo == 'LINEAVERTICAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LVERTICAL AS LINEAVERTICAL'
				Case lcAtributo == 'ANCHOIMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'WIMAGEN AS ANCHOIMAGEN'
				Case lcAtributo == 'TAMAÑOORIGINALIMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MIMAGEN AS TAMAÑOORIGINALIMAGEN'
				Case lcAtributo == 'ALTOIMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HIMAGEN AS ALTOIMAGEN'
				Case lcAtributo == 'CRITERIODEINICIALIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CRITEINIT AS CRITERIODEINICIALIZACION'
				Case lcAtributo == 'DIASHACIAATRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIASATRAS AS DIASHACIAATRAS'
				Case lcAtributo == 'VALORNUMERICOINICIAL_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VNIDESDE AS VALORNUMERICOINICIAL_DESDE'
				Case lcAtributo == 'VALORNUMERICOINICIAL_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VNIHASTA AS VALORNUMERICOINICIAL_HASTA'
				Case lcAtributo == 'VALORCARACTERINICIAL_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VCIDESDE AS VALORCARACTERINICIAL_DESDE'
				Case lcAtributo == 'VALORCARACTERINICIAL_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VCIHASTA AS VALORCARACTERINICIAL_HASTA'
				Case lcAtributo == 'VALORBOOLEANOINICIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VIBOOLEANO AS VALORBOOLEANOINICIAL'
				Case lcAtributo == 'VALORSINOINICIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VISINOBOOL AS VALORSINOINICIAL'
				Case lcAtributo == 'SOLOLECTURA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SLECTURA AS SOLOLECTURA'
				Case lcAtributo == 'NOINFORMAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOINFORMAR AS NOINFORMAR'
				Case lcAtributo == 'NOMOSTRAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMOSTRAR AS NOMOSTRAR'
				Case lcAtributo == 'TITULOLISTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TITULO AS TITULOLISTADO'
				Case lcAtributo == 'IMAGENLISTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMAGEN AS IMAGENLISTADO'
				Case lcAtributo == 'IMPRIMEFECHADEIMPRESION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAIMPRE AS IMPRIMEFECHADEIMPRESION'
				Case lcAtributo == 'IMPRIMEHORADEIMPRESION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPRE AS IMPRIMEHORADEIMPRESION'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'ESTILO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CESTILO AS ESTILO'
				Case lcAtributo == 'MARGENDERECHO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MDERECHO AS MARGENDERECHO'
				Case lcAtributo == 'MARGENIZQUIERDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MIZQUIERDO AS MARGENIZQUIERDO'
				Case lcAtributo == 'MARGENCABECERA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MCABE AS MARGENCABECERA'
				Case lcAtributo == 'MARGENPIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MPIE AS MARGENPIE'
				Case lcAtributo == 'ORIENTACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIEN AS ORIENTACION'
				Case lcAtributo == 'DIFERENCIARDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DDETALLE AS DIFERENCIARDETALLE'
				Case lcAtributo == 'COLORPARAELSOMBREADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLORSOMBR AS COLORPARAELSOMBREADO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
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
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'NOMBRE'
			Case upper( alltrim( tcAtributo ) ) == 'ETIQUETA'
				lcCampo = 'ETIQUETA'
			Case upper( alltrim( tcAtributo ) ) == 'LONGITUD'
				lcCampo = 'LONGITUD'
			Case upper( alltrim( tcAtributo ) ) == 'DECIMALESREPORTE'
				lcCampo = 'DECIMALES'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCALCULO'
				lcCampo = 'CALCULO'
			Case upper( alltrim( tcAtributo ) ) == 'MOSTRARCEROS'
				lcCampo = 'MCEROS'
			Case upper( alltrim( tcAtributo ) ) == 'PUEDECRECER'
				lcCampo = 'PCRECER'
			Case upper( alltrim( tcAtributo ) ) == 'OCULTAREPETIDO'
				lcCampo = 'OREPETIDO'
			Case upper( alltrim( tcAtributo ) ) == 'LINEAVERTICAL'
				lcCampo = 'LVERTICAL'
			Case upper( alltrim( tcAtributo ) ) == 'ANCHOIMAGEN'
				lcCampo = 'WIMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'TAMAÑOORIGINALIMAGEN'
				lcCampo = 'MIMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'ALTOIMAGEN'
				lcCampo = 'HIMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'CRITERIODEINICIALIZACION'
				lcCampo = 'CRITEINIT'
			Case upper( alltrim( tcAtributo ) ) == 'DIASHACIAATRAS'
				lcCampo = 'DIASATRAS'
			Case upper( alltrim( tcAtributo ) ) == 'VALORNUMERICOINICIAL_DESDE'
				lcCampo = 'VNIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'VALORNUMERICOINICIAL_HASTA'
				lcCampo = 'VNIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'VALORCARACTERINICIAL_DESDE'
				lcCampo = 'VCIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'VALORCARACTERINICIAL_HASTA'
				lcCampo = 'VCIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'VALORBOOLEANOINICIAL'
				lcCampo = 'VIBOOLEANO'
			Case upper( alltrim( tcAtributo ) ) == 'VALORSINOINICIAL'
				lcCampo = 'VISINOBOOL'
			Case upper( alltrim( tcAtributo ) ) == 'SOLOLECTURA'
				lcCampo = 'SLECTURA'
			Case upper( alltrim( tcAtributo ) ) == 'NOINFORMAR'
				lcCampo = 'NOINFORMAR'
			Case upper( alltrim( tcAtributo ) ) == 'NOMOSTRAR'
				lcCampo = 'NOMOSTRAR'
			Case upper( alltrim( tcAtributo ) ) == 'TITULOLISTADO'
				lcCampo = 'TITULO'
			Case upper( alltrim( tcAtributo ) ) == 'IMAGENLISTADO'
				lcCampo = 'IMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'IMPRIMEFECHADEIMPRESION'
				lcCampo = 'FECHAIMPRE'
			Case upper( alltrim( tcAtributo ) ) == 'IMPRIMEHORADEIMPRESION'
				lcCampo = 'HORAIMPRE'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'ESTILO'
				lcCampo = 'CESTILO'
			Case upper( alltrim( tcAtributo ) ) == 'MARGENDERECHO'
				lcCampo = 'MDERECHO'
			Case upper( alltrim( tcAtributo ) ) == 'MARGENIZQUIERDO'
				lcCampo = 'MIZQUIERDO'
			Case upper( alltrim( tcAtributo ) ) == 'MARGENCABECERA'
				lcCampo = 'MCABE'
			Case upper( alltrim( tcAtributo ) ) == 'MARGENPIE'
				lcCampo = 'MPIE'
			Case upper( alltrim( tcAtributo ) ) == 'ORIENTACION'
				lcCampo = 'ORIEN'
			Case upper( alltrim( tcAtributo ) ) == 'DIFERENCIARDETALLE'
				lcCampo = 'DDETALLE'
			Case upper( alltrim( tcAtributo ) ) == 'COLORPARAELSOMBREADO'
				lcCampo = 'COLORSOMBR'
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
			local  lxProplistFecimpo, lxProplistFaltafw, lxProplistFecexpo, lxProplistFmodifw, lxProplistFectrans, lxProplistHaltafw, lxProplistHoraexpo, lxProplistHmodifw, lxProplistHoraimpo, lxProplistVmodifw, lxProplistZadsfw, lxProplistValtafw, lxProplistUmodifw, lxProplistSmodifw, lxProplistUaltafw, lxProplistSaltafw, lxProplistEsttrans, lxProplistBdaltafw, lxProplistBdmodifw, lxProplistCodigo, lxProplistNombre, lxProplistEtiqueta, lxProplistLongitud, lxProplistDecimales, lxProplistCalculo, lxProplistMceros, lxProplistPcrecer, lxProplistOrepetido, lxProplistLvertical, lxProplistWimagen, lxProplistMimagen, lxProplistHimagen, lxProplistCriteinit, lxProplistDiasatras, lxProplistVnidesde, lxProplistVnihasta, lxProplistVcidesde, lxProplistVcihasta, lxProplistVibooleano, lxProplistVisinobool, lxProplistSlectura, lxProplistNoinformar, lxProplistNomostrar, lxProplistTitulo, lxProplistImagen, lxProplistFechaimpre, lxProplistHoraimpre, lxProplistObs, lxProplistCestilo, lxProplistMderecho, lxProplistMizquierdo, lxProplistMcabe, lxProplistMpie, lxProplistOrien, lxProplistDdetalle, lxProplistColorsombr
				lxProplistFecimpo =  .Fechaimpo			lxProplistFaltafw =  .Fechaaltafw			lxProplistFecexpo =  .Fechaexpo			lxProplistFmodifw =  .Fechamodificacionfw			lxProplistFectrans =  .Fechatransferencia			lxProplistHaltafw =  .Horaaltafw			lxProplistHoraexpo =  .Horaexpo			lxProplistHmodifw =  .Horamodificacionfw			lxProplistHoraimpo =  .Horaimpo			lxProplistVmodifw =  .Versionmodificacionfw			lxProplistZadsfw =  .Zadsfw			lxProplistValtafw =  .Versionaltafw			lxProplistUmodifw =  .Usuariomodificacionfw			lxProplistSmodifw =  .Seriemodificacionfw			lxProplistUaltafw =  .Usuarioaltafw			lxProplistSaltafw =  .Seriealtafw			lxProplistEsttrans =  .Estadotransferencia			lxProplistBdaltafw =  .Basededatosaltafw			lxProplistBdmodifw =  .Basededatosmodificacionfw			lxProplistCodigo =  .Codigo			lxProplistNombre =  .Nombre			lxProplistEtiqueta =  .Etiqueta			lxProplistLongitud =  .Longitud			lxProplistDecimales =  .Decimalesreporte			lxProplistCalculo =  .Tipocalculo			lxProplistMceros =  .Mostrarceros			lxProplistPcrecer =  .Puedecrecer			lxProplistOrepetido =  .Ocultarepetido			lxProplistLvertical =  .Lineavertical			lxProplistWimagen =  .Anchoimagen			lxProplistMimagen =  .Tamañooriginalimagen			lxProplistHimagen =  .Altoimagen			lxProplistCriteinit =  .Criteriodeinicializacion			lxProplistDiasatras =  .Diashaciaatras			lxProplistVnidesde =  .Valornumericoinicial_desde			lxProplistVnihasta =  .Valornumericoinicial_hasta			lxProplistVcidesde =  .Valorcaracterinicial_desde			lxProplistVcihasta =  .Valorcaracterinicial_hasta			lxProplistVibooleano =  .Valorbooleanoinicial			lxProplistVisinobool =  .Valorsinoinicial			lxProplistSlectura =  .Sololectura			lxProplistNoinformar =  .Noinformar			lxProplistNomostrar =  .Nomostrar			lxProplistTitulo =  .Titulolistado			lxProplistImagen =  .Imagenlistado			lxProplistFechaimpre =  .Imprimefechadeimpresion			lxProplistHoraimpre =  .Imprimehoradeimpresion			lxProplistObs =  .Obs			lxProplistCestilo =  upper( .Estilo_PK ) 			lxProplistMderecho =  .Margenderecho			lxProplistMizquierdo =  .Margenizquierdo			lxProplistMcabe =  .Margencabecera			lxProplistMpie =  .Margenpie			lxProplistOrien =  .Orientacion			lxProplistDdetalle =  .Diferenciardetalle			lxProplistColorsombr =  .Colorparaelsombreado
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.PROPLIST ( "Fecimpo","Faltafw","Fecexpo","Fmodifw","Fectrans","Haltafw","Horaexpo","Hmodifw","Horaimpo","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Saltafw","Esttrans","Bdaltafw","Bdmodifw","Codigo","Nombre","Etiqueta","Longitud","Decimales","Calculo","Mceros","Pcrecer","Orepetido","Lvertical","Wimagen","Mimagen","Himagen","Criteinit","Diasatras","Vnidesde","Vnihasta","Vcidesde","Vcihasta","Vibooleano","Visinobool","Slectura","Noinformar","Nomostrar","Titulo","Imagen","Fechaimpre","Horaimpre","Obs","Cestilo","Mderecho","Mizquierdo","Mcabe","Mpie","Orien","Ddetalle","Colorsombr" ) values ( <<"'" + this.ConvertirDateSql( lxProplistFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProplistFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProplistFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProplistFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProplistFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistNombre ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistEtiqueta ) + "'" >>, <<lxProplistLongitud >>, <<lxProplistDecimales >>, <<"'" + this.FormatearTextoSql( lxProplistCalculo ) + "'" >>, <<iif( lxProplistMceros, 1, 0 ) >>, <<iif( lxProplistPcrecer, 1, 0 ) >>, <<iif( lxProplistOrepetido, 1, 0 ) >>, <<iif( lxProplistLvertical, 1, 0 ) >>, <<lxProplistWimagen >>, <<iif( lxProplistMimagen, 1, 0 ) >>, <<lxProplistHimagen >>, <<lxProplistCriteinit >>, <<lxProplistDiasatras >>, <<lxProplistVnidesde >>, <<lxProplistVnihasta >>, <<"'" + this.FormatearTextoSql( lxProplistVcidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistVcihasta ) + "'" >>, <<lxProplistVibooleano >>, <<lxProplistVisinobool >>, <<iif( lxProplistSlectura, 1, 0 ) >>, <<iif( lxProplistNoinformar, 1, 0 ) >>, <<iif( lxProplistNomostrar, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxProplistTitulo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistImagen ) + "'" >>, <<iif( lxProplistFechaimpre, 1, 0 ) >>, <<iif( lxProplistHoraimpre, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxProplistObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProplistCestilo ) + "'" >>, <<lxProplistMderecho >>, <<lxProplistMizquierdo >>, <<lxProplistMcabe >>, <<lxProplistMpie >>, <<lxProplistOrien >>, <<iif( lxProplistDdetalle, 1, 0 ) >>, <<lxProplistColorsombr >> )
		endtext
		loColeccion.cTabla = 'PROPLIST' 
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
			local  lxProplistFecimpo, lxProplistFaltafw, lxProplistFecexpo, lxProplistFmodifw, lxProplistFectrans, lxProplistHaltafw, lxProplistHoraexpo, lxProplistHmodifw, lxProplistHoraimpo, lxProplistVmodifw, lxProplistZadsfw, lxProplistValtafw, lxProplistUmodifw, lxProplistSmodifw, lxProplistUaltafw, lxProplistSaltafw, lxProplistEsttrans, lxProplistBdaltafw, lxProplistBdmodifw, lxProplistCodigo, lxProplistNombre, lxProplistEtiqueta, lxProplistLongitud, lxProplistDecimales, lxProplistCalculo, lxProplistMceros, lxProplistPcrecer, lxProplistOrepetido, lxProplistLvertical, lxProplistWimagen, lxProplistMimagen, lxProplistHimagen, lxProplistCriteinit, lxProplistDiasatras, lxProplistVnidesde, lxProplistVnihasta, lxProplistVcidesde, lxProplistVcihasta, lxProplistVibooleano, lxProplistVisinobool, lxProplistSlectura, lxProplistNoinformar, lxProplistNomostrar, lxProplistTitulo, lxProplistImagen, lxProplistFechaimpre, lxProplistHoraimpre, lxProplistObs, lxProplistCestilo, lxProplistMderecho, lxProplistMizquierdo, lxProplistMcabe, lxProplistMpie, lxProplistOrien, lxProplistDdetalle, lxProplistColorsombr
				lxProplistFecimpo =  .Fechaimpo			lxProplistFaltafw =  .Fechaaltafw			lxProplistFecexpo =  .Fechaexpo			lxProplistFmodifw =  .Fechamodificacionfw			lxProplistFectrans =  .Fechatransferencia			lxProplistHaltafw =  .Horaaltafw			lxProplistHoraexpo =  .Horaexpo			lxProplistHmodifw =  .Horamodificacionfw			lxProplistHoraimpo =  .Horaimpo			lxProplistVmodifw =  .Versionmodificacionfw			lxProplistZadsfw =  .Zadsfw			lxProplistValtafw =  .Versionaltafw			lxProplistUmodifw =  .Usuariomodificacionfw			lxProplistSmodifw =  .Seriemodificacionfw			lxProplistUaltafw =  .Usuarioaltafw			lxProplistSaltafw =  .Seriealtafw			lxProplistEsttrans =  .Estadotransferencia			lxProplistBdaltafw =  .Basededatosaltafw			lxProplistBdmodifw =  .Basededatosmodificacionfw			lxProplistCodigo =  .Codigo			lxProplistNombre =  .Nombre			lxProplistEtiqueta =  .Etiqueta			lxProplistLongitud =  .Longitud			lxProplistDecimales =  .Decimalesreporte			lxProplistCalculo =  .Tipocalculo			lxProplistMceros =  .Mostrarceros			lxProplistPcrecer =  .Puedecrecer			lxProplistOrepetido =  .Ocultarepetido			lxProplistLvertical =  .Lineavertical			lxProplistWimagen =  .Anchoimagen			lxProplistMimagen =  .Tamañooriginalimagen			lxProplistHimagen =  .Altoimagen			lxProplistCriteinit =  .Criteriodeinicializacion			lxProplistDiasatras =  .Diashaciaatras			lxProplistVnidesde =  .Valornumericoinicial_desde			lxProplistVnihasta =  .Valornumericoinicial_hasta			lxProplistVcidesde =  .Valorcaracterinicial_desde			lxProplistVcihasta =  .Valorcaracterinicial_hasta			lxProplistVibooleano =  .Valorbooleanoinicial			lxProplistVisinobool =  .Valorsinoinicial			lxProplistSlectura =  .Sololectura			lxProplistNoinformar =  .Noinformar			lxProplistNomostrar =  .Nomostrar			lxProplistTitulo =  .Titulolistado			lxProplistImagen =  .Imagenlistado			lxProplistFechaimpre =  .Imprimefechadeimpresion			lxProplistHoraimpre =  .Imprimehoradeimpresion			lxProplistObs =  .Obs			lxProplistCestilo =  upper( .Estilo_PK ) 			lxProplistMderecho =  .Margenderecho			lxProplistMizquierdo =  .Margenizquierdo			lxProplistMcabe =  .Margencabecera			lxProplistMpie =  .Margenpie			lxProplistOrien =  .Orientacion			lxProplistDdetalle =  .Diferenciardetalle			lxProplistColorsombr =  .Colorparaelsombreado
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  PROPLIST.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.PROPLIST set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxProplistFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxProplistFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxProplistFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxProplistFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxProplistFectrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxProplistHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxProplistHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxProplistHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxProplistHoraimpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxProplistVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxProplistZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxProplistValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxProplistUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxProplistSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxProplistUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxProplistSaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxProplistEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxProplistBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxProplistBdmodifw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxProplistCodigo ) + "'">>, "Nombre" = <<"'" + this.FormatearTextoSql( lxProplistNombre ) + "'">>, "Etiqueta" = <<"'" + this.FormatearTextoSql( lxProplistEtiqueta ) + "'">>, "Longitud" = <<lxProplistLongitud>>, "Decimales" = <<lxProplistDecimales>>, "Calculo" = <<"'" + this.FormatearTextoSql( lxProplistCalculo ) + "'">>, "Mceros" = <<iif( lxProplistMceros, 1, 0 )>>, "Pcrecer" = <<iif( lxProplistPcrecer, 1, 0 )>>, "Orepetido" = <<iif( lxProplistOrepetido, 1, 0 )>>, "Lvertical" = <<iif( lxProplistLvertical, 1, 0 )>>, "Wimagen" = <<lxProplistWimagen>>, "Mimagen" = <<iif( lxProplistMimagen, 1, 0 )>>, "Himagen" = <<lxProplistHimagen>>, "Criteinit" = <<lxProplistCriteinit>>, "Diasatras" = <<lxProplistDiasatras>>, "Vnidesde" = <<lxProplistVnidesde>>, "Vnihasta" = <<lxProplistVnihasta>>, "Vcidesde" = <<"'" + this.FormatearTextoSql( lxProplistVcidesde ) + "'">>, "Vcihasta" = <<"'" + this.FormatearTextoSql( lxProplistVcihasta ) + "'">>, "Vibooleano" = <<lxProplistVibooleano>>, "Visinobool" = <<lxProplistVisinobool>>, "Slectura" = <<iif( lxProplistSlectura, 1, 0 )>>, "Noinformar" = <<iif( lxProplistNoinformar, 1, 0 )>>, "Nomostrar" = <<iif( lxProplistNomostrar, 1, 0 )>>, "Titulo" = <<"'" + this.FormatearTextoSql( lxProplistTitulo ) + "'">>, "Imagen" = <<"'" + this.FormatearTextoSql( lxProplistImagen ) + "'">>, "Fechaimpre" = <<iif( lxProplistFechaimpre, 1, 0 )>>, "Horaimpre" = <<iif( lxProplistHoraimpre, 1, 0 )>>, "Obs" = <<"'" + this.FormatearTextoSql( lxProplistObs ) + "'">>, "Cestilo" = <<"'" + this.FormatearTextoSql( lxProplistCestilo ) + "'">>, "Mderecho" = <<lxProplistMderecho>>, "Mizquierdo" = <<lxProplistMizquierdo>>, "Mcabe" = <<lxProplistMcabe>>, "Mpie" = <<lxProplistMpie>>, "Orien" = <<lxProplistOrien>>, "Ddetalle" = <<iif( lxProplistDdetalle, 1, 0 )>>, "Colorsombr" = <<lxProplistColorsombr>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'PROPLIST' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  PROPLIST.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.PROPLIST where ' + lcFiltro )
			loColeccion.cTabla = 'PROPLIST' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.PROPLIST where  PROPLIST.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.PROPLIST where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  PROPLIST.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PROPIEDADESLISTADOS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.PROPLIST Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.PROPLIST set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Nombre = ] + "'" + this.FormatearTextoSql( &lcCursor..Nombre ) + "'"+ [, Etiqueta = ] + "'" + this.FormatearTextoSql( &lcCursor..Etiqueta ) + "'"+ [, Longitud = ] + transform( &lcCursor..Longitud )+ [, Decimales = ] + transform( &lcCursor..Decimales )+ [, Calculo = ] + "'" + this.FormatearTextoSql( &lcCursor..Calculo ) + "'"+ [, Mceros = ] + Transform( iif( &lcCursor..Mceros, 1, 0 ))+ [, PCrecer = ] + Transform( iif( &lcCursor..PCrecer, 1, 0 ))+ [, ORepetido = ] + Transform( iif( &lcCursor..ORepetido, 1, 0 ))+ [, LVertical = ] + Transform( iif( &lcCursor..LVertical, 1, 0 ))+ [, WImagen = ] + transform( &lcCursor..WImagen )+ [, MImagen = ] + Transform( iif( &lcCursor..MImagen, 1, 0 ))+ [, HImagen = ] + transform( &lcCursor..HImagen )+ [, CriteInit = ] + transform( &lcCursor..CriteInit )+ [, DiasAtras = ] + transform( &lcCursor..DiasAtras )+ [, VNIDesde = ] + transform( &lcCursor..VNIDesde )+ [, VNIHasta = ] + transform( &lcCursor..VNIHasta )+ [, VCIDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..VCIDesde ) + "'"+ [, VCIHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..VCIHasta ) + "'"+ [, VIBooleano = ] + transform( &lcCursor..VIBooleano )+ [, VISiNoBool = ] + transform( &lcCursor..VISiNoBool )+ [, SLectura = ] + Transform( iif( &lcCursor..SLectura, 1, 0 ))+ [, NoInformar = ] + Transform( iif( &lcCursor..NoInformar, 1, 0 ))+ [, NoMostrar = ] + Transform( iif( &lcCursor..NoMostrar, 1, 0 ))+ [, titulo = ] + "'" + this.FormatearTextoSql( &lcCursor..titulo ) + "'"+ [, Imagen = ] + "'" + this.FormatearTextoSql( &lcCursor..Imagen ) + "'"+ [, fechaimpre = ] + Transform( iif( &lcCursor..fechaimpre, 1, 0 ))+ [, horaimpre = ] + Transform( iif( &lcCursor..horaimpre, 1, 0 ))+ [, OBS = ] + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'"+ [, cEstilo = ] + "'" + this.FormatearTextoSql( &lcCursor..cEstilo ) + "'"+ [, MDerecho = ] + transform( &lcCursor..MDerecho )+ [, MIzquierdo = ] + transform( &lcCursor..MIzquierdo )+ [, MCabe = ] + transform( &lcCursor..MCabe )+ [, Mpie = ] + transform( &lcCursor..Mpie )+ [, Orien = ] + transform( &lcCursor..Orien )+ [, DDetalle = ] + Transform( iif( &lcCursor..DDetalle, 1, 0 ))+ [, ColorSombr = ] + transform( &lcCursor..ColorSombr ) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FALTAFW, FECEXPO, FMODIFW, FECTRANS, HALTAFW, HORAEXPO, HMODIFW, HORAIMPO, VMODIFW, ZADSFW, VALTAFW, UMODIFW, SMODIFW, UALTAFW, SALTAFW, ESTTRANS, BDALTAFW, BDMODIFW, Codigo, Nombre, Etiqueta, Longitud, Decimales, Calculo, Mceros, PCrecer, ORepetido, LVertical, WImagen, MImagen, HImagen, CriteInit, DiasAtras, VNIDesde, VNIHasta, VCIDesde, VCIHasta, VIBooleano, VISiNoBool, SLectura, NoInformar, NoMostrar, titulo, Imagen, fechaimpre, horaimpre, OBS, cEstilo, MDerecho, MIzquierdo, MCabe, Mpie, Orien, DDetalle, ColorSombr
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Nombre ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Etiqueta ) + "'" + ',' + transform( &lcCursor..Longitud ) + ',' + transform( &lcCursor..Decimales ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Calculo ) + "'" + ',' + Transform( iif( &lcCursor..Mceros, 1, 0 )) + ',' + Transform( iif( &lcCursor..PCrecer, 1, 0 )) + ',' + Transform( iif( &lcCursor..ORepetido, 1, 0 )) + ',' + Transform( iif( &lcCursor..LVertical, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..WImagen ) + ',' + Transform( iif( &lcCursor..MImagen, 1, 0 )) + ',' + transform( &lcCursor..HImagen ) + ',' + transform( &lcCursor..CriteInit ) + ',' + transform( &lcCursor..DiasAtras ) + ',' + transform( &lcCursor..VNIDesde ) + ',' + transform( &lcCursor..VNIHasta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..VCIDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VCIHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..VIBooleano ) + ',' + transform( &lcCursor..VISiNoBool ) + ',' + Transform( iif( &lcCursor..SLectura, 1, 0 )) + ',' + Transform( iif( &lcCursor..NoInformar, 1, 0 )) + ',' + Transform( iif( &lcCursor..NoMostrar, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..titulo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Imagen ) + "'" + ',' + Transform( iif( &lcCursor..fechaimpre, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..horaimpre, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cEstilo ) + "'" + ',' + transform( &lcCursor..MDerecho ) + ',' + transform( &lcCursor..MIzquierdo ) + ',' + transform( &lcCursor..MCabe ) + ',' + transform( &lcCursor..Mpie ) + ',' + transform( &lcCursor..Orien ) + ',' + Transform( iif( &lcCursor..DDetalle, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..ColorSombr )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.PROPLIST ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PROPIEDADESLISTADOS'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (10) , Orden N(16), texto C(80))
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
			Case  lcAlias == lcPrefijo + 'PROPIEDADESLISTADOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PROPIEDADESLISTADOS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PROPIEDADESLISTADOS_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_PROPLIST')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'PROPIEDADESLISTADOS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad PROPIEDADESLISTADOS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PROPIEDADESLISTADOS'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PROPIEDADESLISTADOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PROPLIST') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PROPLIST
Create Table ZooLogic.TablaTrabajo_PROPLIST ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
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
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"codigo" char( 10 )  null, 
"nombre" char( 70 )  null, 
"etiqueta" char( 40 )  null, 
"longitud" numeric( 3, 0 )  null, 
"decimales" numeric( 2, 0 )  null, 
"calculo" char( 20 )  null, 
"mceros" bit  null, 
"pcrecer" bit  null, 
"orepetido" bit  null, 
"lvertical" bit  null, 
"wimagen" numeric( 4, 2 )  null, 
"mimagen" bit  null, 
"himagen" numeric( 4, 2 )  null, 
"criteinit" numeric( 1, 0 )  null, 
"diasatras" numeric( 4, 0 )  null, 
"vnidesde" numeric( 17, 4 )  null, 
"vnihasta" numeric( 17, 4 )  null, 
"vcidesde" char( 250 )  null, 
"vcihasta" char( 250 )  null, 
"vibooleano" numeric( 2, 0 )  null, 
"visinobool" numeric( 2, 0 )  null, 
"slectura" bit  null, 
"noinformar" bit  null, 
"nomostrar" bit  null, 
"titulo" char( 250 )  null, 
"imagen" char( 250 )  null, 
"fechaimpre" bit  null, 
"horaimpre" bit  null, 
"obs" varchar(max)  null, 
"cestilo" char( 10 )  null, 
"mderecho" numeric( 3, 0 )  null, 
"mizquierdo" numeric( 3, 0 )  null, 
"mcabe" numeric( 3, 0 )  null, 
"mpie" numeric( 3, 0 )  null, 
"orien" numeric( 1, 0 )  null, 
"ddetalle" bit  null, 
"colorsombr" numeric( 9, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_PROPLIST' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_PROPLIST' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PROPIEDADESLISTADOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
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
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('nombre','nombre')
			.AgregarMapeo('etiqueta','etiqueta')
			.AgregarMapeo('longitud','longitud')
			.AgregarMapeo('decimales','decimales')
			.AgregarMapeo('calculo','calculo')
			.AgregarMapeo('mceros','mceros')
			.AgregarMapeo('pcrecer','pcrecer')
			.AgregarMapeo('orepetido','orepetido')
			.AgregarMapeo('lvertical','lvertical')
			.AgregarMapeo('wimagen','wimagen')
			.AgregarMapeo('mimagen','mimagen')
			.AgregarMapeo('himagen','himagen')
			.AgregarMapeo('criteinit','criteinit')
			.AgregarMapeo('diasatras','diasatras')
			.AgregarMapeo('vnidesde','vnidesde')
			.AgregarMapeo('vnihasta','vnihasta')
			.AgregarMapeo('vcidesde','vcidesde')
			.AgregarMapeo('vcihasta','vcihasta')
			.AgregarMapeo('vibooleano','vibooleano')
			.AgregarMapeo('visinobool','visinobool')
			.AgregarMapeo('slectura','slectura')
			.AgregarMapeo('noinformar','noinformar')
			.AgregarMapeo('nomostrar','nomostrar')
			.AgregarMapeo('titulo','titulo')
			.AgregarMapeo('imagen','imagen')
			.AgregarMapeo('fechaimpre','fechaimpre')
			.AgregarMapeo('horaimpre','horaimpre')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('cestilo','cestilo')
			.AgregarMapeo('mderecho','mderecho')
			.AgregarMapeo('mizquierdo','mizquierdo')
			.AgregarMapeo('mcabe','mcabe')
			.AgregarMapeo('mpie','mpie')
			.AgregarMapeo('orien','orien')
			.AgregarMapeo('ddetalle','ddetalle')
			.AgregarMapeo('colorsombr','colorsombr')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_PROPLIST'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.NOMBRE = isnull( d.NOMBRE, t.NOMBRE ),t.ETIQUETA = isnull( d.ETIQUETA, t.ETIQUETA ),t.LONGITUD = isnull( d.LONGITUD, t.LONGITUD ),t.DECIMALES = isnull( d.DECIMALES, t.DECIMALES ),t.CALCULO = isnull( d.CALCULO, t.CALCULO ),t.MCEROS = isnull( d.MCEROS, t.MCEROS ),t.PCRECER = isnull( d.PCRECER, t.PCRECER ),t.OREPETIDO = isnull( d.OREPETIDO, t.OREPETIDO ),t.LVERTICAL = isnull( d.LVERTICAL, t.LVERTICAL ),t.WIMAGEN = isnull( d.WIMAGEN, t.WIMAGEN ),t.MIMAGEN = isnull( d.MIMAGEN, t.MIMAGEN ),t.HIMAGEN = isnull( d.HIMAGEN, t.HIMAGEN ),t.CRITEINIT = isnull( d.CRITEINIT, t.CRITEINIT ),t.DIASATRAS = isnull( d.DIASATRAS, t.DIASATRAS ),t.VNIDESDE = isnull( d.VNIDESDE, t.VNIDESDE ),t.VNIHASTA = isnull( d.VNIHASTA, t.VNIHASTA ),t.VCIDESDE = isnull( d.VCIDESDE, t.VCIDESDE ),t.VCIHASTA = isnull( d.VCIHASTA, t.VCIHASTA ),t.VIBOOLEANO = isnull( d.VIBOOLEANO, t.VIBOOLEANO ),t.VISINOBOOL = isnull( d.VISINOBOOL, t.VISINOBOOL ),t.SLECTURA = isnull( d.SLECTURA, t.SLECTURA ),t.NOINFORMAR = isnull( d.NOINFORMAR, t.NOINFORMAR ),t.NOMOSTRAR = isnull( d.NOMOSTRAR, t.NOMOSTRAR ),t.TITULO = isnull( d.TITULO, t.TITULO ),t.IMAGEN = isnull( d.IMAGEN, t.IMAGEN ),t.FECHAIMPRE = isnull( d.FECHAIMPRE, t.FECHAIMPRE ),t.HORAIMPRE = isnull( d.HORAIMPRE, t.HORAIMPRE ),t.OBS = isnull( d.OBS, t.OBS ),t.CESTILO = isnull( d.CESTILO, t.CESTILO ),t.MDERECHO = isnull( d.MDERECHO, t.MDERECHO ),t.MIZQUIERDO = isnull( d.MIZQUIERDO, t.MIZQUIERDO ),t.MCABE = isnull( d.MCABE, t.MCABE ),t.MPIE = isnull( d.MPIE, t.MPIE ),t.ORIEN = isnull( d.ORIEN, t.ORIEN ),t.DDETALLE = isnull( d.DDETALLE, t.DDETALLE ),t.COLORSOMBR = isnull( d.COLORSOMBR, t.COLORSOMBR )
					from ZooLogic.PROPLIST t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.PROPLIST(Fecimpo,Faltafw,Fecexpo,Fmodifw,Fectrans,Haltafw,Horaexpo,Hmodifw,Horaimpo,Vmodifw,Zadsfw,Valtafw,Umodifw,Smodifw,Ualtafw,Saltafw,Esttrans,Bdaltafw,Bdmodifw,Codigo,Nombre,Etiqueta,Longitud,Decimales,Calculo,Mceros,Pcrecer,Orepetido,Lvertical,Wimagen,Mimagen,Himagen,Criteinit,Diasatras,Vnidesde,Vnihasta,Vcidesde,Vcihasta,Vibooleano,Visinobool,Slectura,Noinformar,Nomostrar,Titulo,Imagen,Fechaimpre,Horaimpre,Obs,Cestilo,Mderecho,Mizquierdo,Mcabe,Mpie,Orien,Ddetalle,Colorsombr)
					Select isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.CODIGO,''),isnull( d.NOMBRE,''),isnull( d.ETIQUETA,''),isnull( d.LONGITUD,0),isnull( d.DECIMALES,0),isnull( d.CALCULO,''),isnull( d.MCEROS,0),isnull( d.PCRECER,0),isnull( d.OREPETIDO,0),isnull( d.LVERTICAL,0),isnull( d.WIMAGEN,0),isnull( d.MIMAGEN,0),isnull( d.HIMAGEN,0),isnull( d.CRITEINIT,0),isnull( d.DIASATRAS,0),isnull( d.VNIDESDE,0),isnull( d.VNIHASTA,0),isnull( d.VCIDESDE,''),isnull( d.VCIHASTA,''),isnull( d.VIBOOLEANO,0),isnull( d.VISINOBOOL,0),isnull( d.SLECTURA,0),isnull( d.NOINFORMAR,0),isnull( d.NOMOSTRAR,0),isnull( d.TITULO,''),isnull( d.IMAGEN,''),isnull( d.FECHAIMPRE,0),isnull( d.HORAIMPRE,0),isnull( d.OBS,''),isnull( d.CESTILO,''),isnull( d.MDERECHO,0),isnull( d.MIZQUIERDO,0),isnull( d.MCABE,0),isnull( d.MPIE,0),isnull( d.ORIEN,0),isnull( d.DDETALLE,0),isnull( d.COLORSOMBR,0)
						From deleted d left join ZooLogic.PROPLIST pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PROPLIST') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PROPLIST
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_PROPIEDADESLISTADOS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROPIEDADESLISTADOS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROPIEDADESLISTADOS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROPIEDADESLISTADOS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROPIEDADESLISTADOS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROPIEDADESLISTADOS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_PROPIEDADESLISTADOS.Horaaltafw, [] )
					.Horaexpo = nvl( c_PROPIEDADESLISTADOS.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_PROPIEDADESLISTADOS.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_PROPIEDADESLISTADOS.Horaimpo, [] )
					.Versionmodificacionfw = nvl( c_PROPIEDADESLISTADOS.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_PROPIEDADESLISTADOS.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_PROPIEDADESLISTADOS.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_PROPIEDADESLISTADOS.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_PROPIEDADESLISTADOS.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_PROPIEDADESLISTADOS.Seriealtafw, [] )
					.Estadotransferencia = nvl( c_PROPIEDADESLISTADOS.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_PROPIEDADESLISTADOS.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_PROPIEDADESLISTADOS.Basededatosmodificacionfw, [] )
					.Codigo = nvl( c_PROPIEDADESLISTADOS.Codigo, [] )
					.Nombre = nvl( c_PROPIEDADESLISTADOS.Nombre, [] )
					.Etiqueta = nvl( c_PROPIEDADESLISTADOS.Etiqueta, [] )
					.Longitud = nvl( c_PROPIEDADESLISTADOS.Longitud, 0 )
					.Decimalesreporte = nvl( c_PROPIEDADESLISTADOS.Decimalesreporte, 0 )
					.Tipocalculo = nvl( c_PROPIEDADESLISTADOS.Tipocalculo, [] )
					.Mostrarceros = nvl( c_PROPIEDADESLISTADOS.Mostrarceros, .F. )
					.Puedecrecer = nvl( c_PROPIEDADESLISTADOS.Puedecrecer, .F. )
					.Ocultarepetido = nvl( c_PROPIEDADESLISTADOS.Ocultarepetido, .F. )
					.Lineavertical = nvl( c_PROPIEDADESLISTADOS.Lineavertical, .F. )
					.Anchoimagen = nvl( c_PROPIEDADESLISTADOS.Anchoimagen, 0 )
					.Tamañooriginalimagen = nvl( c_PROPIEDADESLISTADOS.Tamañooriginalimagen, .F. )
					.Altoimagen = nvl( c_PROPIEDADESLISTADOS.Altoimagen, 0 )
					.Criteriodeinicializacion = nvl( c_PROPIEDADESLISTADOS.Criteriodeinicializacion, 0 )
					.Diashaciaatras = nvl( c_PROPIEDADESLISTADOS.Diashaciaatras, 0 )
					.Valornumericoinicial_desde = nvl( c_PROPIEDADESLISTADOS.Valornumericoinicial_desde, 0 )
					.Valornumericoinicial_hasta = nvl( c_PROPIEDADESLISTADOS.Valornumericoinicial_hasta, 0 )
					.Valorcaracterinicial_desde = nvl( c_PROPIEDADESLISTADOS.Valorcaracterinicial_desde, [] )
					.Valorcaracterinicial_hasta = nvl( c_PROPIEDADESLISTADOS.Valorcaracterinicial_hasta, [] )
					.Valorbooleanoinicial = nvl( c_PROPIEDADESLISTADOS.Valorbooleanoinicial, 0 )
					.Valorsinoinicial = nvl( c_PROPIEDADESLISTADOS.Valorsinoinicial, 0 )
					.Sololectura = nvl( c_PROPIEDADESLISTADOS.Sololectura, .F. )
					.Noinformar = nvl( c_PROPIEDADESLISTADOS.Noinformar, .F. )
					.Nomostrar = nvl( c_PROPIEDADESLISTADOS.Nomostrar, .F. )
					.Titulolistado = nvl( c_PROPIEDADESLISTADOS.Titulolistado, [] )
					.Imagenlistado = nvl( c_PROPIEDADESLISTADOS.Imagenlistado, [] )
					.Imprimefechadeimpresion = nvl( c_PROPIEDADESLISTADOS.Imprimefechadeimpresion, .F. )
					.Imprimehoradeimpresion = nvl( c_PROPIEDADESLISTADOS.Imprimehoradeimpresion, .F. )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Estilo_PK =  nvl( c_PROPIEDADESLISTADOS.Estilo, [] )
					.Margenderecho = nvl( c_PROPIEDADESLISTADOS.Margenderecho, 0 )
					.Margenizquierdo = nvl( c_PROPIEDADESLISTADOS.Margenizquierdo, 0 )
					.Margencabecera = nvl( c_PROPIEDADESLISTADOS.Margencabecera, 0 )
					.Margenpie = nvl( c_PROPIEDADESLISTADOS.Margenpie, 0 )
					.Orientacion = nvl( c_PROPIEDADESLISTADOS.Orientacion, 0 )
					.Diferenciardetalle = nvl( c_PROPIEDADESLISTADOS.Diferenciardetalle, .F. )
					.Colorparaelsombreado = nvl( c_PROPIEDADESLISTADOS.Colorparaelsombreado, 0 )
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
		return c_PROPIEDADESLISTADOS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.PROPLIST' )
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
								from ZooLogic.PROPLIST 
								Where   PROPLIST.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "PROPLIST", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Nombre" as "Nombre", "Etiqueta" as "Etiqueta", "Longitud" as "Longitud", "Decimales" as "Decimalesreporte", "Calculo" as "Tipocalculo", "Mceros" as "Mostrarceros", "Pcrecer" as "Puedecrecer", "Orepetido" as "Ocultarepetido", "Lvertical" as "Lineavertical", "Wimagen" as "Anchoimagen", "Mimagen" as "Tamañooriginalimagen", "Himagen" as "Altoimagen", "Criteinit" as "Criteriodeinicializacion", "Diasatras" as "Diashaciaatras", "Vnidesde" as "Valornumericoinicial_desde", "Vnihasta" as "Valornumericoinicial_hasta", "Vcidesde" as "Valorcaracterinicial_desde", "Vcihasta" as "Valorcaracterinicial_hasta", "Vibooleano" as "Valorbooleanoinicial", "Visinobool" as "Valorsinoinicial", "Slectura" as "Sololectura", "Noinformar" as "Noinformar", "Nomostrar" as "Nomostrar", "Titulo" as "Titulolistado", "Imagen" as "Imagenlistado", "Fechaimpre" as "Imprimefechadeimpresion", "Horaimpre" as "Imprimehoradeimpresion", "Obs" as "Obs", "Cestilo" as "Estilo", "Mderecho" as "Margenderecho", "Mizquierdo" as "Margenizquierdo", "Mcabe" as "Margencabecera", "Mpie" as "Margenpie", "Orien" as "Orientacion", "Ddetalle" as "Diferenciardetalle", "Colorsombr" as "Colorparaelsombreado"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.PROPLIST 
								Where   PROPLIST.CODIGO != ''
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
	Tabla = 'PROPLIST'
	Filtro = " PROPLIST.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " PROPLIST.CODIGO != ''"
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
	<row entidad="PROPIEDADESLISTADOS                     " atributo="FECHAIMPO                               " tabla="PROPLIST       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="FECHAALTAFW                             " tabla="PROPLIST       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="FECHAEXPO                               " tabla="PROPLIST       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="FECHAMODIFICACIONFW                     " tabla="PROPLIST       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="FECHATRANSFERENCIA                      " tabla="PROPLIST       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="HORAALTAFW                              " tabla="PROPLIST       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="HORAEXPO                                " tabla="PROPLIST       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="HORAMODIFICACIONFW                      " tabla="PROPLIST       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="HORAIMPO                                " tabla="PROPLIST       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="VERSIONMODIFICACIONFW                   " tabla="PROPLIST       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="ZADSFW                                  " tabla="PROPLIST       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="VERSIONALTAFW                           " tabla="PROPLIST       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="USUARIOMODIFICACIONFW                   " tabla="PROPLIST       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="SERIEMODIFICACIONFW                     " tabla="PROPLIST       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="USUARIOALTAFW                           " tabla="PROPLIST       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="SERIEALTAFW                             " tabla="PROPLIST       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="ESTADOTRANSFERENCIA                     " tabla="PROPLIST       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="BASEDEDATOSALTAFW                       " tabla="PROPLIST       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="PROPLIST       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="CODIGO                                  " tabla="PROPLIST       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="NOMBRE                                  " tabla="PROPLIST       " campo="NOMBRE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Nombre                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="ETIQUETA                                " tabla="PROPLIST       " campo="ETIQUETA  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Etiqueta                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="200" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="LONGITUD                                " tabla="PROPLIST       " campo="LONGITUD  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Ancho de la columna                                                                                                                                             " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="210" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="DECIMALESREPORTE                        " tabla="PROPLIST       " campo="DECIMALES " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Decimales a mostrar                                                                                                                                             " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="220" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="TIPOCALCULO                             " tabla="PROPLIST       " campo="CALCULO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Cálculo                                                                                                                                                         " dominio="COMBOCALCULO                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="230" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="MOSTRARCEROS                            " tabla="PROPLIST       " campo="MCEROS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Mostrar valores en cero                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="240" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="PUEDECRECER                             " tabla="PROPLIST       " campo="PCRECER   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Puede crecer hacia abajo                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="250" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="OCULTAREPETIDO                          " tabla="PROPLIST       " campo="OREPETIDO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Ocultar cuando se repite                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="260" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="LINEAVERTICAL                           " tabla="PROPLIST       " campo="LVERTICAL " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Agregar línea vertical a la derecha                                                                                                                             " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="270" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="ANCHOIMAGEN                             " tabla="PROPLIST       " campo="WIMAGEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Ancho de la imagen ( cm. )                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="274" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="TAMAÑOORIGINALIMAGEN                    " tabla="PROPLIST       " campo="MIMAGEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Tamaño original de la imagen                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="275" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="ALTOIMAGEN                              " tabla="PROPLIST       " campo="HIMAGEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Alto de la imagen ( cm. )                                                                                                                                       " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="276" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="CRITERIODEINICIALIZACION                " tabla="PROPLIST       " campo="CRITEINIT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Valores iniciales del filtro                                                                                                                                    " dominio="COMBOCRITERIODEINICIALIZACIOND" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="280" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="DIASHACIAATRAS                          " tabla="PROPLIST       " campo="DIASATRAS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Días hacia atrás                                                                                                                                                " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="282" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="VALORNUMERICOINICIAL_DESDE              " tabla="PROPLIST       " campo="VNIDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Valor desde inicial del filtro numérico                                                                                                                         " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="290" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="VALORNUMERICOINICIAL_HASTA              " tabla="PROPLIST       " campo="VNIHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Valor hasta inicial del filtro numérico                                                                                                                         " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="300" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="VALORCARACTERINICIAL_DESDE              " tabla="PROPLIST       " campo="VCIDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Valor desde inicial del filtro alfa numérico                                                                                                                    " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="310" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="VALORCARACTERINICIAL_HASTA              " tabla="PROPLIST       " campo="VCIHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Valor hasta inicial del filtro alfa numérico                                                                                                                    " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="320" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="VALORBOOLEANOINICIAL                    " tabla="PROPLIST       " campo="VIBOOLEANO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Valor inicial del filtro lógico                                                                                                                                 " dominio="COMBOCRITERIODEINICIALIZACIONL" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="330" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="VALORSINOINICIAL                        " tabla="PROPLIST       " campo="VISINOBOOL" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Valor inicial del filtro si/no                                                                                                                                  " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="340" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="SOLOLECTURA                             " tabla="PROPLIST       " campo="SLECTURA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Bloquear modificación de filtro                                                                                                                                 " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="350" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="NOINFORMAR                              " tabla="PROPLIST       " campo="NOINFORMAR" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="No informar en el reporte                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="360" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="NOMOSTRAR                               " tabla="PROPLIST       " campo="NOMOSTRAR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="No mostrar el filtro                                                                                                                                            " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="370" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="TITULOLISTADO                           " tabla="PROPLIST       " campo="TITULO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Título                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="400" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="IMAGENLISTADO                           " tabla="PROPLIST       " campo="IMAGEN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Imagen                                                                                                                                                          " dominio="ARCHIVO                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="410" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="IMPRIMEFECHADEIMPRESION                 " tabla="PROPLIST       " campo="FECHAIMPRE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="446" etiqueta="Mostrar fecha de emisión del listado                                                                                                                            " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="420" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="IMPRIMEHORADEIMPRESION                  " tabla="PROPLIST       " campo="HORAIMPRE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="448" etiqueta="Mostrar hora de emisión del listado                                                                                                                             " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="430" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="OBS                                     " tabla="PROPLIST       " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="490" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="ESTILO                                  " tabla="PROPLIST       " campo="CESTILO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ESTILOIMPRESION                         " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="Estilo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="600" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="MARGENDERECHO                           " tabla="PROPLIST       " campo="MDERECHO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="452" etiqueta="Margen derecho                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="610" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="MARGENIZQUIERDO                         " tabla="PROPLIST       " campo="MIZQUIERDO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="454" etiqueta="Margen izquierdo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="620" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="MARGENCABECERA                          " tabla="PROPLIST       " campo="MCABE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="456" etiqueta="Margen cabecera                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="630" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="MARGENPIE                               " tabla="PROPLIST       " campo="MPIE      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="458" etiqueta="Margen pie                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="640" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="ORIENTACION                             " tabla="PROPLIST       " campo="ORIEN     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="460" etiqueta="Orientación                                                                                                                                                     " dominio="COMBOORIENTACION              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="650" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="DIFERENCIARDETALLE                      " tabla="PROPLIST       " campo="DDETALLE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="462" etiqueta="Intercalar líneas sombreadas                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="660" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROPIEDADESLISTADOS                     " atributo="COLORPARAELSOMBREADO                    " tabla="PROPLIST       " campo="COLORSOMBR" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="464" etiqueta="Color del sombreado                                                                                                                                             " dominio="COLOR                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="670" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTILOIMPRESION                         " atributo="DESCRIPCION                             " tabla="ESTIMP         " campo="CDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="451" etiqueta="Detalle Est.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ESTIMP On PROPLIST.CESTILO = ESTIMP.cCod And  ESTIMP.CCOD != ''                                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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