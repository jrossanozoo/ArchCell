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


Return Createobject("rsAssertions")

**********************************************************************
Define Class rsAssertions As FxuAssertions Of FxuAssertions.prg
	**********************************************************************

	#IF .f.
		LOCAL this as FxuAssertions OF FxuAssertions.prg
	#ENDIF

	********************************************************************
	Function AssertNotEquals(tcMessage, tuItem1, tuItem2)
	********************************************************************

		Local llAssertNotEquals
		* Assume we do not equal unless otherwise determined
		llAssertNotEquals = .F.

		* Trap for no message passed
		If PCOUNT() = 2
			tuItem2 = tuItem1
			tuItem1 = tcMessage
			tcMessage = ""
		Endif
		* Determine if we are comparing objects or value types
		IF this.isObject(tuItem1) AND this.isObject(tuItem2)
			llAssertNotEquals = this.AssertNotEqualsObjects(tcMessage,tuItem1,tuItem2)
		ELSE
			llAssertNotEquals = this.AssertNotEqualsValues(tcMessage,tuItem1,tuItem2)
		ENDIF


		This.ilSuccess = llAssertNotEquals
		Return llAssertNotEquals

	********************************************************************
	Endfunc
	********************************************************************

	********************************************************************
	Function AssertNotEqualsValues(tcMessage, tuItem1, tuItem2)
	********************************************************************

		Local llAssertNotEqualsValues, llTypesMatch, lcItem1Type, lcItem2Type
		llAssertNotEqualsValues = .F.

		lcItem1Type = Vartype(tuItem1)
		lcItem2Type = Vartype(tuItem2)

		If lcItem1Type = lcItem2Type And tuItem1 == tuItem2
			This.ReportValuesEqual(tcMessage, tuItem1, tuItem2)
			Return llAssertNotEqualsValues
		Endif

		llAssertNotEqualsValues = .T.

		Return llAssertNotEqualsValues

	********************************************************************
	Endfunc
	********************************************************************

	********************************************************************
	FUNCTION AssertNotEqualsObjects(tcMessage, tuItem1, tuItem2)
	********************************************************************
	
		LOCAL llAssertNotEqualsObjects
		llAssertNotEqualsObjects = .f.
		
		IF COMPOBJ(tuItem1, tuItem2)
			this.ReportObjectsSame(tcMessage)
		ELSE
			llAssertEqualsObjects = .t.
		ENDIF
		
		RETURN llAssertEqualsObjects
	
	********************************************************************
	ENDFUNC
	********************************************************************

	********************************************************************
	FUNCTION AssertFalse(tcMessage, tuItem)
	********************************************************************
	
		LOCAL llAssertFalse
		llAssertFalse = .f.
		
		* Trap for no message passed
		IF PCOUNT() = 1
			tuItem = tcMessage
			tcMessage = ""
		ENDIF

		IF tuItem
			this.ReportAssertionTrue(tcMessage)
		ELSE
			llAssertFalse = .t.
		ENDIF
		
		this.ilSuccess = llAssertFalse
		RETURN llAssertFalse
	
	********************************************************************
	ENDFUNC
	********************************************************************
	
	********************************************************************
	FUNCTION AssertNull(tcMessage, tuItem)
	********************************************************************
	
		LOCAL llAssertNull
		llAssertNull = .f.
	
		* Trap for no message passed
		IF PCOUNT() = 1
			tuItem = tcMessage
			tcMessage = ""
		ENDIF
		
		IF !ISNULL(tuItem)
			this.ReportIsNotNull(tcMessage)
		ELSE
			llAssertNull = .t.
		ENDIF
		
		this.ilSuccess = llAssertNull
		
		RETURN llAssertNull
	
	********************************************************************
	ENDFUNC
	********************************************************************
	 
	********************************************************************
	FUNCTION AssertEmpty(tcMessage, tuItem)
	********************************************************************
	
		LOCAL llAssertEmpty
		llAssertEmpty = .f.
	
		* Trap for no message passed
		IF PCOUNT() = 1
			tuItem = tcMessage
			tcMessage = ""
		ENDIF
		
		IF !empty(tuItem)
			this.ReportIsNotEmpty(tcMessage)
		ELSE
			llAssertEmpty = .t.
		ENDIF
		
		this.ilSuccess = llAssertEmpty
		
		RETURN llAssertEmpty
	
	********************************************************************
	ENDFUNC
	********************************************************************

	********************************************************************
	FUNCTION AssertNotEmpty(tcMessage, tuItem)
	********************************************************************
	
		LOCAL llAssertNotEmpty
		llAssertNotEmpty = .f.
	
		* Trap for no message passed
		IF PCOUNT() = 1
			tuItem = tcMessage
			tcMessage = ""
		ENDIF
		
		IF empty(tuItem)
			this.ReportIsEmpty(tcMessage)
		ELSE
			llAssertNotEmpty = .t.
		ENDIF
		
		this.ilSuccess = llAssertNotEmpty
		
		RETURN llAssertNotEmpty
	
	********************************************************************
	ENDFUNC
	********************************************************************

	********************************************************************
	FUNCTION AssertObject(tcMessage, tuItem)
	********************************************************************
	
		LOCAL llAssertObject
		llAssertObject = .f.
	
		* Trap for no message passed
		IF PCOUNT() = 1
			tuItem = tcMessage
			tcMessage = ""
		ENDIF
	
		IF !this.isobject(tuItem)	
			this.ReportNotObject(tcMessage)
		ELSE
			llAssertObject = .T.
		endif
		
		this.ilSuccess = llAssertObject
		
		RETURN llAssertObject
	
	********************************************************************
	ENDFUNC
	********************************************************************

	********************************************************************
	Function ReportValuesEqual(tcMessage, tuItem1, tuItem2)
	********************************************************************

		Local lcValue1, lcValue2
		This.NewMessageDivider(.T.)
		This.AddMessage(tcMessage)
		This.AddMessage("Values Are Equal")
		This.AddMessage("Expected Value Other Than: " + Transform(tuItem1))
		This.AddMessage("Actual Value: " + Transform(tuItem2))

	********************************************************************
	Endfunc
	********************************************************************
	
	********************************************************************
	FUNCTION ReportObjectsSame(tcMessage)
	********************************************************************
	
		this.NewMessageDivider(.t.)
		this.AddMessage(tcMessage)
		this.AddMessage("Objects are the same")
		
	********************************************************************
	ENDFUNC
	********************************************************************
	
	********************************************************************
	FUNCTION ReportAssertionTrue(tcMessage)
	********************************************************************
	
		this.NewMessageDivider(.t.)
		this.AddMessage(tcMessage)
		this.AddMessage("AssertFalse Returned True")

	********************************************************************
	ENDFUNC
	********************************************************************
	
	********************************************************************
	FUNCTION ReportIsNotNull(tcMessage)
	********************************************************************
	
		this.NewMessageDivider(.t.)
		this.AddMessage(tcMessage)
		this.AddMessage("Item is Not Null")
	
	********************************************************************
	ENDFUNC
	********************************************************************

	********************************************************************
	FUNCTION ReportIsNotEmpty(tcMessage)
	********************************************************************
	
		this.NewMessageDivider(.t.)
		this.AddMessage(tcMessage)
		this.AddMessage("Item is Not Empty")
	
	********************************************************************
	ENDFUNC
	********************************************************************

	********************************************************************
	FUNCTION ReportIsEmpty(tcMessage)
	********************************************************************
	
		this.NewMessageDivider(.t.)
		this.AddMessage(tcMessage)
		this.AddMessage("Item is Empty")
	
	********************************************************************
	ENDFUNC
	********************************************************************

	********************************************************************
	FUNCTION ReportNotObject(tcMessage)
	********************************************************************
	
		this.NewMessageDivider(.t.)
		this.AddMessage(tcMessage)
		this.AddMessage("Item is Not an Object")
	
	********************************************************************
	ENDFUNC
	********************************************************************

**********************************************************************	
Enddefine && CLASS
**********************************************************************

