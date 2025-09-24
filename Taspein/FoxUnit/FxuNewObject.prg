***********************************************************************
*	FoxUnit is Copyright (c) 2004, Vision Data Solutions Inc.
*	All rights reserved.
*
*	Redistribution and use in source and binary forms, with or 
*	without modification, are permitted provided that the following 
*	conditions are met:
*
*		*	Redistributions of source code must retain the above
*			copyright notice, this list of conditions and the 
*			following disclaimer.
*
*		*	Redistributions in binary form must reproduce the above 
*			copyright notice, this list of conditions and the 
*			following disclaimer in the documentation and/or other 
*			materials provided with the distribution. 
*			
*		*	Neither the name of Vision Data Solutions Inc nor the
*			names of the FoxUnit contributors may be used to endorse
*			or promote products derived from this software without
*			specific prior written permission. 
*
*	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
*	"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
*	LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
*	FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
*	COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
*	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
*	BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
*	LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
*	CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
*	LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN 
*	ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
*	POSSIBILITY OF SUCH DAMAGE.     
***********************************************************************

*
*  FXUNewObject.PRG
*  This wrapper to the NEWOBJECT() function is a class
*  factory based on \FoxUnit\FXUClassFactory.DBF, called 
*  to instantiate one of the following:
*    - The indicated class in the indicated .VCX
*    - The indicated class in the indicated .PRG
*    - The indicated .SCX
*  and RETURNs an object reference to the indicated
*  object (or .NULL. if something goes wrong)
*
*  The idea here is that, rather than hardcode the class
*  and class library for the objects used in FoxUnit,
*  the class name and class library are instead specified
*  in the \FoxUnit\FXUClassFactory.DBF records.  So, if
*  you decide to modify FoxUnit to meet your needs, rather
*  than modifying the "official" FoxUnit code, you can
*  just subclass any FoxUnit classes and specify your 
*  subclass in the corresponding record of the
*  \FoxUnit\FXUClassFactory.DBF table.
*  To review this implementation in the FoxUnit code,
*  just use the VFP Code References tool to do a search
*  for "FXUNewObject" on the files in the \FoxUnit folder.
*  
*  The tcClassID parameter is REQUIRED, and specifies
*  the FXUClassFactory.ClassID field value -- the
*  class/.SCX in that FXUClassFactory record is 
*  instantiated here:
*    FXUClassFactory.DBF
*        ClassID - specifies a unique string identifier
*                  for the object to be instantiated
*      ClassName - specifies the name of the class to 
*                  be instantiated (if ClassLib is an
*                  .SCX filename, leave ClassName blank)
*       ClassLib - specifies the class library (.PRG or
*                  .VCX) to be instantiated -- we STRONGLY
*                  recommend that this class library be
*                  in your VFP path, but you can specify
*                  the full path if you want
*
*  NOTE that if the FXUClassFactory.ClassLib is an
*  .SCX filename (and FXUClassFactory.ClassName is
*  therefore blank/empty), the indicated form is
*  instantiated but then goes immediately out of
*  scope, so you should do something like this:
*    PUBLIC goForm
*    goForm = FXUNewObject("ClassID")
*    goForm.Show()
*
*  
*  USAGE
*  =============================================
*  LOCAL SomeObject
*  SomeObject = FXUNewObject("ClassID")
*  -OR-
*  LOCAL SomeObject
*  SomeObject = FXUNewObject("ClassID",InitParameter)
*  -OR-
*  LOCAL SomeObject
*  SomeObject = FXUNewObject("ClassID",InitParameter1,InitParameter2)
*
*
*  lParameters
*         tcClassID (R) FXUClassFactory.ClassID value, indicating
*                         the class/form to instantiate
*  tuInitParameter1 (O) First parameter passed to the Init of
*                         the class/form to instantiate
*  tuInitParameter2 (O) Second parameter passed to the Init of
*                         the class/form to instantiate
*
LPARAMETERS tcClassID as String, ;
            tuInitParameter1 as Variant, ;
            tuInitParameter2 as Variant

LOCAL loReturn, lcClassName, lcClassLib, lnPCount
loReturn = .NULL.
lnPCount = PCOUNT()

PRIVATE pcFXUNewObject_SetAsserts, pcFXUNewObject_Select
pcFXUNewObject_SetAsserts = SET("ASSERTS")
SET ASSERTS ON 
pcFXUNewObject_Select = SELECT(0)
     
