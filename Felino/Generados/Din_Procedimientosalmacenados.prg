
define class Din_Procedimientosalmacenados as ProcedimientosAlmacenadosBase of ProcedimientosAlmacenadosBase.prg

	cRutaTablas = ''

	*--------------------------------------------------------------------------------------------------------
	Function InsertarDesdeOtraEntidad(txArticuloDesde as variant, txArticuloHasta as variant, txColorDesde as variant, txColorHasta as variant, txTalleDesde as variant, txTalleHasta as variant, txFechaHasta as variant, txFechaAltaFW as variant, txCodigo as variant, txProveedorDesde as variant, txProveedorHasta as variant, txUnidadDeMedidaDesde as variant, txUnidadDeMedidaHasta as variant, txMaterialDesde as variant, txMaterialHasta as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "INSERT INTO TIInvConDet ( MART, MCOLO, MTALL, CANTI, IDCABECERA )  " + ;
"SELECT COART, COCOL, COTLL, CANTIDAD, IDCABECERA  " + ;
"	FROM (  " + ;
"		SELECT ADT_COMB.COART, ADT_COMB.COCOL, ADT_COMB.COTLL, ADT_COMB.CORIG + ADT_COMB.COCANT AS CANTIDAD, " + this.ObtenerDatoSegunTipo( txCODIGO ) + " AS IDCABECERA  " + ;
"			FROM ADT_COMB INNER JOIN ART ON ART.ARTCOD = ADT_COMB.COART " + ;
"				WHERE " + this.ObtenerDatoSegunTipo( txFECHAHASTA ) + " < " + this.ObtenerDatoSegunTipo( txFECHAALTAFW ) + " AND  " + ;
"						(" + this.Obtener_TCDesdeHasta( "ADT_COMB.COART", txArticuloDesde, txArticuloHasta ) + ;
" and " + this.Obtener_TCDesdeHasta( "ADT_COMB.COCOL", txColorDesde, txColorHasta ) + ;
" and " + this.Obtener_TCDesdeHasta( "ADT_COMB.COTLL", txTalleDesde, txTalleHasta ) + ;
" AND ADT_COMB.ADT_Fecha <= " + this.ObtenerDatoSegunTipo( txFECHAHASTA ) + "  " + ;
"								AND  " + this.Obtener_TCDesdeHasta( "ART.ARTFAB", txPROVEEDORDesde, txPROVEEDORHasta ) + ;
"  " + ;
"							AND  " + this.Obtener_TCDesdeHasta( "ART.ARTUNI", txUNIDADDEMEDIDADesde, txUNIDADDEMEDIDAHasta ) + ;
" " + ;
"							AND  " + this.Obtener_TCDesdeHasta( "ART.AMATE", txMATERIALDesde, txMATERIALHasta ) + ;
" " + ;
"							AND " + ;
"							ADT_COMB.COART+ ADT_COMB.COCOL+ ADT_COMB.COTLL + DTOS( ADT_COMB.ADT_Fecha ) + ' ' + ADT_COMB.ADT_Hora IN  " + ;
"								( SELECT ADT_COMB.COART+ ADT_COMB.COCOL+ ADT_COMB.COTLL + MAX( DTOS( ADT_COMB.ADT_Fecha ) + ' ' + ADT_COMB.ADT_Hora )  " + ;
"									FROM ADT_COMB INNER JOIN ART ON ART.ARTCOD = ADT_COMB.COART " + ;
"									WHERE " + this.Obtener_TCDesdeHasta( "ADT_COMB.COART", txArticuloDesde, txArticuloHasta ) + ;
" and " + this.Obtener_TCDesdeHasta( "ADT_COMB.COCOL", txColorDesde, txColorHasta ) + ;
" and " + this.Obtener_TCDesdeHasta( "ADT_COMB.COTLL", txTalleDesde, txTalleHasta ) + ;
"  AND ADT_COMB.ADT_Fecha <= " + this.ObtenerDatoSegunTipo( txFECHAHASTA ) + "  " + ;
"									AND  " + this.Obtener_TCDesdeHasta( "ART.ARTFAB", txPROVEEDORDesde, txPROVEEDORHasta ) + ;
" " + ;
"									AND  " + this.Obtener_TCDesdeHasta( "ART.ARTUNI", txUNIDADDEMEDIDADesde, txUNIDADDEMEDIDAHasta ) + ;
" " + ;
"									AND  " + this.Obtener_TCDesdeHasta( "ART.AMATE", txMATERIALDesde, txMATERIALHasta ) + ;
" " + ;
"									GROUP BY COART, COCOL, COTLL  " + ;
"								)  " + ;
"						)  " + ;
"		UNION ALL  " + ;
"		SELECT COMB.COART, COMB.COCOL, COMB.COTLL, COMB.COCANT AS CANTIDAD, " + this.ObtenerDatoSegunTipo( txCODIGO ) + " AS IDCABECERA  " + ;
"			FROM COMB  INNER JOIN ART ON ART.ARTCOD = COMB.COART " + ;
"				WHERE " + this.ObtenerDatoSegunTipo( txFECHAHASTA ) + " >= " + this.ObtenerDatoSegunTipo( txFECHAALTAFW ) + " AND " + this.Obtener_TCDesdeHasta( "COMB.COART", txArticuloDesde, txArticuloHasta ) + ;
" and " + this.Obtener_TCDesdeHasta( "COMB.COCOL", txColorDesde, txColorHasta ) + ;
" and " + this.Obtener_TCDesdeHasta( "COMB.COTLL", txTalleDesde, txTalleHasta ) + ;
"  " + ;
"				AND  " + this.Obtener_TCDesdeHasta( "ART.ARTFAB", txPROVEEDORDesde, txPROVEEDORHasta ) + ;
" " + ;
"				AND  " + this.Obtener_TCDesdeHasta( "ART.ARTUNI", txUNIDADDEMEDIDADesde, txUNIDADDEMEDIDAHasta ) + ;
" " + ;
"				AND  " + this.Obtener_TCDesdeHasta( "ART.AMATE", txMATERIALDesde, txMATERIALHasta ) + ;
" " + ;
"	) AS TEMP", "TIInvConDet,ADT_COMB,ART,COMB", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado InsertarDesdeOtraEntidad.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function InsertarDiferenciasDeInventario(txIDInventarioAControlar as variant, txCodigo as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "INSERT INTO TIDifInvDet ( MART, MCOLO, MTALL, IDCABECERA, DIFERENCIA, TIPO, CODIGO )  " + ;
"SELECT MART, MCOLO, MTALL, " + this.ObtenerDatoSegunTipo( txCODIGO ) + " AS IDCABECERA, SUM( CANTIDAD ) AS CANTIDAD, TIPO, " + this.ObtenerGuidPk() + " AS CODIGO  " + ;
"FROM (  " + ;
"	SELECT MART, MCOLO, MTALL, ( CANTFIS - CANTACONT ) AS CANTIDAD, TIPO  " + ;
"	FROM (  " + ;
"		SELECT TIInvFisDetTmp.MART, TIInvFisDetTmp.MCOLO, TIInvFisDetTmp.MTALL,  SUM( TIInvFisDetTmp.CANTI ) AS CANTFIS, TIInvConDet.CANTI AS CANTACONT, 1 AS TIPO  " + ;
"			FROM TIInvFisDetTmp INNER JOIN TIInvConDet ON TIInvFisDetTmp.MART = TIInvConDet.MART and TIInvFisDetTmp.MCOLO = TIInvConDet.MCOLO and TIInvFisDetTmp.MTALL = TIInvConDet.MTALL  " + ;
"			WHERE TIInvFisDettmp.CodDif = " + this.ObtenerDatoSegunTipo( txCODIGO ) + " AND TIInvConDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txIDINVENTARIOACONTROLAR ) + "  " + ;
"			GROUP BY TIInvFisDetTmp.MART, TIInvFisDetTmp.MCOLO, TIInvFisDetTmp.MTALL, TIInvConDet.CANTI )  AS STOCKFISICOYACONTROLAR1 " + ;
"	WHERE ( CANTFIS - CANTACONT ) > 0  " + ;
"	UNION (  " + ;
"	SELECT MART, MCOLO, MTALL, ( CANTFIS - CANTACONT ) AS CANTIDAD, TIPO  " + ;
"	FROM (  " + ;
"		SELECT TIInvFisDetTmp.MART, TIInvFisDetTmp.MCOLO, TIInvFisDetTmp.MTALL,  SUM( TIInvFisDetTmp.CANTI ) AS CANTFIS, TIInvConDet.CANTI AS CANTACONT, 2 AS TIPO  " + ;
"		FROM TIInvFisDetTmp INNER JOIN TIInvConDet ON TIInvFisDetTmp.MART = TIInvConDet.MART and TIInvFisDetTmp.MCOLO = TIInvConDet.MCOLO and TIInvFisDetTmp.MTALL = TIInvConDet.MTALL  " + ;
"		WHERE TIInvFisDettmp.CodDif = " + this.ObtenerDatoSegunTipo( txCODIGO ) + " AND TIInvConDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txIDINVENTARIOACONTROLAR ) + "  " + ;
"			GROUP BY TIInvFisDetTmp.MART, TIInvFisDetTmp.MCOLO, TIInvFisDetTmp.MTALL, TIInvConDet.CANTI )  AS STOCKFISICOYACONTROLAR2  " + ;
"	WHERE ( CANTFIS - CANTACONT ) < 0  " + ;
"	) UNION (  " + ;
"		SELECT TIInvFisDetTmp.MART, TIInvFisDetTmp.MCOLO, TIInvFisDetTmp.MTALL, SUM( TIInvFisDetTmp.CANTI ) AS CANTIDAD, 1 AS TIPO " + ;
"		FROM TIInvFisDetTmp  " + ;
"		WHERE TIInvFisDettmp.CodDif = " + this.ObtenerDatoSegunTipo( txCODIGO ) + " AND TIInvFisDetTmp.MART+ TIInvFisDetTmp.MCOLO+ TIInvFisDetTmp.MTALL NOT IN ( SELECT TIInvConDet.MART+ TIInvConDet.MCOLO+ TIInvConDet.MTALL AS COMBINACION FROM TIInvConDet WHERE TIInvConDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txIDINVENTARIOACONTROLAR ) + " )  " + ;
"		GROUP BY MART, MCOLO, MTALL  " + ;
"		HAVING SUM( TIInvFisDetTmp.CANTI ) != 0  " + ;
"	) UNION (  " + ;
"		SELECT TIInvConDet.MART, TIInvConDet.MCOLO, TIInvConDet.MTALL, SUM( (-1) * TIInvConDet.CANTI ) AS CANTIDAD, 2 AS TIPO  " + ;
"		FROM TIInvConDet  " + ;
"		WHERE TIInvConDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txIDINVENTARIOACONTROLAR ) + " AND TIInvConDet.MART+ TIInvConDet.MCOLO+ TIInvConDet.MTALL NOT IN ( SELECT TIInvFisDetTmp.MART+ TIInvFisDetTmp.MCOLO+ TIInvFisDetTmp.MTALL AS COMBINACION FROM TIInvFisDetTmp WHERE TIInvFisDettmp.CodDif = " + this.ObtenerDatoSegunTipo( txCODIGO ) + " )  " + ;
"		GROUP BY MART, MCOLO, MTALL  " + ;
"		HAVING SUM( (-1) * TIInvConDet.CANTI ) != 0  " + ;
"	) ) AS TEMP  " + ;
"GROUP BY MART, MCOLO, MTALL, TIPO", "TIDifInvDet,TIInvFisDetTmp,TIInvConDet", "", "", set( "Datasession" ) )
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
"			ON COMB.COART+ COMB.COCOL+ COMB.COTLL == ajustockDet.ajdart+ ajustockDet.ajdColor+ ajustockDet.ajdTalle  " + ;
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
"COCOD, COART, COCOL, COTLL, COCANT,  " + ;
"CORIG, FALTAFW, FMODIFW, HALTAFW, HMODIFW, UALTAFW, UMODIFW, SALTAFW, SMODIFW, BDALTAFW, BDMODIFW, VALTAFW, VMODIFW, ZADSFW )  " + ;
"SELECT GOLIBRERIAS.OBTENERGUIDPK(), " + this.ObtenerDatoSegunTipo( txFECHAHASTAAJUSTE ) + ", " + this.ObtenerDatoSegunTipo( txHORA ) + ", " + this.ObtenerDatoSegunTipo( txSERIEAJUSTE ) + ", " + this.ObtenerDatoSegunTipo( txUSUARIOAJUSTE ) + ", " + this.ObtenerDatoSegunTipo( txNOMBREENTIDAD ) + ",  " + this.ObtenerDatoSegunTipo( txNUMEROAJUSTE ) + ", '1.00',   " + ;
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
this.oConexion.EjecutarSentencias( "INSERT INTO COMB (COART, COCOL, COTLL , COCOD,  COCANT, DESCFW,  " + ;
"FALTAFW, FMODIFW, HALTAFW, HMODIFW, UALTAFW, UMODIFW, SALTAFW, SMODIFW, BDALTAFW, BDMODIFW, VALTAFW, VMODIFW, ZADSFW )  " + ;
"SELECT  ajdart, ajdColor, ajdTalle, ajustockDet.ajdart+ ajustockDet.ajdColor+ ajustockDet.ajdTalle,  ajustockDet.ajdCant, " + this.ObtenerDatoSegunTipo( txNUMEROAJUSTE ) + ",  " + ;
"" + this.ObtenerDatoSegunTipo( txFECHAALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txFECHAMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txHORAALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txHORAMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txUSUARIOALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txUSUARIOMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txSERIEALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txSERIEMODIFICACIONFW ) + ",  " + ;
" " + this.ObtenerDatoSegunTipo( txBASEDEDATOSALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txBASEDEDATOSMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txVERSIONALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txVERSIONMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txZADSFW ) + " FROM  " + ;
"ajustockDet WHERE ajustockDet.ajdart+ ajustockDet.ajdColor+ ajustockDet.ajdTalle NOT IN (SELECT COMB.COART+ COMB.COCOL+ COMB.COTLL  FROM COMB ) AND ajustockDet.ajdCodigo == " + this.ObtenerDatoSegunTipo( txCODIGO ) + "", "COMB,ajustockDet", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado InsertarStockCombinaciones.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ConsultarInexistenciaDeArticuloEnTomaDeInventario(txIDDifInventario as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT A.MART, B.ARTCOD FROM  " + ;
"	( SELECT DISTINCT TIDifInvDet.MART FROM TIDifInvDet  " + ;
"	WHERE TIDifInvDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txIDDIFINVENTARIO ) + " AND LEN( ALLTRIM( TIDifInvDet.MART ) ) > 0 ) A LEFT JOIN ART B  " + ;
"	ON A.MART = B.ARTCOD WHERE ISNULL(B.ARTCOD)", "TIDifInvDet,ART", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado ConsultarInexistenciaDeArticuloEnTomaDeInventario.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ConsultarInexistenciaDeColorEnTomaDeInventario(txIDDifInventario as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT A.MCOLO, B.COLCOD FROM  " + ;
"	( SELECT DISTINCT TIDifInvDet.MCOLO FROM TIDifInvDet  " + ;
"	WHERE TIDifInvDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txIDDIFINVENTARIO ) + " AND LEN( ALLTRIM( TIDifInvDet.MCOLO ) ) > 0) A LEFT JOIN COL B  " + ;
"	ON A.MCOLO = B.COLCOD WHERE ISNULL(B.COLCOD)", "TIDifInvDet,COL", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado ConsultarInexistenciaDeColorEnTomaDeInventario.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EliminarDiferenciasDeInventarioTemporalAntesDeComenzar(txCodigo as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "DELETE FROM TIInvFisDetTmp WHERE CodDif == " + this.ObtenerDatoSegunTipo( txCODIGO ) + "", "TIInvFisDetTmp", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado EliminarDiferenciasDeInventarioTemporalAntesDeComenzar.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function InsertarDiferenciasDeInventarioTemporal(txCodigo as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "INSERT INTO TIInvFisDetTmp ( CODIGO, CodDif, MART, MCOLO, MTALL, CANTI, IDCABECERA )  " + ;
"SELECT CODIGO, " + this.ObtenerDatoSegunTipo( txCODIGO ) + ", MART, MCOLO, MTALL, CANTI, IDCABECERA FROM TIInvFisDet  " + ;
"	WHERE IDCABECERA IN (   " + ;
"		SELECT IdInvFis  " + ;
"			FROM TIItemDifInv  " + ;
"			WHERE Codigo = " + this.ObtenerDatoSegunTipo( txCODIGO ) + " )", "TIInvFisDetTmp,TIInvFisDet,TIItemDifInv", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado InsertarDiferenciasDeInventarioTemporal.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EliminarDiferenciasDeInventarioTemporalDespuesDeFinalizar(txCodigo as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "DELETE FROM TIInvFisDetTmp WHERE CodDif == " + this.ObtenerDatoSegunTipo( txCODIGO ) + "", "TIInvFisDetTmp", "", "", set( "Datasession" ) )
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
"			ON COMB.COART+ COMB.COCOL+ COMB.COTLL == MINREPODET.CodArt+ MINREPODET.CodCol+ MINREPODET.CodTal  " + ;
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
this.oConexion.EjecutarSentencias( "INSERT INTO COMB (COART, COCOL, COTLL , COCOD,MaxRepo,  " + ;
" MinRepo, FALTAFW, FMODIFW, HALTAFW, HMODIFW, UALTAFW,UMODIFW,SALTAFW,SMODIFW,BDALTAFW,BDMODIFW,DescFW)   " + ;
" SELECT  CodArt, CodCol, CodTal, MINREPODET.CodArt+ MINREPODET.CodCol+ MINREPODET.CodTal,  MINREPODET.MaxNuevo,  MINREPODET.Cantidad,  " + ;
" " + this.ObtenerDatoSegunTipo( txFECHAALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txFECHAMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txHORAALTAFW ) + ", " + this.ObtenerDatoSegunTipo( txHORAMODIFICACIONFW ) + ", " + this.ObtenerDatoSegunTipo( txUSUARIOALTAFW ) + "," + this.ObtenerDatoSegunTipo( txUSUARIOMODIFICACIONFW ) + "," + this.ObtenerDatoSegunTipo( txSERIEALTAFW ) + "," + this.ObtenerDatoSegunTipo( txSERIEMODIFICACIONFW ) + "," + this.ObtenerDatoSegunTipo( txBASEDEDATOSALTAFW ) + "," + this.ObtenerDatoSegunTipo( txBASEDEDATOSMODIFICACIONFW ) + "," + this.ObtenerDatoSegunTipo( txDESCRIPCIONFW ) + "  FROM  " + ;
"MINREPODET WHERE MINREPODET.CodArt+ MINREPODET.CodCol+ MINREPODET.CodTal  " + ;
"NOT IN (SELECT COMB.COART+ COMB.COCOL+ COMB.COTLL  FROM COMB ) AND MINREPODET.CODIGO == " + this.ObtenerDatoSegunTipo( txCODIGO ) + "", "COMB,MINREPODET", "", "", set( "Datasession" ) )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado InsertarMinimoReposicion.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ComprobanteDeVentas_ObtenerDatos(txWhere as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT ComprobanteVDet.FART as Articulo, ComprobanteVDet.FCOLO as Color, ComprobanteVDet.FTALL as Talle, SUM( ComprobanteVDet.AfeSaldo ) AS CANTIDAD  " + ;
"	FROM ComprobanteVDet  " + ;
"	LEFT JOIN ComprobanteV ON ComprobanteV.CODIGO = ComprobanteVDet.CODIGO  " + ;
"	WHERE " + TXWHERE + "  " + ;
"	GROUP BY FART, FCOLO, FTALL", "ComprobanteVDet,ComprobanteV", "", txNombreCursor , txIdDeSession )
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
this.oConexion.EjecutarSentencias( "SELECT A.MCOLO, B.COLCOD FROM  " + ;
"	( SELECT DISTINCT TIInvConDet.MCOLO FROM TIInvConDet  " + ;
"	WHERE TIInvConDet.IDCABECERA = " + this.ObtenerDatoSegunTipo( txIDINVACONTROLAR ) + " AND LEN( ALLTRIM( TIInvConDet.MCOLO ) ) > 0 ) A LEFT JOIN COL B  " + ;
"	ON A.MCOLO = B.COLCOD WHERE ISNULL(B.COLCOD)", "TIInvConDet,COL", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado ConsultarInexistenciaDeColorEnDetalledeInventarioAControl.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function MovimientoDeStock_ObtenerDatos(txWhere as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT DETMSTOCK.MART as Articulo, DETMSTOCK.MCOLO as Color, DETMSTOCK.MTALL as Talle, SUM( DETMSTOCK.CANTI ) AS CANTIDAD  " + ;
"	FROM DETMSTOCK  " + ;
"	LEFT JOIN MSTOCK ON MSTOCK.CODIGO = DETMSTOCK.NUMR  " + ;
"	WHERE " + TXWHERE + "  " + ;
"	GROUP BY MART, MCOLO, MTALL", "DETMSTOCK,MSTOCK", "", txNombreCursor , txIdDeSession )
		catch to loError
			goServicios.Errores.LevantarExcepcion( 'Error al ejecutar el procedimiento almacenado MovimientoDeStock_ObtenerDatos.' )
		endtry
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function Piking_ObtenerDisponibles(txWhere as variant, txNombreCursor as variant, txIdDeSession as variant) As void
	Local loError as exception
		try
this.oConexion.EjecutarSentencias( "SELECT *  " + ;
"	FROM ComprobanteVDet  " + ;
"	RIGHT JOIN CompAfe ON CompAfe.Afecta = ComprobanteVDet.CODIGO  " + ;
"	AND CompAfe.afetipo = 'AFECTADO' AND CompAfe.CodInter = '" + TXWHERE + "'  " + ;
"	WHERE  ComprobanteVDet.AfeSaldo != 0 ", "ComprobanteVDet,CompAfe", "", txNombreCursor , txIdDeSession )
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
"UNION  " + ;
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

enddefine