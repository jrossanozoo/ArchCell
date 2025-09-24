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

**********************************************************************
define class FxuTestResult as collection
	**********************************************************************

	#if .f.
		local this as FxuTestResult of FxuTestResult.prg
	#endif

	inRunTests = 0
	inTotalTests = 0
	inFailedTests = 0
	icFailureErrorDetails = ''
	ioExceptionInfo = .null.
	ioTeardownExceptionInfo = .null.
	ilCurrentResult = .t.
	icCurrentTestClass = ''
	icCurrentTestName = ''
	icCurrentResultPK = ''
	inCurrentStartSeconds = 0
	inCurrentEndSeconds = 0
	inCurrentStartTime = datetime()
	inCurrentEndTime = {}
	icMessages = ''
	lCorrioTest = .t.
	cRutaTest = ''

	********************************************************************
	function ResetCurrentResult
		********************************************************************
		with this
			.icFailureErrorDetails = ''
			.icMessages = ''
			.ilCurrentResult = .t.
			.icCurrentTestClass = ''
			.icCurrentTestName = ''
			.inFailedTests = 0
			.inCurrentStartSeconds = 0
			.inCurrentEndSeconds = 0
			.ioExceptionInfo = .null.
			.ioTeardownExceptionInfo = .null.
			.inCurrentStartTime = datetime()
			.inCurrentEndTime = {}
			.lCorrioTest = .t.
			.cRutaTest = ''
		endwith

		********************************************************************
	endfunc
	********************************************************************

	********************************************************************
	function LogException(toExceptionInfo, tlTearDownException)
		********************************************************************

		if empty(tlTearDownException)
			tlTearDownException = .f.
		else
			tlTearDownException = .t.
		endif

		this.ilCurrentResult = .f.

		if tlTearDownException
			this.ioTeardownExceptionInfo = toExceptionInfo
		else
			this.ioExceptionInfo = toExceptionInfo
		endif

		*this.LogDetail(this.BuildExceptionString(toException))
		this.LogDetail(toExceptionInfo.ToString())
		*this.icFailureErrorDetails = this.icFailureErrorDetails + this.BuildExceptionString(toException)

		********************************************************************
	endfunc
	********************************************************************


	********************************************************************
	function NewResult(tcClassName, tcTestName)
		********************************************************************

		this.ResetCurrentResult()
		this.icCurrentTestClass = tcClassName
		this.icCurrentTestName = tcTestName

		********************************************************************
	endfunc
	********************************************************************


	********************************************************************
	function LogResult()
		********************************************************************

		this.inRunTests = this.inRunTests + 1

		********************************************************************
	endfunc
	********************************************************************

	********************************************************************
	procedure LogDetail(tcDetail)
		********************************************************************

		if !empty(this.icFailureErrorDetails)
			this.icFailureErrorDetails = this.icFailureErrorDetails + chr(10)
		endif

		this.icFailureErrorDetails = this.icFailureErrorDetails + alltrim(tcDetail)

		********************************************************************
	endproc
	********************************************************************

	********************************************************************
	procedure LogMessage(tcMessage)
		********************************************************************

		if !empty(this.icMessages)
			this.icMessages = this.icMessages + chr(10)
		endif
		this.icMessages = this.icMessages + alltrim(tcMessage)

		********************************************************************
	endproc
	********************************************************************

	********************************************************************
	function BuildExceptionString(toException as exception)
		********************************************************************

		local lcException

		toException = this.ioException

		lcException = ("******** Error/Exception **********" + chr(10))

		lcException = (lcException + "An error occurred on line " + ;
			transform(toException.lineno) + " of " + ;
			toException.procedure + " .")

		lcException = lcException + (chr(10))

		lcException = lcException + ("Error Number: " + transform(toException.errorno))

		lcException = lcException + (chr(10))

		lcException = lcException + ("Error Message: " + toException.message)

		lcException = lcException + chr(10)

		lcException = lcException + ("******** Line Contents **********" + chr(10))

		lcException = lcException + (toException.linecontents + chr(10))

		lcException = lcException + ("*********************************" + chr(10))

		return lcException

		********************************************************************
	endfunc
	********************************************************************

	********************************************************************
	function EnumerateVarType(tcVarType)
		********************************************************************

		lcReturnType = "Unknown"

		lcVarType = upper(alltrim(tcVarType))

		do case

			case lcVarType == "C"
				lcReturnType = "Character"
			case lcVarType == "N"
				lcReturnType =	"Numeric"
			case lcVarType == "Y"
				lcReturnType = "Currency"
			case lcVarType == "L"
				lcReturnType = "Logical"
			case lcVarType == "O"
				lcReturnType = "Object"
			case lcVarType == "G"
				lcReturnType = "General"
			case lcVarType == "D"
				lcReturnType = "Date"
			case lcVarType == "T"
				lcReturnType = "DateTime "
			case lcVarType == "X"
				lcReturnType = "Null"

		endcase


		********************************************************************
	endfunc
	********************************************************************

	********************************************************************
	function SecondsElapsed as long
		********************************************************************
		return this.inCurrentEndSeconds - this.inCurrentStartSeconds
	endfunc



	**********************************************************************
enddefine && CLASS
**********************************************************************
