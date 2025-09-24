**********************************************************************
Define Class zTestU_ParseadorErroresNet as FxuTestCase OF FxuTestCase.prg

	#IF .f.
		Local this as zTestU_ParseadorErroresNet of zTestU_ParseadorErroresNet.prg
	#ENDIF
	
	*---------------------------------
	Function Setup

	EndFunc
	
	*---------------------------------
	Function TearDown

	endfunc
	
	*-----------------------------------------------------------------------------------------
	function zTest_ParseadorEnIngles
		local loTraductor as ParseadorErroresNet of ParseadorErroresNet.prg, lcMensajeTraducido as String, lcMensajeOriginal as String

			text to lcMensajeOriginal textmerge noshow
OLE IDispatch exception code 0 from ?: Se produjo una excepci�n en el destino de la invocaci�n.El tipo de cambio no podr� ser inferior al 50% ni superior a un 100% del que suministra AFIP como orientativo de acuerdo a la cotizaci�n oficial.

No se puede encontrar el m�todo 'ZooLogicSA.FacturacionElectronicaV2.FacturacionElectronica.obtenercaewsfex'...
			endtext

		loParseador = _screen.zoo.crearobjeto( "ParseadorErroresNet" )

		lcMensajeTraducido = loParseador.Parsear( lcMensajeOriginal )
		lcMensajeTraducido = strtran( lcMensajeTraducido, chr( 13 )+ chr(10), "" )
		lcMensajeTraducido = strtran( lcMensajeTraducido, chr( 13 )+ chr(10), "" )
		
		lcMensajeCorrecto = "El tipo de cambio no podr� ser inferior al 50% ni superior a un 100% del que suministra AFIP como orientativo de acuerdo a la cotizaci�n oficial."

		This.assertequals( "Mensaje correcto.", alltrim( lcMensajeCorrecto ), alltrim( lcMensajeTraducido ) )
		loParseador.release()

	endfunc 
	
	
	*-----------------------------------------------------------------------------------------
	function zTest_ParseadorEnCastellano
		local loParseador as ParseadorErroresNet of ParseadorErroresNet.prg, lcMensajeTraducido as String, lcMensajeOriginal as String

			text to lcMensajeOriginal textmerge noshow
C�digo de excepci�n OLE IDispatch 0 from ?: Se produjo una excepci�n en el destino de la invocaci�n.El tipo de cambio no podr� ser inferior al 50% ni superior a un 100% del que suministra AFIP como orientativo de acuerdo a la cotizaci�n oficial.

No se puede encontrar el m�todo 'ZooLogicSA.FacturacionElectronicaV2.FacturacionElectronica.obtenercaewsfex'...
			endtext

		loParseador= _screen.zoo.crearobjeto( "ParseadorErroresNet" )

		lcMensajeTraducido = loParseador.Parsear( lcMensajeOriginal )
		lcMensajeTraducido = strtran( lcMensajeTraducido, chr( 13 )+ chr(10), "" )
		lcMensajeTraducido = strtran( lcMensajeTraducido, chr( 13 )+ chr(10), "" )
		
		lcMensajeCorrecto = "El tipo de cambio no podr� ser inferior al 50% ni superior a un 100% del que suministra AFIP como orientativo de acuerdo a la cotizaci�n oficial."

		This.assertequals( "Mensaje correcto.", alltrim( lcMensajeCorrecto ), alltrim( lcMensajeTraducido ) )
		loParseador.release()

	endfunc 

	*-----------------------------------------------------------------------------------------
	Function zTestU_QuitarAyudaAfip 
		
		local loParseador as ParseadorErroresNet of ParseadorErroresNet.prg, lcMensajeTraducido as String, lcMensajeOriginal as String

		text to lcMensajeOriginal textmerge noshow
C�digo de excepci�n OLE IDispatch 0 from ?: Se produjo una excepci�n en el destino de la invocaci�n.El tipo de cambio no podr� ser inferior al 50% ni superior a un 100% del que suministra AFIP como orientativo de acuerdo a la cotizaci�n oficial. Ver Metodo FEXGetPARAM_Ctz. (1667)

