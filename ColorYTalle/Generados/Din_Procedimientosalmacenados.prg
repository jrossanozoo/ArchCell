
define class Din_Procedimientosalmacenados as ProcedimientosAlmacenadosBase of ProcedimientosAlmacenadosBase.prg

	cRutaTablas = ''

	*--------------------------------------------------------------------------------------------------------
	Function InsertarDesdeOtraEntidad(txArticuloDesde as variant, txArticuloHasta as variant, txColorDesde as variant, txColorHasta as variant, txTalleDesde as variant, txTalleHasta as variant, txFechaHasta as variant, txFechaAltaFW as variant, txCodigo as variant, txProveedorDesde as variant, txProveedorHasta as variant, txMaterialDesde as variant, txMaterialHasta as variant, txTemporadaDesde as variant, txTemporadaHasta as variant, txFamiliaDesde as variant, txFamiliaHasta as variant, txGrupoDesde as variant, txGrupoHasta as variant, txLineaDesde as variant, txLineaHasta as variant, txCategoriaDeArticuloDesde as variant, txCategoriaDeArticuloHasta as variant, txClasificacionDesde as variant, txClasificacionHasta as variant, txTipoDeArticuloDesde as variant, txTipoDeArticuloHasta as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "INSERT INTO TIInvConDet ( MART, cColor, Talle, CANTI, IDCABECERA )  " + ;
"SELECT COART, COCOL, Talle, CANTIDAD, IDCABECERA  " + ;
"	FROM ( 	SELECT ADT_COMB.COART, ADT_COMB.COCOL, ADT_COMB.Talle, ADT_COMB.CORIG + ADT_COMB.COCANT AS CANTIDAD, " + this.ObtenerDatoSegunTipo( txCODIGO ) + " AS IDCABECERA  " + ;
"			FROM ADT_COMB INNER JOIN ART ON ART.ARTCOD = ADT_COMB.COART " + ;
"				WHERE " + this.ObtenerDatoSegunTipo( txFECHAHASTA ) + " < " + this.ObtenerDatoSegunTipo( txFECHAALTAFW ) + " AND " + ;
"						(" + this.Obtener_TCDesdeHasta( "ADT_COMB.COART", txArticuloDesde, txArticuloHasta ) + ;
" and " + this.Obtener_TCDesdeHasta( "ADT_COMB.COCOL", txColorDesde, txColorHasta ) + ;
" and " + this.Obtener_TCDesdeHasta( "ADT_COMB.Talle", txTalleDesde, txTalleHasta ) + ;
" AND ADT_COMB.ADT_Fecha <= " + this.ObtenerDatoSegunTipo( txFECHAHASTA ) + "  " + ;
"								AND  " + this.Obtener_TCDesdeHasta( "ART.ARTFAB", txPROVEEDORDesde, txPROVEEDORHasta ) + ;
" AND  " + this.Obtener_TCDesdeHasta( "ART.Mat", txMATERIALDesde, txMATERIALHasta ) + ;
" AND  " + this.Obtener_TCDesdeHasta( "ART.ATEMPORADA", txTEMPORADADesde, txTEMPORADAHasta ) + ;
" AND  " + this.Obtener_TCDesdeHasta( "ART.Familia", txFAMILIADesde, txFAMILIAHasta ) + ;
" " + ;
"							AND  " + this.Obtener_TCDesdeHasta( "ART.Grupo", txGRUPODesde, txGRUPOHasta ) + ;
" AND  " + this.Obtener_TCDesdeHasta( "ART.Linea", txLINEADesde, txLINEAHasta ) + ;
" AND  " + this.Obtener_TCDesdeHasta( "ART.CateArti", txCATEGORIADEARTICULODesde, txCATEGORIADEARTICULOHasta ) + ;
" AND  " + this.Obtener_TCDesdeHasta( "ART.ClasifArt", txCLASIFICACIONDesde, txCLASIFICACIONHasta ) + ;
" " + ;
"							AND  " + this.Obtener_TCDesdeHasta( "ART.TipoArti", txTIPODEARTICULODesde, txTIPODEARTICULOHasta ) + ;
" AND " + ;
"							ADT_COMB.COART+ ADT_COMB.COCOL+ ADT_COMB.Talle + DTOS( ADT_COMB.ADT_Fecha ) + ' ' + ADT_COMB.ADT_Hora IN  " + ;
"								( SELECT ADT_COMB.COART+ ADT_COMB.COCOL+ ADT_COMB.Talle + MAX( DTOS( ADT_COMB.ADT_Fecha ) + ' ' + ADT_COMB.ADT_Hora )  " + ;
"									FROM ADT_COMB INNER JOIN ART ON ART.ARTCOD = ADT_COMB.COART " + ;
"									WHERE " + this.Obtener_TCDesdeHasta( "ADT_COMB.COART", txArticuloDesde, txArticuloHasta ) + ;
" and " + this.Obtener_TCDesdeHasta( "ADT_COMB.COCOL", txColorDesde, txColorHasta ) + ;
" and " + this.Obtener_TCDesdeHasta( "ADT_COMB.Talle", txTalleDesde, txTalleHasta ) + ;
"  AND ADT_COMB.ADT_Fecha <= " + this.ObtenerDatoSegunTipo( txFECHAHASTA ) + "  " + ;
"									AND  " + this.Obtener_TCDesdeHasta( "ART.ARTFAB", txPROVEEDORDesde, txPROVEEDORHasta ) + ;
" 	AND  " + this.Obtener_TCDesdeHasta( "ART.Mat", txMATERIALDesde, txMATERIALHasta ) + ;
" AND  " + this.Obtener_TCDesdeHasta( "ART.ATEMPORADA", txTEMPORADADesde, txTEMPORADAHasta ) + ;
" AND  " + this.Obtener_TCDesdeHasta( "ART.Familia", txFAMILIADesde, txFAMILIAHasta ) + ;
" " + ;
"									AND  " + this.Obtener_TCDesdeHasta( "ART.Grupo", txGRUPODesde, txGRUPOHasta ) + ;
" AND  " + this.Obtener_TCDesdeHasta( "ART.Linea", txLINEADesde, txLINEAHasta ) + ;
" AND  " + this.Obtener_TCDesdeHasta( "ART.CateArti", txCATEGORIADEARTICULODesde, txCATEGORIADEARTICULOHasta ) + ;
" AND  " + this.Obtener_TCDesdeHasta( "ART.ClasifArt", txCLASIFICACIONDesde, txCLASIFICACIONHasta ) + ;
" " + ;
"									AND  " + this.Obtener_TCDesdeHasta( "ART.TipoArti", txTIPODEARTICULODesde, txTIPODEARTICULOHasta ) + ;
" " + ;
"									GROUP BY COART, COCOL, Talle )  )  " + ;
"		UNION ALL SELECT COMB.COART, COMB.COCOL, COMB.Talle, COMB.COCANT AS CANTIDAD, " + this.ObtenerDatoSegunTipo( txCODIGO ) + " AS IDCABECERA  " + ;
"			FROM COMB  INNER JOIN ART ON ART.ARTCOD = COMB.COART " + ;
"				WHERE " + this.ObtenerDatoSegunTipo( txFECHAHASTA ) + " >= " + this.ObtenerDatoSegunTipo( txFECHAALTAFW ) + " AND " + this.Obtener_TCDesdeHasta( "COMB.COART", txArticuloDesde, txArticuloHasta ) + ;
" and " + this.Obtener_TCDesdeHasta( "COMB.COCOL", txColorDesde, txColorHasta ) + ;
" and " + this.Obtener_TCDesdeHasta( "COMB.Talle", txTalleDesde, txTalleHasta ) + ;
"  " + ;
"				AND  " + this.Obtener_TCDesdeHasta( "ART.ARTFAB", txPROVEEDORDesde, txPROVEEDORHasta ) + ;
" AND  " + this.Obtener_TCDesdeHasta( "ART.Mat", txMATERIALDesde, txMATERIALHasta ) + ;
" AND  " + this.Obtener_TCDesdeHasta( "ART.ATEMPORADA", txTEMPORADADesde, txTEMPORADAHasta ) + ;
" AND  " + this.Obtener_TCDesdeHasta( "ART.Familia", txFAMILIADesde, txFAMILIAHasta ) + ;
" " + ;
"				AND  " + this.Obtener_TCDesdeHasta( "ART.Grupo", txGRUPODesde, txGRUPOHasta ) + ;
" AND  " + this.Obtener_TCDesdeHasta( "ART.Linea", txLINEADesde, txLINEAHasta ) + ;
" AND  " + this.Obtener_TCDesdeHasta( "ART.CateArti", txCATEGORIADEARTICULODesde, txCATEGORIADEARTICULOHasta ) + ;
" AND  " + this.Obtener_TCDesdeHasta( "ART.ClasifArt", txCLASIFICACIONDesde, txCLASIFICACIONHasta ) + ;
" " + ;
"				AND  " + this.Obtener_TCDesdeHasta( "ART.TipoArti", txTIPODEARTICULODesde, txTIPODEARTICULOHasta ) + ;
" ) AS TEMP	", "TIInvConDet,ADT_COMB,ART,COMB", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado InsertarDesdeOtraEntidad.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function InsertarDiferenciasDeInventario(txIDInventarioAControlar as variant, txCodigo as variant, txModo as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "INSERT INTO TIDifInvDet ( ART, cColor, Talle, IDCABECERA, DIFERENCIA, TIPO, CODIGO )  " + ;
"SELECT ART, cColor, Talle, " + this.ObtenerDatoSegunTipo( txCODIGO ) + " AS IDCABECERA, SUM( CANTIDAD ) AS CANTIDAD, TIPO, " + this.ObtenerGuidPk() + " AS CODIGO  " + ;
"FROM (  " + ;
"	SELECT ART, cColor, Talle, ( CANTFIS - CANTACONT ) AS CANTIDAD, TIPO  " + ;
"	FROM (  " + ;
"		SELECT TIInvFisDettmp.ART, TIInvFisDettmp.cColor, TIInvFisDettmp.Talle,  SUM( TIInvFisDettmp.CANTI ) AS CANTFIS, TIInvConDet.CANTI AS CANTACONT, 1 AS TIPO  " + ;
"			FROM TIInvFisDettmp INNER JOIN TIInvConDet ON TIInvFisDettmp.ART = TIInvConDet.MART and TIInvFisDettmp.cColor = TIInvConDet.cColor and TIInvFisDettmp.Talle = TIInvConDet.Talle  " + ;
"			WHERE TIInvFisDettmp.CodDif = " + this.ObtenerDatoSegunTipo( txCODIGO ) + " AND TIInvConDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txIDINVENTARIOACONTROLAR ) + "  " + ;
"			GROUP BY TIInvFisDettmp.ART, TIInvFisDettmp.cColor, TIInvFisDettmp.Talle, TIInvConDet.CANTI )  AS STOCKFISICOYACONTROLAR1 " + ;
"	WHERE ( CANTFIS - CANTACONT ) > 0  " + ;
"	UNION (  " + ;
"	SELECT ART, cColor, Talle, ( CANTFIS - CANTACONT ) AS CANTIDAD, TIPO  " + ;
"	FROM (  " + ;
"		SELECT TIInvFisDettmp.ART, TIInvFisDettmp.cColor, TIInvFisDettmp.Talle,  SUM( TIInvFisDettmp.CANTI ) AS CANTFIS, TIInvConDet.CANTI AS CANTACONT, 2 AS TIPO  " + ;
"		FROM TIInvFisDettmp INNER JOIN TIInvConDet ON TIInvFisDettmp.ART = TIInvConDet.MART and TIInvFisDettmp.cColor = TIInvConDet.cColor and TIInvFisDettmp.Talle = TIInvConDet.Talle  " + ;
"		WHERE TIInvFisDettmp.CodDif = " + this.ObtenerDatoSegunTipo( txCODIGO ) + " AND TIInvConDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txIDINVENTARIOACONTROLAR ) + "  " + ;
"			GROUP BY TIInvFisDettmp.ART, TIInvFisDettmp.cColor, TIInvFisDettmp.Talle, TIInvConDet.CANTI )  AS STOCKFISICOYACONTROLAR2  " + ;
"	WHERE ( CANTFIS - CANTACONT ) < 0  " + ;
"	) UNION (  " + ;
"		SELECT TIInvFisDettmp.ART, TIInvFisDettmp.cColor, TIInvFisDettmp.Talle, SUM( TIInvFisDettmp.CANTI ) AS CANTIDAD, 1 AS TIPO " + ;
"		FROM TIInvFisDettmp  " + ;
"		WHERE TIInvFisDettmp.CodDif = " + this.ObtenerDatoSegunTipo( txCODIGO ) + " AND TIInvFisDettmp.ART+ TIInvFisDettmp.cColor+ TIInvFisDettmp.Talle NOT IN ( SELECT TIInvConDet.MART+ TIInvConDet.cColor+ TIInvConDet.Talle AS COMBINACION FROM TIInvConDet WHERE TIInvConDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txIDINVENTARIOACONTROLAR ) + " )  " + ;
"		GROUP BY ART, cColor, Talle  " + ;
"		HAVING SUM( TIInvFisDettmp.CANTI ) != 0  " + ;
"	) UNION (  " + ;
"		SELECT TIInvConDet.MART, TIInvConDet.cColor, TIInvConDet.Talle, SUM( (-1) * TIInvConDet.CANTI ) AS CANTIDAD, 2 AS TIPO  " + ;
"		FROM TIInvConDet  " + ;
"		WHERE " + this.ObtenerDatoSegunTipo( txMODO ) + " = 1 AND TIInvConDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txIDINVENTARIOACONTROLAR ) + " AND TIInvConDet.MART+ TIInvConDet.cColor+ TIInvConDet.Talle NOT IN ( SELECT TIInvFisDettmp.ART+ TIInvFisDettmp.cColor+ TIInvFisDettmp.Talle AS COMBINACION FROM TIInvFisDettmp WHERE TIInvFisDettmp.CodDif = " + this.ObtenerDatoSegunTipo( txCODIGO ) + " )  " + ;
"		GROUP BY MART, cColor, Talle  " + ;
"		HAVING SUM( (-1) * TIInvConDet.CANTI ) != 0  " + ;
"	) ) AS TEMP  " + ;
"GROUP BY ART, cColor, Talle, TIPO", "TIDifInvDet,TIInvFisDettmp,TIInvConDet", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado InsertarDiferenciasDeInventario.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EliminarEnTIINVENTARIOACONTDetalle(txCodigo as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "DELETE FROM TIInvConDet WHERE TIInvConDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txCODIGO ) + "", "TIInvConDet", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado EliminarEnTIINVENTARIOACONTDetalle.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EliminarEnTIDIFERENCIASDEINVENTARIODetalle(txCodigo as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "DELETE FROM TIDifInvDet WHERE TIDifInvDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txCODIGO ) + "", "TIDifInvDet", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado EliminarEnTIDIFERENCIASDEINVENTARIODetalle.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EliminarEnTIINVENTARIOFISICODetalle(txCodigo as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "DELETE FROM TIInvFisDet WHERE TIInvFisDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txCODIGO ) + "", "TIInvFisDet", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado EliminarEnTIINVENTARIOFISICODetalle.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ActualizarClasificacionLimiteConsumo(txCodigo as variant, txClasificacion as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "UPDATE LCONSUMO  SET Clasif = " + this.ObtenerDatoSegunTipo( txCLASIFICACION ) + " WHERE ALLTRIM( UPPER( Cliente )) == ALLTRIM(  UPPER( " + this.ObtenerDatoSegunTipo( txCODIGO ) + " ) )", "LCONSUMO", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado ActualizarClasificacionLimiteConsumo.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ActualizarClasificacionConsumoCliente(txCodigo as variant, txClasificacion as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "UPDATE CONCLI  SET clasif = " + this.ObtenerDatoSegunTipo( txCLASIFICACION ) + " WHERE ALLTRIM( UPPER( cliente )) == ALLTRIM(  UPPER( " + this.ObtenerDatoSegunTipo( txCODIGO ) + " ) )", "CONCLI", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado ActualizarClasificacionConsumoCliente.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function AjustarStockCombinaciones(txCodigo as variant, txSigno as variant, txnumeroajuste as variant, txFechaAltaFW as variant, txFechaModificacionFW as variant, txHoraAltaFW as variant, txHoraModificacionFW as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "UPDATE COMB  " + ;
"	SET COMB.COCANT = COMB.COCANT +  " + ;
"		( ajustockDet.ajdCant * (" + this.ObtenerDatoSegunTipo( txSIGNO ) + ") ) ,  DESCFW = " + this.ObtenerDatoSegunTipo( txNUMEROAJUSTE ) + ",  " + ;
"		FALTAFW =  " + this.ObtenerDatoSegunTipo( txFECHAALTAFW ) + ", FMODIFW = " + this.ObtenerDatoSegunTipo( txFECHAMODIFICACIONFW ) + ",  " + ;
"		HALTAFW = " + this.ObtenerDatoSegunTipo( txHORAALTAFW ) + ", HMODIFW = " + this.ObtenerDatoSegunTipo( txHORAMODIFICACIONFW ) + "  " + ;
"	FROM COMB  " + ;
"		INNER JOIN ajustockDet  " + ;
"			ON COMB.COART+ COMB.COCOL+ COMB.Talle == ajustockDet.ajdart+ ajustockDet.ajdColor+ ajustockDet.ajdTalle  " + ;
"	WHERE ajustockDet.ajdCodigo == " + this.ObtenerDatoSegunTipo( txCODIGO ) + "", "COMB,ajustockDet", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado AjustarStockCombinaciones.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function InsertarAjusteAuditoriaCombinaciones(txCodigo as variant, txSigno as variant, txNombreEntidad as variant, txNumeroAjuste as variant, txFechaHastaAjuste as variant, txSerieAjuste as variant, txUsuarioAjuste as variant, txVersionAplicacion as variant, txHora as variant, txFechaAltaFW as variant, txFechaModificacionFW as variant, txHoraAltaFW as variant, txHoraModificacionFW as variant, txUsuarioAltaFW as variant, txUsuarioModificacionFW as variant, txSerieAltaFW as variant, txSerieModificacionFW as variant, txBaseDeDatosAltaFW as variant, txBaseDeDatosModificacionFW as variant, txVersionAltaFW as variant, txVersionModificacionFW as variant, txZADSFW as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "INSERT INTO ADT_COMB ( ADT_COD, ADT_FECHA, ADT_HORA, ADT_SERIE, ADT_USR, ADT_ENT, ADT_COMP, ADT_ADN, ADT_VERS, ADT_EXT,  " + ;
"COCOD, COART, COCOL, Talle, COCANT,  " + ;
"CORIG, FALTAFW, FMODIFW, HALTAFW, HMODIFW, UALTAFW, UMODIFW, SALTAFW, SMODIFW, BDALTAFW, BDMODIFW, VALTAFW, VMODIFW, ZADSFW )  " + ;
"SELECT GOLIBRERIAS.OBTENERGUIDPK(), " + this.ObtenerDatoSegunTipo( txFECHAHASTAAJUSTE ) + ", " + this.ObtenerDatoSegunTipo( txHORA ) + ", " + this.ObtenerDatoSegunTipo( txSERIEAJUSTE ) + ", " + this.ObtenerDatoSegunTipo( txUSUARIOAJUSTE ) + ", " + this.ObtenerDatoSegunTipo( txNOMBREENTIDAD ) + ", " + this.ObtenerDatoSegunTipo( txNUMEROAJUSTE ) + ", '1.00',   " + ;
"" + this.ObtenerDatoSegunTipo( txVERSIONAPLICACION ) + ", .F., ajAudiCombDet.ajdart+ ajAudiCombDet.ajdColor+ ajAudiCombDet.ajdTalle, ajdart, ajdColor, ajdTalle, ajdCant,  " + ;
"ajdstock,  " + this.ObtenerDatoSegunTipo( txFECHAALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txFECHAMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txHORAALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txHORAMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txUSUARIOALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txUSUARIOMODIFICACIONFW ) + ",  " + ;
"" + this.ObtenerDatoSegunTipo( txSERIEALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txSERIEMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txBASEDEDATOSALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txBASEDEDATOSMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txVERSIONALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txVERSIONMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txZADSFW ) + " FROM  " + ;
"ajAudiCombDet WHERE ajdCodigo = " + this.ObtenerDatoSegunTipo( txCODIGO ) + "", "ADT_COMB,ajAudiCombDet", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado InsertarAjusteAuditoriaCombinaciones.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EliminarAjusteAuditoriaCombinaciones(txComprobante as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "DELETE FROM ADT_COMB  WHERE RTRIM( LTRIM( ADT_Comp ) ) = " + this.ObtenerDatoSegunTipo( txCOMPROBANTE ) + "", "ADT_COMB", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado EliminarAjusteAuditoriaCombinaciones.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function InsertarStockCombinaciones(txCodigo as variant, txnumeroajuste as variant, txFechaAltaFW as variant, txFechaModificacionFW as variant, txHoraAltaFW as variant, txHoraModificacionFW as variant, txUsuarioAltaFW as variant, txUsuarioModificacionFW as variant, txSerieAltaFW as variant, txSerieModificacionFW as variant, txBaseDeDatosAltaFW as variant, txBaseDeDatosModificacionFW as variant, txVersionAltaFW as variant, txVersionModificacionFW as variant, txZADSFW as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "INSERT INTO COMB (COART, COCOL, Talle , COCOD,  COCANT, DESCFW,  " + ;
"FALTAFW, FMODIFW, HALTAFW, HMODIFW, UALTAFW, UMODIFW, SALTAFW, SMODIFW, BDALTAFW, BDMODIFW, VALTAFW, VMODIFW, ZADSFW )  " + ;
"SELECT  ajdart, ajdColor, ajdTalle, ajustockDet.ajdart+ ajustockDet.ajdColor+ ajustockDet.ajdTalle,  ajustockDet.ajdCant, " + this.ObtenerDatoSegunTipo( txNUMEROAJUSTE ) + ",  " + ;
"" + this.ObtenerDatoSegunTipo( txFECHAALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txFECHAMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txHORAALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txHORAMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txUSUARIOALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txUSUARIOMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txSERIEALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txSERIEMODIFICACIONFW ) + ",  " + ;
" " + this.ObtenerDatoSegunTipo( txBASEDEDATOSALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txBASEDEDATOSMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txVERSIONALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txVERSIONMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txZADSFW ) + " FROM  " + ;
"ajustockDet WHERE ajustockDet.ajdart+ ajustockDet.ajdColor+ ajustockDet.ajdTalle NOT IN (SELECT COMB.COART+ COMB.COCOL+ COMB.Talle  FROM COMB ) AND ajustockDet.ajdCodigo == " + this.ObtenerDatoSegunTipo( txCODIGO ) + "", "COMB,ajustockDet", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado InsertarStockCombinaciones.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ConsultarInexistenciaDeArticuloEnTomaDeInventario(txIDDifInventario as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT A.ART, B.ARTCOD FROM  " + ;
"	( SELECT DISTINCT TIDifInvDet.ART FROM TIDifInvDet  " + ;
"	WHERE TIDifInvDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txIDDIFINVENTARIO ) + " AND LEN( ALLTRIM( TIDifInvDet.ART ) ) > 0) A LEFT JOIN ART B  " + ;
"	ON A.ART = B.ARTCOD WHERE ISNULL(B.ARTCOD)", "TIDifInvDet,ART", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado ConsultarInexistenciaDeArticuloEnTomaDeInventario.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ConsultarInexistenciaDeColorEnTomaDeInventario(txIDDifInventario as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT A.cColor, B.COLCOD FROM  " + ;
"	( SELECT DISTINCT TIDifInvDet.cColor FROM TIDifInvDet  " + ;
"	WHERE TIDifInvDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txIDDIFINVENTARIO ) + " AND LEN( ALLTRIM( TIDifInvDet.cColor ) ) > 0 ) A LEFT JOIN COL B  " + ;
"	ON A.cColor = B.COLCOD WHERE ISNULL(B.COLCOD)", "TIDifInvDet,COL", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado ConsultarInexistenciaDeColorEnTomaDeInventario.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ConsultarInexistenciaDeTalleEnTomaDeInventario(txIDDifInventario as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT A.Talle, B.Codigo FROM  " + ;
"	( SELECT DISTINCT TIDifInvDet.Talle FROM TIDifInvDet  " + ;
"	WHERE TIDifInvDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txIDDIFINVENTARIO ) + " AND LEN( ALLTRIM( TIDifInvDet.Talle ) ) > 0 ) A LEFT JOIN Talle B  " + ;
"	ON A.Talle = B.Codigo WHERE ISNULL(B.Codigo)", "TIDifInvDet,Talle", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado ConsultarInexistenciaDeTalleEnTomaDeInventario.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EliminarDiferenciasDeInventarioTemporalAntesDeComenzar(txCodigo as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "DELETE FROM TIInvFisDettmp WHERE CodDif == " + this.ObtenerDatoSegunTipo( txCODIGO ) + "", "TIInvFisDettmp", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado EliminarDiferenciasDeInventarioTemporalAntesDeComenzar.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function InsertarDiferenciasDeInventarioTemporal(txCodigo as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "INSERT INTO TIInvFisDettmp ( CODIGO, CodDif, ART, cColor, Talle, CANTI, IDCABECERA )  " + ;
"SELECT CODIGO, " + this.ObtenerDatoSegunTipo( txCODIGO ) + ", ART, cColor, Talle, CANTI, IDCABECERA FROM TIInvFisDet  " + ;
"	WHERE IDCABECERA IN (   " + ;
"		SELECT IdInvFis  " + ;
"			FROM TIItemDifInv  " + ;
"			WHERE Codigo = " + this.ObtenerDatoSegunTipo( txCODIGO ) + " )", "TIInvFisDettmp,TIInvFisDet,TIItemDifInv", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado InsertarDiferenciasDeInventarioTemporal.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EliminarDiferenciasDeInventarioTemporalDespuesDeFinalizar(txCodigo as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "DELETE FROM TIInvFisDettmp WHERE CodDif == " + this.ObtenerDatoSegunTipo( txCODIGO ) + "", "TIInvFisDettmp", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado EliminarDiferenciasDeInventarioTemporalDespuesDeFinalizar.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function MercaderiaEnTransito_ObtenerDatos(txWhere as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT DETMTRANS.MART as Articulo, DETMTRANS.cColor as Color, DETMTRANS.Talle as Talle, SUM( DETMTRANS.CANTI ) AS CANTIDAD  " + ;
"	FROM DETMTRANS  " + ;
"	LEFT JOIN MTRANS ON MTRANS.CODIGO = DETMTRANS.NUMR  " + ;
"	WHERE " + TXWHERE + "  " + ;
"	GROUP BY MART, cColor, Talle", "DETMTRANS,MTRANS", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado MercaderiaEnTransito_ObtenerDatos.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ActualizarMinimoReposicion(txCodigo as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "UPDATE COMB  " + ;
"	SET COMB.MinRepo = MINREPODET.Cantidad ,  " + ;
"		COMB.MaxRepo = MINREPODET.MaxNuevo ,  " + ;
"		COMB.FMODIFW = MINREPO.FMODIFW,  " + ;
"		COMB.HMODIFW = MINREPO.HMODIFW,  " + ;
"		COMB.UMODIFW = MINREPO.UMODIFW,  " + ;
"		COMB.SMODIFW = MINREPO.SMODIFW,  " + ;
"		COMB.BDMODIFW = MINREPO.BDMODIFW,   " + ;
"		COMB.DescFW = MINREPO.DescFW  " + ;
"	FROM COMB  " + ;
"		INNER JOIN MINREPODET  " + ;
"			ON COMB.COART+ COMB.COCOL+ COMB.Talle == MINREPODET.CodArt+ MINREPODET.CodCol+ MINREPODET.CodTal  " + ;
"		INNER JOIN MINREPO  " + ;
"			ON MINREPODET.CODIGO == MINREPO.CODIGO  " + ;
"	WHERE MINREPODET.CODIGO == " + this.ObtenerDatoSegunTipo( txCODIGO ) + "", "COMB,MINREPODET,MINREPO", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado ActualizarMinimoReposicion.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function InsertarMinimoReposicion(txCodigo as variant, txFechaAltaFW as variant, txFechaModificacionFW as variant, txHoraAltaFW as variant, txHoraModificacionFW as variant, txUsuarioAltaFW as variant, txUsuarioModificacionFW as variant, txSerieAltaFW as variant, txSerieModificacionFW as variant, txBaseDeDatosAltaFW as variant, txBaseDeDatosModificacionFW as variant, txDescripcionFW as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "INSERT INTO COMB (COART, COCOL, Talle , COCOD,MaxRepo,  " + ;
" MinRepo, FALTAFW, FMODIFW, HALTAFW, HMODIFW, UALTAFW,UMODIFW,SALTAFW,SMODIFW,BDALTAFW,BDMODIFW,DescFW)   " + ;
" SELECT  CodArt, CodCol, CodTal, MINREPODET.CodArt+ MINREPODET.CodCol+ MINREPODET.CodTal,  MINREPODET.MaxNuevo,  MINREPODET.Cantidad,  " + ;
" " + this.ObtenerDatoSegunTipo( txFECHAALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txFECHAMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txHORAALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txHORAMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txUSUARIOALTAFW ) + "," + this.ObtenerDatoSegunTipo( txUSUARIOMODIFICACIONFW ) + "," + this.ObtenerDatoSegunTipo( txSERIEALTAFW ) + "," + this.ObtenerDatoSegunTipo( txSERIEMODIFICACIONFW ) + "," + this.ObtenerDatoSegunTipo( txBASEDEDATOSALTAFW ) + "," + this.ObtenerDatoSegunTipo( txBASEDEDATOSMODIFICACIONFW ) + "," + this.ObtenerDatoSegunTipo( txDESCRIPCIONFW ) + "  FROM  " + ;
"MINREPODET WHERE MINREPODET.CodArt+ MINREPODET.CodCol+ MINREPODET.CodTal  " + ;
"NOT IN (SELECT COMB.COART+ COMB.COCOL+ COMB.Talle  FROM COMB ) AND MINREPODET.CODIGO == " + this.ObtenerDatoSegunTipo( txCODIGO ) + "", "COMB,MINREPODET", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado InsertarMinimoReposicion.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ComprobanteDeVentas_ObtenerDatos(txWhere as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT COMPROBANTEVDET.FART as Articulo, COMPROBANTEVDET.cColor as Color, COMPROBANTEVDET.Talle as Talle, SUM( COMPROBANTEVDET.AfeSaldo ) AS CANTIDAD  " + ;
"	FROM COMPROBANTEVDET  " + ;
"	LEFT JOIN ComprobanteV ON ComprobanteV.CODIGO = COMPROBANTEVDET.CODIGO  " + ;
"	WHERE " + TXWHERE + "  " + ;
"	GROUP BY FART, cColor, Talle", "COMPROBANTEVDET,ComprobanteV", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado ComprobanteDeVentas_ObtenerDatos.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function PedidoDeCompra_ObtenerDatos(txWhere as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT PedCompraDet.FART as Articulo, PedCompraDet.FCOLO as Color, PedCompraDet.FTALL as Talle, SUM( PedCompraDet.AfeSaldo ) AS CANTIDAD  " + ;
"	FROM PedCompraDet  " + ;
"	LEFT JOIN PedCompra ON PedCompra.CODIGO = PedCompraDet.CODIGO  " + ;
"	WHERE " + TXWHERE + "  " + ;
"	GROUP BY FART, FCOLO, FTALL", "PedCompraDet,PedCompra", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado PedidoDeCompra_ObtenerDatos.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function FacturaDeCompra_ObtenerDatos(txWhere as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT FacCompraDet.FART as Articulo, FacCompraDet.FCOLO as Color, FacCompraDet.FTALL as Talle, SUM( FacCompraDet.AfeSaldo ) AS CANTIDAD  " + ;
"	FROM FacCompraDet  " + ;
"	LEFT JOIN FacCompra ON FacCompra.CODIGO = FacCompraDet.CODIGO  " + ;
"	WHERE " + TXWHERE + "  " + ;
"	GROUP BY FART, FCOLO, FTALL", "FacCompraDet,FacCompra", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado FacturaDeCompra_ObtenerDatos.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function RemitoDeCompra_ObtenerDatos(txWhere as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT RemCompraDet.FART as Articulo, RemCompraDet.FCOLO as Color, RemCompraDet.FTALL as Talle, SUM( RemCompraDet.AfeSaldo ) AS CANTIDAD  " + ;
"	FROM RemCompraDet  " + ;
"	LEFT JOIN RemCompra ON RemCompra.CODIGO = RemCompraDet.CODIGO  " + ;
"	WHERE " + TXWHERE + "  " + ;
"	GROUP BY FART, FCOLO, FTALL", "RemCompraDet,RemCompra", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado RemitoDeCompra_ObtenerDatos.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ConsultarInexistenciaDeArticuloEnDetalledeInventarioAControl(txIDInvAControlar as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT A.MART, B.ARTCOD FROM  " + ;
"	( SELECT DISTINCT TIInvConDet.MART FROM TIInvConDet  " + ;
"	WHERE TIInvConDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txIDINVACONTROLAR ) + " AND LEN( ALLTRIM( TIInvConDet.MART ) ) > 0) A LEFT JOIN ART B  " + ;
"	ON A.MART = B.ARTCOD WHERE ISNULL(B.ARTCOD)", "TIInvConDet,ART", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado ConsultarInexistenciaDeArticuloEnDetalledeInventarioAControl.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ConsultarInexistenciaDeColorEnDetalledeInventarioAControl(txIDInvAControlar as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT A.cColor, B.COLCOD FROM  " + ;
"	( SELECT DISTINCT TIInvConDet.cColor FROM TIInvConDet  " + ;
"	WHERE TIInvConDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txIDINVACONTROLAR ) + " AND LEN( ALLTRIM( TIInvConDet.cColor ) ) > 0 ) A LEFT JOIN COL B  " + ;
"	ON A.cColor = B.COLCOD WHERE ISNULL(B.COLCOD)", "TIInvConDet,COL", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado ConsultarInexistenciaDeColorEnDetalledeInventarioAControl.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ConsultarInexistenciaDeTalleEnDetalledeInventarioAControl(txIDInvAControlar as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT A.Talle, B.Codigo FROM  " + ;
"	( SELECT DISTINCT TIInvConDet.Talle FROM TIInvConDet  " + ;
"	WHERE TIInvConDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txIDINVACONTROLAR ) + " AND LEN( ALLTRIM( TIInvConDet.Talle ) ) > 0 ) A LEFT JOIN Talle B  " + ;
"	ON A.Talle = B.Codigo WHERE ISNULL(B.Codigo)", "TIInvConDet,Talle", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado ConsultarInexistenciaDeTalleEnDetalledeInventarioAControl.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function MovimientoDeStock_ObtenerDatos(txWhere as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT DETMSTOCK.MART as Articulo, DETMSTOCK.cColor as Color, DETMSTOCK.Talle as Talle, SUM( DETMSTOCK.CANTI ) AS CANTIDAD  " + ;
"	FROM DETMSTOCK  " + ;
"	LEFT JOIN MSTOCK ON MSTOCK.CODIGO = DETMSTOCK.NUMR  " + ;
"	WHERE " + TXWHERE + "  " + ;
"	GROUP BY MART, cColor, Talle", "DETMSTOCK,MSTOCK", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado MovimientoDeStock_ObtenerDatos.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function Piking_ObtenerDisponibles(txWhere as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT *  " + ;
"	FROM COMPROBANTEVDET  " + ;
"	RIGHT JOIN CompAfe ON CompAfe.Afecta = COMPROBANTEVDET.CODIGO  " + ;
"	AND CompAfe.afetipo = 'AFECTADO' AND CompAfe.CodInter = '" + TXWHERE + "'  " + ;
"	WHERE  COMPROBANTEVDET.AfeSaldo != 0 ", "COMPROBANTEVDET,CompAfe", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado Piking_ObtenerDisponibles.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerLiquidacionesDiariasAgrupadas(txOperadora as variant, txWhere as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT A.Concepto, SUM( A.monto) AS MONTO, SUM( A.ORDEN ) AS ORDEN FROM (  " + ;
"  SELECT B.Concepto, B.monto, 0 AS ORDEN  " + ;
"  FROM liqdiariaDet B WHERE "+ TXWHERE + "  " + ;
"UNION ALL " + ;
" SELECT OPETARCON.Concepto, 0 AS MONTO,OPETARCON.Orden  FROM OPETARCON    " + ;
" INNER JOIN conliqtar B ON OPETARCON.Concepto = B.CODIGO AND B.COMPORTA !=1 WHERE OPETARCON.Codigo = " + TXOPERADORA + " " + ;
"  ) A GROUP BY CONCEPTO ORDER BY ORDEN", "liqdiariaDet,OPETARCON,conliqtar", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado ObtenerLiquidacionesDiariasAgrupadas.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function Obtener_PK_SegunAlias(txtcWhere as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT *  " + ;
"      FROM plancuenta  " + ;
"      WHERE  plancuenta.apodo ='"+ TXTCWHERE + "'", "plancuenta", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado Obtener_PK_SegunAlias.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function AjustarStockCombinacionesEnTransito(txCodigo as variant, txSigno as variant, txnumeroajuste as variant, txFechaAltaFW as variant, txFechaModificacionFW as variant, txHoraAltaFW as variant, txHoraModificacionFW as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "UPDATE COMB  " + ;
"	SET COMB.EnTransito = COMB.EnTransito +  " + ;
"		( ajuEnTranDet.ajdCant * (" + this.ObtenerDatoSegunTipo( txSIGNO ) + ") ) ,  DESCFW = " + this.ObtenerDatoSegunTipo( txNUMEROAJUSTE ) + ",  " + ;
"		FALTAFW =  " + this.ObtenerDatoSegunTipo( txFECHAALTAFW ) + ", FMODIFW = " + this.ObtenerDatoSegunTipo( txFECHAMODIFICACIONFW ) + ",  " + ;
"		HALTAFW = " + this.ObtenerDatoSegunTipo( txHORAALTAFW ) + ", HMODIFW = " + this.ObtenerDatoSegunTipo( txHORAMODIFICACIONFW ) + "  " + ;
"	FROM COMB  " + ;
"		INNER JOIN ajuEnTranDet  " + ;
"			ON COMB.COART+ COMB.COCOL+ COMB.Talle == ajuEnTranDet.ajdart+ ajuEnTranDet.ajdColor+ ajuEnTranDet.ajdTalle  " + ;
"	WHERE ajuEnTranDet.ajdCodigo == " + this.ObtenerDatoSegunTipo( txCODIGO ) + "", "COMB,ajuEnTranDet", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado AjustarStockCombinacionesEnTransito.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function InsertarAjusteAuditoriaCombinacionesEnTransito(txCodigo as variant, txSigno as variant, txNombreEntidad as variant, txNumeroAjuste as variant, txFechaHastaAjuste as variant, txSerieAjuste as variant, txUsuarioAjuste as variant, txVersionAplicacion as variant, txHora as variant, txFechaAltaFW as variant, txFechaModificacionFW as variant, txHoraAltaFW as variant, txHoraModificacionFW as variant, txUsuarioAltaFW as variant, txUsuarioModificacionFW as variant, txSerieAltaFW as variant, txSerieModificacionFW as variant, txBaseDeDatosAltaFW as variant, txBaseDeDatosModificacionFW as variant, txVersionAltaFW as variant, txVersionModificacionFW as variant, txZADSFW as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "INSERT INTO ADT_COMB ( ADT_COD, ADT_FECHA, ADT_HORA, ADT_SERIE, ADT_USR, ADT_ENT, ADT_COMP, ADT_ADN, ADT_VERS, ADT_EXT,  " + ;
"COCOD, COART, COCOL, Talle, EnTransito,  " + ;
"CORIG, FALTAFW, FMODIFW, HALTAFW, HMODIFW, UALTAFW, UMODIFW, SALTAFW, SMODIFW, BDALTAFW, BDMODIFW, VALTAFW, VMODIFW, ZADSFW )  " + ;
"SELECT GOLIBRERIAS.OBTENERGUIDPK(), " + this.ObtenerDatoSegunTipo( txFECHAHASTAAJUSTE ) + ", " + this.ObtenerDatoSegunTipo( txHORA ) + ", " + this.ObtenerDatoSegunTipo( txSERIEAJUSTE ) + ", " + this.ObtenerDatoSegunTipo( txUSUARIOAJUSTE ) + ", " + this.ObtenerDatoSegunTipo( txNOMBREENTIDAD ) + ", " + this.ObtenerDatoSegunTipo( txNUMEROAJUSTE ) + ", '1.00',   " + ;
"" + this.ObtenerDatoSegunTipo( txVERSIONAPLICACION ) + ", .F., ajAuEnTranDet.ajdart+ ajAuEnTranDet.ajdColor+ ajAuEnTranDet.ajdTalle, ajdart, ajdColor, ajdTalle, ajdCant,  " + ;
"ajdstock,  " + this.ObtenerDatoSegunTipo( txFECHAALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txFECHAMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txHORAALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txHORAMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txUSUARIOALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txUSUARIOMODIFICACIONFW ) + ",  " + ;
"" + this.ObtenerDatoSegunTipo( txSERIEALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txSERIEMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txBASEDEDATOSALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txBASEDEDATOSMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txVERSIONALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txVERSIONMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txZADSFW ) + " FROM  " + ;
"ajAuEnTranDet WHERE ajdCodigo = " + this.ObtenerDatoSegunTipo( txCODIGO ) + "", "ADT_COMB,ajAuEnTranDet", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado InsertarAjusteAuditoriaCombinacionesEnTransito.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EliminarAjusteAuditoriaCombinacionesEnTransito(txComprobante as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "DELETE FROM ADT_COMB  WHERE RTRIM( LTRIM( ADT_Comp ) ) = " + this.ObtenerDatoSegunTipo( txCOMPROBANTE ) + "", "ADT_COMB", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado EliminarAjusteAuditoriaCombinacionesEnTransito.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function InsertarStockCombinacionesEnTransito(txCodigo as variant, txnumeroajuste as variant, txFechaAltaFW as variant, txFechaModificacionFW as variant, txHoraAltaFW as variant, txHoraModificacionFW as variant, txUsuarioAltaFW as variant, txUsuarioModificacionFW as variant, txSerieAltaFW as variant, txSerieModificacionFW as variant, txBaseDeDatosAltaFW as variant, txBaseDeDatosModificacionFW as variant, txVersionAltaFW as variant, txVersionModificacionFW as variant, txZADSFW as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "INSERT INTO COMB (COART, COCOL, Talle , COCOD,  EnTransito, DESCFW,  " + ;
"FALTAFW, FMODIFW, HALTAFW, HMODIFW, UALTAFW, UMODIFW, SALTAFW, SMODIFW, BDALTAFW, BDMODIFW, VALTAFW, VMODIFW, ZADSFW )  " + ;
"SELECT  ajdart, ajdColor, ajdTalle, ajuEnTranDet.ajdart+ ajuEnTranDet.ajdColor+ ajuEnTranDet.ajdTalle,  ajuEnTranDet.ajdCant, " + this.ObtenerDatoSegunTipo( txNUMEROAJUSTE ) + ",  " + ;
"" + this.ObtenerDatoSegunTipo( txFECHAALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txFECHAMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txHORAALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txHORAMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txUSUARIOALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txUSUARIOMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txSERIEALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txSERIEMODIFICACIONFW ) + ",  " + ;
" " + this.ObtenerDatoSegunTipo( txBASEDEDATOSALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txBASEDEDATOSMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txVERSIONALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txVERSIONMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txZADSFW ) + " FROM  " + ;
"ajuEnTranDet WHERE ajuEnTranDet.ajdart+ ajuEnTranDet.ajdColor+ ajuEnTranDet.ajdTalle NOT IN (SELECT COMB.COART+ COMB.COCOL+ COMB.Talle  FROM COMB ) AND ajuEnTranDet.ajdCodigo == " + this.ObtenerDatoSegunTipo( txCODIGO ) + "", "COMB,ajuEnTranDet", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado InsertarStockCombinacionesEnTransito.' )
		endtry
	endfunc

enddefine