IF NOT VARTYPE(m.tcClassID) = "C" OR EMPTY(m.tcClassID) 
  ASSERT .f. message "The required tcClassID parameter has not " + "been passed to FXUNewObject()"
  Cleanup()
  RETURN m.loReturn
ENDIF       
             
*
*  get the FXUClassFactory.DBF open
*            
IF NOT USED("FXUClassFactory")
  TRY
  USE FXUClassFactory IN 0 SHARED NOUPDATE
  CATCH TO loException
  ENDTRY
ENDIF
IF NOT USED("FXUClassFactory") AND VARTYPE(m.loException) = "O"
  ASSERT .f. message "Unable to open the FXUClassFactory.DBF table because " + CHR(13) + loException.Message
ENDIF
IF NOT USED("FXUClassFactory")
  Cleanup()
  RETURN m.loReturn
ENDIF

*
*  find the indicated record in FXUClassFactory.DBF
*
SELECT FXUClassFactory
LOCATE FOR UPPER(ALLTRIM(ClassID)) == UPPER(ALLTRIM(m.tcClassID))
IF NOT FOUND()
  ASSERT .f. message "Unable to locate the passed tcClassID: " + m.tcClassID + " in the FXUClassFactory.ClassID"
  Cleanup()
  RETURN .NULL.
ENDIF

*
*  instantiate the indicated object
*
lcClassName = UPPER(ALLTRIM(ClassName))
lcClassLib = UPPER(ALLTRIM(ClassLib))
IF EMPTY(m.lcClassName) 
  *
  *  ClassLib is expected to be an .SCX file
  *
	TRY
		DO CASE
			CASE m.lnPCount = 3
			  DO FORM (m.lcClassLib) WITH m.tuInitParameter1, m.tuInitParameter2

			CASE m.lnPCount = 2
			  DO FORM (m.lcClassLib) WITH m.tuInitParameter1

			OTHERWISE
			  DO FORM (m.lcClassLib)
		ENDCASE
	CATCH TO loException
		loReturn = .NULL.
	ENDTRY

	IF VARTYPE(m.lcClassName) = "O"
		loReturn = m.lcClassName
	ENDIF
else
	public plReintentaCrearObjeto
	plReintentaCrearObjeto = .t.

	lnSegundosInicio = seconds()
	lnSegundos = 0

	try
		do while (plReintentaCrearObjeto) and (lnSegundos <= 10)
			do case
				CASE lnPCount = 3
					loReturn = CrearObjeto(lcClassName, lcClassLib, "", tuInitParameter1, tuInitParameter2)

				CASE lnPCount = 2
					loReturn = CrearObjeto(lcClassName, lcClassLib, "", tuInitParameter1)

				OTHERWISE
					loReturn = CrearObjeto(lcClassName, lcClassLib)
			endcase

			lnSegundos = seconds() - lnSegundosInicio
		enddo
	CATCH TO loException
		loReturn = .NULL.
	ENDTRY
endif

if (loReturn = .Null.)
	if (vartype(loException) = "O")
		lcError = loException.Message
	else
		lcError = "No se pudo crear el objeto con reintentos en el lapso de tiempo estipulado (10 segundos)."
	endif
	
	assert .f. message "Unable to instantiate the requested " + m.tcClassID + " object. Error: " + CHR(13) + lcError
endif

Cleanup()
return loReturn

***********************************
procedure CrearObjeto(_className as String, _classLib as String, nothing as String, param1 as Variant, param2 as Variant) as Object
***********************************
	local retorno, lnCantParam
	lnCantParam = pcount()

	try
		do case
			case lnCantParam = 5
				retorno = NEWOBJECT(_className, _classLib, "", param1, param2)

			case lnCantParam = 4
				retorno = NEWOBJECT(_className, _classLib, "", param1)

			case lnCantParam = 2
				retorno = NEWOBJECT(_className, _classLib)

		endcase

		plReintentaCrearObjeto = .f.
	catch
		plReintentaCrearObjeto = .t.
		retorno = .null.
	endtry

	return retorno
endproc

***********************************
PROCEDURE Cleanup
***********************************
*
*  preserve the environment the way it was when
*  FXUNewObject() was called
*
USE IN SELECT("FXUClassFactory")
SET ASSERTS &pcFXUNewObject_SetAsserts
SELECT (m.pcFXUNewObject_Select)
RELEASE pcFXUNewObject_SetAsserts, pcFXUNewObject_Select
RETURN