No se puede encontrar el m�todo 'ZooLogicSA.FacturacionElectronicaV2.FacturacionElectronica.obtenercaewsfex'...
		endtext

		loParseador= _screen.zoo.crearobjeto( "ParseadorErroresNet" )

		lcMensajeTraducido = loParseador.Parsear( lcMensajeOriginal )
		lcMensajeTraducido = strtran( lcMensajeTraducido, chr( 13 )+ chr(10), "" )
		lcMensajeTraducido = strtran( lcMensajeTraducido, chr( 13 )+ chr(10), "" )
		
		lcMensajeCorrecto = "El tipo de cambio no podr� ser inferior al 50% ni superior a un 100% del que suministra AFIP como orientativo de acuerdo a la cotizaci�n oficial."

		This.assertequals( "Mensaje correcto.", alltrim( lcMensajeCorrecto ), alltrim( lcMensajeTraducido ) )
		loParseador.release()

	endfunc 

	*-----------------------------------------------------------------------------------------
	Function zTestU_ExcepcionNativaFrameworkNET
	
		local loParseador as ParseadorErroresNet of ParseadorErroresNet.prg, lcMensajeTraducido as String, lcMensajeOriginal as String

		text to lcMensajeOriginal textmerge noshow
OLE IDispatch exception code 0 from ?: No se puede encontrar el m�todo 'System.Collections.Generic.List`1[[System.String, mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]].item'.Se produjo una excepci�n en el destino de la invocaci�n..
		endtext

		loParseador= _screen.zoo.crearobjeto( "ParseadorErroresNet" )

		lcMensajeTraducido = loParseador.Parsear( lcMensajeOriginal )
		lcMensajeTraducido = strtran( lcMensajeTraducido, chr( 13 )+ chr(10), "" )
		lcMensajeTraducido = strtran( lcMensajeTraducido, chr( 13 )+ chr(10), "" )
		
		lcMensajeCorrecto = "No se puede encontrar el m�todo 'System.Collections.Generic.List`1[[System.String, mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]].item'."

		This.assertequals( "Mensaje correcto.", alltrim( lcMensajeCorrecto ), alltrim( lcMensajeTraducido ) )
		loParseador.release()

	endfunc 

	*-----------------------------------------------------------------------------------------
	Function zTestU_ExcepcionSqlTransactionSeCompleto
	
		local loParseador as ParseadorErroresNet of ParseadorErroresNet.prg, lcMensajeTraducido as String, lcMensajeOriginal as String

		text to lcMensajeOriginal textmerge noshow
OLE IDispatch exception code 0 from ?: Se produjo una excepci�n en el destino de la invocaci�n.SqlTransaction se complet�; ya no se puede utilizar.
		endtext

		loParseador= _screen.zoo.crearobjeto( "ParseadorErroresNet" )

		lcMensajeTraducido = loParseador.Parsear( lcMensajeOriginal )
		lcMensajeTraducido = strtran( lcMensajeTraducido, chr( 13 )+ chr(10), "" )
		lcMensajeTraducido = strtran( lcMensajeTraducido, chr( 13 )+ chr(10), "" )
		
		lcMensajeCorrecto = "SqlTransaction se complet�; ya no se puede utilizar."

		This.assertequals( "Mensaje correcto.", alltrim( lcMensajeCorrecto ), alltrim( lcMensajeTraducido ) )
		loParseador.release()

	endfunc 

	*-----------------------------------------------------------------------------------------
	function zTestU_ExcepcionQueNoComienzaConOLEDispatch
		local loParseador as ParseadorErroresNet of ParseadorErroresNet.prg, lcMensajeTraducido as string, lcMensajeOriginal as string

		text to lcMensajeOriginal textmerge noshow
Error al iniciar proceso para obtener CAE: OLE IDispatch exception code 0 from ?: Se produjo una excepci�n en el destino de la invocaci�n.Error interno de base de datos - FECAESolicitar (501)
		endtext

		loParseador = _screen.Zoo.CrearObjeto("ParseadorErroresNet")

		lcMensajeTraducido = loParseador.Parsear(lcMensajeOriginal)
		lcMensajeTraducido = strtran(lcMensajeTraducido, chr(13) + chr(10), "")
		lcMensajeTraducido = strtran(lcMensajeTraducido, chr(13) + chr(10), "")
		
		lcMensajeCorrecto = "Error interno de base de datos - FECAESolicitar (501)"

		this.AssertEquals("Parseo del mensaje incorrecto.", alltrim(lcMensajeCorrecto), alltrim(lcMensajeTraducido))
		loParseador.release()
	endfunc

EndDefine
